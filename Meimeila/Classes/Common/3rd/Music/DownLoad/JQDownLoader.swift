//
//  JQDownLoader.swift
//  AudioPlayerDemo
//
//  Created by HJQ on 2017/11/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc enum JQDownLoaderState: NSInteger{
    
    case JQDownLoaderStateUnKnown
    /** 下载暂停 */
    case JQDownLoaderStatePause
    /** 正在下载 */
    case JQDownLoaderStateDowning
    /** 已经下载 */
    case JQDownLoaderStateSuccess
    /** 下载失败 */
    case JQDownLoaderStateFailed
}

typealias DownLoadInfoType = (_ fileSize: Double) -> ()
typealias DownLoadSuccessType = (_ cacheFilePath: String) -> ()
typealias DownLoadFailType = () -> ()
typealias DownLoadProgress = (_ progress: Float) -> ()


class JQDownLoader: NSObject {
    
    // 公共属性
    // 状态
    private(set) var state: JQDownLoaderState!
    
    // 进度
    private(set) var progress: Float = 0
    
    // 下载进度
    
    var downLoadProgress: DownLoadProgress?
    
    // 文件下载信息 (下载的大小)
    var downLoadInfo: DownLoadInfoType?
    
    // 状态的改变 ()
    typealias DownLoadStateChange = (_ state: JQDownLoaderState) -> ()
    var downLoadStateChange: DownLoadStateChange?
    
    // 下载成功 (成功路径)
    var downLoadSuccessType: DownLoadSuccessType?
    
    // 失败 (错误信息)
    var downLoadFailType: DownLoadFailType?
    
    // 私有属性
    // 临时文件的大小
    private var tmpFileSize: Double = 0
    // 文件总大小
    private var totalFileSize: Double = 0
    // 文件缓存路径
    private var cacheFilePath: String = ""
    // 文件临时缓存路径
    private var tmpFilePath: String = ""

    // 文件输入流
    private var outputStream: OutputStream?
    
    // 下载会话
    private var session: URLSession?
    
    // 下载任务
    private var task: URLSessionDataTask!
    // 下载链接
    private var url: URL!
    
    // MARK: - Lazy load
    // 设置当前文件的状态
    private func setState(tempState: JQDownLoaderState) {
        if state == tempState {
            return
        }
        state = tempState
        if let _ = downLoadStateChange {
            downLoadStateChange!(state)
        }
        // 通知下载进度
    }
    
    // 设置下载进度
    private func setProgress(tempProgress: Float) {
        progress = tempProgress
        if let _ = downLoadProgress {
            downLoadProgress!(progress)
        }
    }
    
}

// MARK: - URLSessionDataDelegate
extension JQDownLoader: URLSessionDataDelegate {
    /**
     当发送的请求, 第一次接受到响应的时候调用,
     
     @param completionHandler 系统传递给我们的一个回调代码块, 我们可以通过这个代码块, 来告诉系统,如何处理, 接下来的数据
     */
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Swift.Void) {
        
        let httpResponse = response as! HTTPURLResponse
        let allHeaderField = httpResponse.allHeaderFields["Content-Length"] as AnyObject
        totalFileSize = allHeaderField.doubleValue ?? 0
            //(httpResponse.allHeaderFields["Content-Length"] as AnyObject)
        if (httpResponse.allHeaderFields["Content-Range"] != nil)  {
            let rangeStr = httpResponse.allHeaderFields["Content-Range"] as! String
            totalFileSize = Double((rangeStr.components(separatedBy: "/").last)!)!
        }
        
        if let _ = downLoadInfo {
            downLoadInfo!(totalFileSize)
        }
        
        // 判断, 本地的缓存大小 与 文件的总大小
        // 缓存大小 == 文件的总大小 下载完成 -> 移动到下载完成的文件夹
        if tmpFileSize == totalFileSize {
            print("已经下载完成，可以移动文件")
            JQDownLoadFileTool.moveFile(fromPath: self.tmpFilePath, toPath: self.cacheFilePath)
            self.setState(tempState: JQDownLoaderState.JQDownLoaderStateSuccess)
            // 取消请求
            completionHandler(URLSession.ResponseDisposition.cancel)
            return
        }
        
        if tmpFileSize > totalFileSize {
            
            print("缓存有问题, 删除缓存, 重新下载")
            // 删除缓存
            JQDownLoadFileTool.removeFileAtPath(path: self.tmpFilePath)
            // 取消请求
            completionHandler(URLSession.ResponseDisposition.cancel)
            // 重新发送下载请求
            downLoadWithURL(url: response.url!, offset: 0)
            return
        }
        
         // 继续接收数据,什么都不要处理
        self.setState(tempState: JQDownLoaderState.JQDownLoaderStateDowning)
        self.outputStream = OutputStream.init(toFileAtPath: self.tmpFilePath, append: true)
        self.outputStream?.open()
        completionHandler(URLSession.ResponseDisposition.allow)
        
    }
    
    // 接收数据的时候调用
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        // 进度 = 当前下载的大小 / 总大小
        tmpFileSize += Double(data.count)
        let tempProgress = Float(1.0 * tmpFileSize / totalFileSize)
        self.setProgress(tempProgress: tempProgress)
        let bytes = data.withUnsafeBytes {
            [UInt8](UnsafeBufferPointer(start: $0, count: data.count))
        }
        print("当前下载进度" + "\(tempProgress)")
        self.outputStream?.write(bytes, maxLength: data.count)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        self.outputStream?.close()
        self.outputStream = nil
        
        if let _ = error { // 下载错误
            self.setState(tempState: JQDownLoaderState.JQDownLoaderStateFailed)
            if let _ = downLoadFailType {
                downLoadFailType!()
            }
        }else { // 下载成功
           JQDownLoadFileTool.moveFile(fromPath: self.tmpFilePath, toPath: self.cacheFilePath)
            self.setState(tempState: JQDownLoaderState.JQDownLoaderStateSuccess)
            if let _ = downLoadSuccessType {
                downLoadSuccessType!(self.cacheFilePath)
            }
        }
    }
    
}

// MARK: - Private method
extension JQDownLoader {
    
    private func downLoadWithURL(url: URL, offset: Double) {
        
        var request = URLRequest.init(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 0)
         request.setValue(String.init(format: "bytes=%lld-", offset), forHTTPHeaderField: "Range")

        self.session = URLSession.init(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = self.session!.dataTask(with: request)
        task.resume()
        self.task = task
    }
    
    // 获取缓存目录
    private  class func getCacheDir() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
    }
    
    // 获取暂存目录
    private class func getTempDir() -> String{
        return NSTemporaryDirectory()
    }
}

// MARK: - Public method
extension JQDownLoader {
    
    func downLoadWithURL(url: URL, progressBlock: DownLoadProgress?, success: @escaping DownLoadSuccessType, failed: @escaping DownLoadFailType) {
        
        self.downLoadProgress = progressBlock
        self.downLoadSuccessType = success
        self.downLoadFailType = failed
        
        downLoadWithURL(url: url)
    }
    
    // 如果当前已经下载, 继续下载, 如果没有下载, 从头开始下载
    func downLoadWithURL(url: URL){
        
        self.setState(tempState: JQDownLoaderState.JQDownLoaderStateUnKnown)
        self.url = url
        
        // 1. 下载文件的存储
        //    下载中 -> tmp + (url + MD5)
        //    下载完成 -> cache + url.lastCompent
        self.cacheFilePath = (URL.init(string: JQDownLoader.getCacheDir())?.appendingPathComponent(url.lastPathComponent).absoluteString)!
        // 需要追加md5 url.absoluteString
        self.tmpFilePath = (URL.init(string: JQDownLoader.getTempDir())?.appendingPathComponent(url.absoluteString.jqDownload_MD5()!).absoluteString)!
      
        // 1 首先, 判断, 本地有没有已经下载好, 已经下载完毕, 就直接返回
        // 文件的位置, 文件的大小
        if JQDownLoadFileTool.isFileExists(path: self.cacheFilePath) {
           print("文件已经下载完毕, 直接返回相应的数据--文件的具体路径, 文件的大小")
            if let _ = downLoadInfo {
                downLoadInfo!(Double(JQDownLoadFileTool.fileSizeWithPath(path: self.cacheFilePath)))
            }
            
            self.setState(tempState: JQDownLoaderState.JQDownLoaderStateSuccess)
            
            if let _ = downLoadSuccessType {
                downLoadSuccessType!(self.cacheFilePath)
            }

            return
        }
        
        // 验证: 如果当前任务不存在 -> 开启任务
        if let _ = self.task {
            if url == self.task.originalRequest?.url {
                // 任务存在 -> 状态
                // 状态 -> 正在下载 返回
                if state == JQDownLoaderState.JQDownLoaderStateDowning {
                    return
                }
                
                // 状态 -> 暂停 = 恢复
                if state == JQDownLoaderState.JQDownLoaderStatePause {
                    self.resume()
                    return
                }
            }
        }

        
        // 任务不存在, url不一样
        print("继续接收数据")
        self.cancel()
        // 2. 读取本地的缓存大小
        tmpFileSize = Double(JQDownLoadFileTool.fileSizeWithPath(path: self.tmpFilePath))
        downLoadWithURL(url: url, offset: tmpFileSize)
        
    }
    
    class func downLoadedFileWithURL(url: URL) -> String? {
        let cachePath = URL.init(string: getCacheDir())?.appendingPathComponent(url.lastPathComponent).absoluteString
        if JQDownLoadFileTool.isFileExists(path: cachePath!) {
            return cachePath
        }
        return nil
    }
    
    class func tmpCacheSizeWithURL(url: URL) -> UInt64 {
        let tmpFileMD5 = url.absoluteString.jqDownload_MD5()
        let tempPath = URL.init(string: getTempDir())?.appendingPathComponent(tmpFileMD5!).absoluteString
        return JQDownLoadFileTool.fileSizeWithPath(path: tempPath!)
    }
    
    class func clearCacheWithURL(url: URL) {
        let cachePath = URL.init(string: getCacheDir())?.appendingPathComponent(url.lastPathComponent).absoluteString
        JQDownLoadFileTool.removeFileAtPath(path: cachePath!)
        
    }
    
    
    class func isFileExist(url:URL) -> Bool{
        let cachePath = URL.init(string: getCacheDir())?.appendingPathComponent(url.lastPathComponent).absoluteString
      return JQDownLoadFileTool.isFileExists(path: cachePath!);
    }
    
    
    // 恢复下载
    func resume() {
        if state == .JQDownLoaderStatePause {
            self.task.resume()
            self.setState(tempState: .JQDownLoaderStateDowning)
        }
    }
    // 暂停, 暂停任务, 可以恢复, 缓存没有删除
    func pause() {
        if state == JQDownLoaderState.JQDownLoaderStateDowning {
            self.task.suspend()
            self.setState(tempState: .JQDownLoaderStatePause)
        }
    }
    // 取消
    func cancel() {
        if let _ = self.session {
            self.session?.invalidateAndCancel()
            self.session = nil
        }
    }
    // 缓存删除
    func cancelAndClearCache() {
        self.cancel()
        JQDownLoadFileTool.removeFileAtPath(path: self.tmpFilePath)
    }
}

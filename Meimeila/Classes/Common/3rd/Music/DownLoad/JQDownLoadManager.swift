//
//  JQDownLoadManager.swift
//  AudioPlayerDemo
//
//  Created by HJQ on 2017/11/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit


class JQDownLoadManager: NSObject {
    
    // 单例
    static let shared = JQDownLoadManager()
    private override init() {}
    
    private var downLoadInfoDict: [String: JQDownLoader] =  [String: JQDownLoader] ()

}

// MARK: - Pulic method
extension JQDownLoadManager {
    
    // 根据URL下载资源
    func downLoadWithURL(url: URL) -> JQDownLoader{
        let md5: String = url.absoluteString.jqDownload_MD5()!
        
        var downLoader = self.downLoadInfoDict[md5]
        if let _ = downLoader {
            downLoader?.resume()
            return downLoader!
        }
        downLoader = JQDownLoader()
        self.downLoadInfoDict[md5] = downLoader
        
        downLoader?.downLoadWithURL(url: url, progressBlock: nil, success: { [weak self](cacheFilePath) in
            self?.downLoadInfoDict.removeValue(forKey: md5)
        }, failed: {[weak self] in
            self?.downLoadInfoDict.removeValue(forKey: md5)
        })
        return downLoader!
    }
    
    // 获取url对应的downLoader
    func getDownLoaderWithURL(url: URL) -> JQDownLoader?{
        let md5: String = url.absoluteString.jqDownload_MD5()!
        let downLoader = self.downLoadInfoDict[md5]
        return downLoader
    }
    
    // 根据URL下载资源
    // 监听下载信息, 成功, 失败回调
    func downLoadWithURL(url: URL, progressBlock: DownLoadProgress?, success: @escaping DownLoadSuccessType, failed: @escaping DownLoadFailType) {
        
        let md5: String = url.absoluteString.jqDownload_MD5()!
        
        var downLoader = self.downLoadInfoDict[md5]
        if let _ = downLoader {
            downLoader?.resume()
            return
        }
        downLoader = JQDownLoader()
        self.downLoadInfoDict[md5] = downLoader
        
        downLoader?.downLoadWithURL(url: url, progressBlock: progressBlock, success: { [weak self](cacheFilePath) in
            self?.downLoadInfoDict.removeValue(forKey: md5)
            success(cacheFilePath)
            
        }, failed: {[weak self] in
            self?.downLoadInfoDict.removeValue(forKey: md5)
            failed()
        })
        return
        
    }
    
    
    // 根据URL暂停资源
    func pauseWithURL(url: URL) {
        let md5: String = url.absoluteString.jqDownload_MD5()!
        let downLoader = self.downLoadInfoDict[md5]
        guard let _ = downLoader else {return}
        downLoader?.pause()
    }
    
    // 根据URL取消资源
    func cancelWithURL(url: URL) {
        let md5: String = url.absoluteString.jqDownload_MD5()!
        let downLoader = self.downLoadInfoDict[md5]
        guard let _ = downLoader else {return}
        downLoader?.cancel()
    }
    func cancelAndClearWithURL(url: URL) {
        let md5: String = url.absoluteString.jqDownload_MD5()!
        let downLoader = self.downLoadInfoDict[md5]
        guard let _ = downLoader else {return}
        downLoader?.cancelAndClearCache()
    }
    
    // 暂停所有
    func pauseAll() {
        downLoadInfoDict.values.forEach { (downLoader) in
            downLoader.pause()
        }
    }
    
    // 恢复所有
    func resumeAll() {
        downLoadInfoDict.values.forEach { (downLoader) in
            downLoader.resume()
        }
    }
    
    // 根据url移除本地缓存
    func clearCacheWithURL(url: URL) {
        JQDownLoader.clearCacheWithURL(url: url)
    }
    
    func isFileExist(url:URL) -> Bool {
        
        return JQDownLoader.isFileExist(url:url);
    }
}

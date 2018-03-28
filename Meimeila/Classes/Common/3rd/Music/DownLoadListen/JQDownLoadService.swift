//
//  JQDownLoadService.swift
//  AudioPlayerDemo
//
//  Created by HJQ on 2017/11/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol JQDownLoadServiceDelegate{
    
    func downLoadSucceedsfilePath(filePath:String?)
}

// 根据模型下载音乐
class JQDownLoadService: NSObject {

    static let shared = JQDownLoadService()
    private override init() {}
    
    weak var delegate:JQDownLoadServiceDelegate?
    // 下载
    class func downLoadVoiceM(model: JQDownLoadVoiceModel) {
        
        // 1. 创建本地缓存, 记录已经下载的数据记录
        
        
        // 2. 执行下载操作
        JQDownLoadManager.shared.downLoadWithURL(url: URL.init(string: model.downloadUrl)!, progressBlock: { (progress) in
            
        }, success: {(filePath) in
            // 更新本地状态
            print("下载成功")
            // 当下载状态发生变化时, 告知外界, 外界可以更新显示列表（通知）
            shared.delegate?.downLoadSucceedsfilePath(filePath: filePath);
            
        }) {
            shared.delegate?.downLoadSucceedsfilePath(filePath: nil)
            print("下载失败")
        }
    }
    
    // 暂停
    class func pauseVoiceM(model: JQDownLoadVoiceModel) {
        JQDownLoadManager.shared.pauseWithURL(url: URL.init(string: model.downloadUrl)!)
    }
    
    // 取消下载
    class func stopVoiceM(model: JQDownLoadVoiceModel) {
        JQDownLoadManager.shared.cancelWithURL(url: URL.init(string: model.downloadUrl)!)
    }
    
    // 删除本地缓存
    class func removeVoiceM(model: JQDownLoadVoiceModel) {
        JQDownLoadManager.shared.clearCacheWithURL(url: URL.init(string: model.downloadUrl)!)
    }
    
    // 查找本地文件
    func isFileExist(model: JQDownLoadVoiceModel) -> Bool{
        
       return JQDownLoadManager.shared.isFileExist(url:URL.init(string: model.downloadUrl)!)
    }
    
}

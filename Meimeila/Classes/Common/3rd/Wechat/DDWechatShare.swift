//
//  DDWechatShare.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/10.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation


class DDWechatShare {
    
    static let shared = DDWechatShare()
    private init() {}
    
    
    // 是否安装了微信客户端
    func isWXAppInstalled() -> Bool {
        return WXApi.isWXAppInstalled()
    }
    
    /// 微信分享
    ///
    /// - Parameters:
    ///   - title: 分享的标题
    ///   - description: 分享的描述
    ///   - image: 分享的缩略图
    ///   - webpageUrl: 链接
    ///   - type: 0 聊天页面 1朋友圈
    func shareAction(title: String, description: String, image: UIImage, webpageUrl: String, type: Int32) {
        
        let message =  WXMediaMessage()
        message.title = title
        message.description = description
        message.setThumbImage(image)
        
        let ext =  WXWebpageObject()
        ext.webpageUrl = webpageUrl
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = type
        WXApi.send(req)
    }
}

//
//  MMLUMengShareTool.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum UMShareType: NSInteger {
    case qq = 0
    case qzone
    case sina
    case wechatLine
    case wechat
    case copy
}

class MMLUMengShareTool {
    
    static let shared = MMLUMengShareTool()
    private init() {}
    
    func showShareType(type: UMShareType, object: MMLShareWebpageObject, currentViewController: UIViewController, shareSuccessBlock: @escaping ()->(), shareFailureBlock: @escaping () -> ()) {
        let messageObject = UMSocialMessageObject.init()
        let shareObject: UMShareWebpageObject = UMShareWebpageObject.shareObject(withTitle: object.title, descr: object.desStr, thumImage: object.image)
        shareObject.webpageUrl =  object.webpageUrl
        messageObject.shareObject = shareObject
        
        switch type {
        case .qq:
            UMSocialManager.default().share(to: UMSocialPlatformType.QQ, messageObject: messageObject, currentViewController: currentViewController, completion: { (result, error) in
                
                if let _ = error {
                    shareFailureBlock()
                }else {
                    if (result as AnyObject).isKind(of: UMSocialShareResponse.self) {
                        let data: UMSocialShareResponse = result as! UMSocialShareResponse
                        BFunction.shared.showToastMessge(data.message)
                        // 返回第三方的原始数据
                        debugLog(data.originalResponse)
                    }else {
                        debugLog(result)
                    }
                    shareSuccessBlock()
                }
            })
            break
        case .qzone:
            UMSocialManager.default().share(to: UMSocialPlatformType.qzone, messageObject: messageObject, currentViewController: currentViewController, completion: { (result, error) in
                if let _ = error {
                    shareFailureBlock()
                }else {
                    if (result as AnyObject).isKind(of: UMSocialShareResponse.self) {
                        let data: UMSocialShareResponse = result as! UMSocialShareResponse
                        BFunction.shared.showToastMessge(data.message)
                        // 返回第三方的原始数据
                        debugLog(data.originalResponse)
                    }else {
                        debugLog(result)
                    }
                    shareSuccessBlock()
                }
            })
            break
        case .sina:
            UMSocialManager.default().share(to: UMSocialPlatformType.sina, messageObject: messageObject, currentViewController: currentViewController, completion: { (result, error) in
                if let _ = error {
                    shareFailureBlock()
                }else {
                    if (result as AnyObject).isKind(of: UMSocialShareResponse.self) {
                        let data: UMSocialShareResponse = result as! UMSocialShareResponse
                        BFunction.shared.showToastMessge(data.message)
                        // 返回第三方的原始数据
                        debugLog(data.originalResponse)
                    }else {
                        debugLog(result)
                    }
                    shareSuccessBlock()
                }
            })
            break
        case .wechat:
            UMSocialManager.default().share(to: UMSocialPlatformType.wechatSession, messageObject: messageObject, currentViewController: currentViewController, completion: { (result, error) in
                if let _ = error {
                    shareFailureBlock()
                }else {
                    if (result as AnyObject).isKind(of: UMSocialShareResponse.self) {
                        let data: UMSocialShareResponse = result as! UMSocialShareResponse
                        BFunction.shared.showToastMessge(data.message)
                        // 返回第三方的原始数据
                        debugLog(data.originalResponse)
                    }else {
                        debugLog(result)
                    }
                    shareSuccessBlock()
                }
                
            })
            break
        case .wechatLine:
            UMSocialManager.default().share(to: UMSocialPlatformType.wechatTimeLine, messageObject: messageObject, currentViewController: currentViewController, completion: { (result, error) in
                if let _ = error {
                    shareFailureBlock()
                }else {
                    if (result as AnyObject).isKind(of: UMSocialShareResponse.self) {
                        let data: UMSocialShareResponse = result as! UMSocialShareResponse
                        BFunction.shared.showToastMessge(data.message)
                        // 返回第三方的原始数据
                        debugLog(data.originalResponse)
                    }else {
                        debugLog(result)
                    }
                    shareSuccessBlock()
                }
                
            })
            break
        case .copy:
            UIPasteboard.general.string = object.webpageUrl
            BFunction.shared.showToastMessge("复制成功")
            break
        }
    }

}

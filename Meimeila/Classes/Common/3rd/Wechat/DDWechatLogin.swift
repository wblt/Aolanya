//
//  DDWechatLogin.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/10.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation

class DDWechatLogin {
    static let shared = DDWechatLogin()
    private init() {}
    
    typealias DDWechatLoginCallBack = (_ openid: String, _ access_token: String, _ result: Any) -> ()
    private var loginCallBack: DDWechatLoginCallBack?
    
    
    // 是否安装了微信客户端
    func isWXAppInstalled() -> Bool {
        return WXApi.isWXAppInstalled()
    }
    
    // 调取微信登录
    func loginAction(callBack: @escaping DDWechatLoginCallBack) {
        loginCallBack = callBack
        let urlStr = "weixin://"
        if UIApplication.shared.canOpenURL(URL.init(string: urlStr)!) {
            let red = SendAuthReq.init()
            red.scope = "snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"
            red.state = "\(arc4random()%100)"
            WXApi.send(red)
        }else{
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL.init(string: "http://weixin.qq.com/r/qUQVDfDEVK0rrbRu9xG7")!, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(URL.init(string: "http://weixin.qq.com/r/qUQVDfDEVK0rrbRu9xG7")!)
            }
        }
        
    }
    
    // 添加通知监听回调结果
    func wxchat_addObserver() {
        NotificationCenter.default.addObserver(self,selector: #selector(DDWechatLogin.shared.WXLoginSuccess(notification:)),name: NSNotification.Name(rawValue: "WXLoginSuccessNotification"),object: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    
    /**  微信通知  */
    @objc func WXLoginSuccess(notification: Notification) {
        
        let code = notification.object as! String
        let requestUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(WX_APPID)&secret=\(WX_APPSecret)&code=\(code)&grant_type=authorization_code"
        
        DispatchQueue.global().async {
            
            let requestURL: URL = URL.init(string: requestUrl)!
            let data = try? Data.init(contentsOf: requestURL, options: Data.ReadingOptions())
            
            DispatchQueue.main.async {
                let jsonResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                let openid: String = jsonResult["openid"] as! String
                let access_token: String = jsonResult["access_token"] as! String
                self.getUserInfo(openid: openid, access_token: access_token)
            }
        }
    }
    
    /**  获取用户信息  */
    func getUserInfo(openid: String, access_token: String) {
        let requestUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=\(access_token)&openid=\(openid)"
       
        DispatchQueue.global().async {
            let requestURL: URL = URL.init(string: requestUrl)!
            let data = try? Data.init(contentsOf: requestURL, options: Data.ReadingOptions())
            
            DispatchQueue.main.async {
                let jsonResult = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                print(jsonResult)
                
                if let _ = self.loginCallBack {
                    self.loginCallBack!(openid, access_token, jsonResult)
                }
                
            }
        }
    }
}

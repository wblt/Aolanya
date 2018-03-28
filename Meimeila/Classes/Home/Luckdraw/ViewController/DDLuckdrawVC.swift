//
//  DDLuckdrawVC.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import WebKit

class DDLuckdrawVC: DDBaseWebViewVC {

    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: DDLuckdrawVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
    }

    override func setupUI() {
        
        addNavBarRightButton(btnTitle: "中奖纪录", titleColor: UIColor.white) { (bt) in
            let vc = MMLLuckGiftVC();
            vc.title = "我的奖品";
            self.navigationController?.pushViewController(vc, animated: true);
            
        }
    }
    
    // MARK: - Private method
    func login() {
        // 这个方法一定要加载完成时调用
        let uid = DDUDManager.share.getUserID()
        let token = DDUDManager.share.userToken()
        let method = "javascript:javaCallJs('\(uid)','\(token)');"
       // let method = String.init(format: "javascript:islogin('%@','%@');",uid, token)
        webView.evaluateJavaScript(method) { (data, error) in
            debugLog(error)
        }
    }
    
    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.webView(webView, didFinish: navigation)
        login()
    }
    
    
    // js 调用下面这个方法才会走 window.webkit.messageHandlers.NativeMethod.postMessage("我要调用native的方法")
    override  func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        
        if message.name == "DigitalCampusWebApp" {
            
            debugLog("\(message.body)")
            
            if let body = message.body as? String{
                
                if body == "login" { // 手机端登录
                    let vc = MMLLoginVC()
                    vc.delegate = self
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

// MARK: - WKUIDelegate
extension DDLuckdrawVC: WKUIDelegate {
    
    // 监听通过JS调用警告框
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    // 监听通过JS调用提示框
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler(true)
        }))
//        alert.addAction(UIAlertAction(title: "取消", style: .default, handler: { (action) in
//            completionHandler(false)
//        }))
        present(alert, animated: true, completion: nil)
    }
}

 // MARK: - MMLLoginVCDeleagate
extension DDLuckdrawVC: MMLLoginVCDeleagate {
    func loginVCFinish() {
        login()
    }
}


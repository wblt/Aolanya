//
//  DDWKWebViewDelegateVC.swift
//  Mythsbears
//
//  Created by HJQ on 2017/11/10.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import WebKit

// 这个会产生循环引用的问题，需要提前移除不能deinit中移除
//userContentController.removeScriptMessageHandler(forName: "DigitalCampusWebApp")
@objc protocol DDWKWebViewDelegateVCDelegate {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage);
}

class DDWKWebViewDelegateVC: UIViewController {

    weak var delegate: DDWKWebViewDelegateVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - WKScriptMessageHandler
extension DDWKWebViewDelegateVC: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let _ = delegate {
            delegate?.userContentController(userContentController: userContentController, didReceiveScriptMessage: message)
        }
    }
}

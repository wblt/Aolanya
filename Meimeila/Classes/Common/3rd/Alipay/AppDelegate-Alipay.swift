//
//  AppDelegate-Alipay.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/11.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    func alipay_application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) {
        alipay_processOrderPaymentResult(url: url)
    }
    
    // 9.0以后使用新API接口
    func alipay_application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) {
        alipay_processOrderPaymentResult(url: url)
    }
}

extension AppDelegate {
    // 处理支付宝支付的回调结果
    fileprivate func alipay_processOrderPaymentResult(url: URL) {
        AlipaySDK.defaultService().processOrder(withPaymentResult: url) { (result) in
            debugLog(result)
			
			debugLog("支付宝支付11111")
            Barista.post(notification: .aliPayResult, object: result as AnyObject)
        }
		
//		AlipaySDK.defaultService().processOrder(withPaymentResult: url) { (result) in
//			debugLog(result)
//
//			debugLog("支付宝支付11111")
//			Barista.post(notification: .aliPayResult, object: result as AnyObject)
//		}
		

        AlipaySDK.defaultService().processAuth_V2Result(url) { (result) in
            // 解析 auth code
            if let _ = result {
                let resultStr = result!["result"] as! String
                var authCode = ""
                if resultStr.count > 0 {
                    let resultArray = resultStr.components(separatedBy: "&")
                    for subResult in resultArray {
                        if subResult.count > 10 && subResult.hasPrefix("auth_code=") {
                            authCode = subResult.substringToIndex(10)!
                            break
                        }
                    }
                }
                debugLog("result = " + authCode)
				debugLog("支付宝支付2222")
                Barista.post(notification: .aliPayResult, object: result as AnyObject)
            }

        }
    }
}

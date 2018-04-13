//
//  DDAliPay.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/11.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class DDAliPay {
    
    static let shared = DDAliPay()
    private init() {}
    
    // 支付宝支付
    func payAction(orderStr: String, successBlock:@escaping (_ result: [AnyHashable: Any]) -> ()) {
        AlipaySDK.defaultService().payOrder(orderStr, fromScheme: "com.welcare.aolaiya") { (response) in
            successBlock(response ?? [AnyHashable: Any]())
        }
    
    }

}

//
//  DDWechatPay.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/10.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation

class DDWechatPay {
    
    static let shared = DDWechatPay()
    private init() {}
    
    // 是否安装了微信客户端
    func isWXAppInstalled() -> Bool {
        return WXApi.isWXAppInstalled()
    }
    
    // 微信支付
    func payAction(payModel: DDWechatPayModel) {
        
        let payRep = PayReq.init()
        payRep.openID = payModel.appid
        payRep.partnerId = payModel.partnerid
        payRep.prepayId = payModel.prepayid
        payRep.nonceStr = payModel.noncestr
        payRep.timeStamp = UInt32(payModel.timestamp)
        payRep.package = payModel.package
        payRep.sign = payModel.sign
        WXApi.send(payRep)
    }
}

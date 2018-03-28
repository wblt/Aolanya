//
//  MMLSettlementViewModel.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class MMLSettlementViewModel {

    
    var defaultAddressModel: MMLDefaultAddressModel?
    var wechatPayModel: DDWechatPayModel! // 微信支付需要的信息
    var aliPayModel: MMLSettlementAlipayModel!
    
    
    // 获取默认地址
    func getDefaultAddress(successBlock: @escaping () -> ()) {
        DDHTTPRequest.request(r: SettlementAPI.defaultAddress(), requestSuccess: { (result) in
            
            self.defaultAddressModel = MMLDefaultAddressModel.init(fromJson: JSON.init(result))
            successBlock()
            
        }, requestError: { (result, errorModel) in
            
        }) { (error) in
            
        }
    }
    
    // 支付宝下单
    func placeAliPayOrder(orders: String, addressID: String, invoice: String,successBlock: @escaping () -> ()) {
        let request = SettlementAPI.aliPay(orders: orders, addressID: addressID,invoice: invoice)
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            
            print(result);
            
            self.aliPayModel = MMLSettlementAlipayModel.init(fromJson: JSON.init(result))
            successBlock()
        }, requestError: { (result, errorModel) in
            BFunction.shared.showToastMessge(errorModel.message)
        }) { (error) in
            
        }
    }
    
    // 微信下单
    func placewechatPayOrder(orders: String, addressID: String,invoice:String, successBlock: @escaping () -> ()) {
        let request = SettlementAPI.wechatPay(orders: orders, addressID: addressID,invoice: invoice)
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            let jsonData = JSON.init(result)["getWechaPay"]
            self.wechatPayModel = DDWechatPayModel.init(fromJson: jsonData)
            successBlock()
        }, requestError: { (result, errorModel) in
             BFunction.shared.showToastMessge(errorModel.message)
        }) { (error) in
            
        }
    }
    
}

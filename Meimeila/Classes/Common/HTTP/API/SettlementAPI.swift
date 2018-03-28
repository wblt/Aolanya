//
//  SettlementAPI.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// 商品结算页
enum SettlementAPI {
    // 支付宝
    case aliPay(orders: String, addressID: String ,invoice:String)
    case wechatPay(orders: String, addressID: String, invoice:String)
    case defaultAddress()

}

extension SettlementAPI: Request {
    
    var path: String {
        switch self {
        case .aliPay(orders: _, addressID: _, invoice: _):
            return API.getAlipayOrders

        case .wechatPay(orders: _, addressID: _, invoice: _):
            return API.getWechapayOrders
            
        case .defaultAddress():
            return API.getDefaultAddress
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .aliPay(let orders, let addressID, let invoice):
            var params = postParameters()
            params["orders"] = orders
            params["orderType"] = 1
            params["orderSource"] = "iOS APP"
            params["adressID"] = addressID
            params["invoice"] = invoice
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
            
        case .wechatPay(let orders, let addressID, let invoice):
            var params = postParameters()
            params["orders"] = orders
            params["orderType"] = 1
            params["orderSource"] = "iOS APP"
            params["adressID"] = addressID
            params["invoice"] = invoice
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        case .defaultAddress:
            let params = postParameters()
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        }
    }
    
    
}

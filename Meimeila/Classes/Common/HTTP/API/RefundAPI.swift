//
//  RefundAPI.swift
//  Mythsbears
//
//  Created by macos on 2017/11/7.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum RefundAPI{

    case refundCash_weChatPay(orderID:String)
    case refundCash_aliPay(orderID:String)
    
    
    
}

extension RefundAPI:Request{
    var path: String {
        switch self {
        case .refundCash_aliPay(orderID: _):
            return API.refundCash_aliPayAPI
        case .refundCash_weChatPay(orderID: _):
            return API.refundCash_weChatPayAPI
        }
    }
    
    var parameters: [String : Any]?{
        
        switch self {
        case .refundCash_aliPay(let orderID):
            var parameter = postParameters();
            parameter["orderID"] = orderID;
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true);
        case .refundCash_weChatPay(let orderID):
            var parameter = postParameters();
            parameter["orderID"] = orderID;

            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true);
        }
    }
    
    
}

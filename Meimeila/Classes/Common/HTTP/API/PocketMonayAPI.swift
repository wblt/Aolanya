//
//  PocketMonayAPI.swift
//  Mythsbears
//
//  Created by macos on 2017/11/1.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum PocketMonayAPI {

    case moneyBalance
   
    // 支付宝
    case moneyRecharge_aliPay(orderID: String?, orderPrice: String,type:Int,invoice:String?)
    case moneyRecharge_weChatPay(orderID: String?, orderPrice: String,type:Int,invoice:String?)
	
	case wechatPayForPack(moneyNum: String)
    case aliPayForPack(moneyNum: String)
	
}

extension PocketMonayAPI:Request{
    var path: String {
        switch self {
        case .moneyBalance:
            return API.moneyBalanceAPI
        
        case . moneyRecharge_aliPay:
            return API.getAlipayOrders
            
        case . moneyRecharge_weChatPay:
            return API.moneyRechargeAPI
			
		case .wechatPayForPack(moneyNum: _):
			return API.getWechapayOrders
        case .aliPayForPack(moneyNum: _):
            return API.getAlipayOrders
        }
    }
    
    var parameters: [String : Any]?{
        
        switch self {
        case .moneyBalance:
            let param =  postParameters()
            return DDIntegrationOfTheParameter(params: param ,isNeedLogin: true);
        case .moneyRecharge_aliPay(let orderID, let orderPrice,let type,let invoice):
            var params = postParameters()

            if let _ = orderID{

                params["orderID"] = orderID!

            }

            if let _ = invoice{

                params["invoice"] = invoice!
            }

            params["app_key"] = kApp_key;
            params["orderType"] = type
            params["orderSource"] = "iOS APP"
            params["orderPrice"] = orderPrice
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        case .moneyRecharge_weChatPay(let orderID, let orderPrice,let type,let invoice):
            var params = postParameters()
            if let _ = orderID{
                
                params["orderID"] = orderID!
                
            }
            
            if let _ = invoice{
                
                params["invoice"] = invoice!
            }
            params["app_key"] = kApp_key;
            params["orderType"] = type
            params["orderSource"] = "iOS APP"
            params["orderPrice"] = orderPrice
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
			
		case .wechatPayForPack(let moneyNum):
			var params = postParameters()
			params["orderPrice"] = moneyNum
			params["orderType"] = "2"
			params["orderSource"] = "iOS APP"
			return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        case .aliPayForPack(let moneyNum):
            var params = postParameters()
            params["toalPrice"] = moneyNum
            params["orderType"] = "1"
            params["orderSource"] = "iOS APP"
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        }
        
        
        
    }
    
    
}

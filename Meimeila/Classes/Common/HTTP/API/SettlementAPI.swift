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
    case aliPay(orders: String, addressID: String ,invoice:String,total:String)
    case wechatPay(orders: String, addressID: String, invoice:String,total:String)
	case wechatPayForPack(moneyNum: String)
    case defaultAddress()
	case getpayqrcode(inviterId: String)
	
	case payOrdersAgent(orders: String, addressID: String ,invoice:String,total:String,orderType:String,paymentNumber:String,paymentImg:UIImage)
}

extension SettlementAPI: Request {
    
    var path: String {
        switch self {
        case .aliPay(orders: _, addressID: _, invoice: _,total:_):
            return API.getAlipayOrders

		case .wechatPay(orders: _, addressID: _, invoice: _,total:_):
            return API.getWechapayOrders
            
        case .defaultAddress():
            return API.getDefaultAddress
		case .wechatPayForPack(moneyNum: _):
			return API.getWechapayOrders
		case .getpayqrcode(inviterId:_):
			return API.getpayqrcode
		case .payOrdersAgent(orders: _, addressID: _, invoice: _, total: _, orderType: _, paymentNumber: _, paymentImg: _):
			return API.payOrdersAgent
		}
		
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .aliPay(let orders, let addressID, let invoice,let total):
            var params = postParameters()
            params["orders"] = orders
            params["orderType"] = "1"
            params["orderSource"] = "iOS APP"
            params["adressID"] = addressID
            params["invoice"] = invoice
			params["toalPrice"] = total
			params["discountMsg"] = "[]" // 暂时没有打折、 写死
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
            
        case .wechatPay(let orders, let addressID, let invoice,let total):
            var params = postParameters()
            params["orders"] = orders
            params["orderType"] = "2"
            params["orderSource"] = "iOS APP"
            params["adressID"] = addressID
            params["invoice"] = invoice
			params["toalPrice"] = total
			params["discountMsg"] = "[]" // 暂时没有打折、 写死
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        case .defaultAddress:
            let params = postParameters()
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
		case .wechatPayForPack(let moneyNum):
			var params = postParameters()
			params["orderPrice"] = moneyNum
			params["orderType"] = "2"
			params["orderSource"] = "iOS APP"
			return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
			
		case .getpayqrcode(let inviterId):
			var params = postParameters()
			params["inviter"] = inviterId
			return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
		case .payOrdersAgent(let orders, let addressID, let invoice, let total, let orderType, let paymentNumber, let paymentImg):
			
			var params = postParameters()
			params["orders"] = orders
			params["orderType"] = orderType
			params["orderSource"] = "iOS APP"
			params["adressID"] = addressID
			params["invoice"] = invoice
			params["toalPrice"] = total
			params["discountMsg"] = "[]" // 暂时没有打折、 写死
			
			params["paymentNumber"] = paymentNumber
			params["paymentImg"] = paymentImg
			
			return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
		}
    }
    
    
}

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
	var wechatQR:String?
	var alipayQR:String?
    
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
    func placeAliPayOrder(orders: String, addressID: String, invoice: String,total:String,successBlock: @escaping () -> ()) {
		let request = SettlementAPI.aliPay(orders: orders, addressID: addressID,invoice: invoice, total: total)
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
	func placewechatPayOrder(orders: String, addressID: String,invoice:String,total:String, successBlock: @escaping () -> ()) {
		let request = SettlementAPI.wechatPay(orders: orders, addressID: addressID,invoice: invoice, total: total)
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            let jsonData = JSON.init(result)["getWechaPay"]
            self.wechatPayModel = DDWechatPayModel.init(fromJson: jsonData)
            successBlock()
        }, requestError: { (result, errorModel) in
             BFunction.shared.showToastMessge(errorModel.message)
        }) { (error) in
            
        }
    }
	
	// 获取上级收款码
	func getinviterQRCode(inviteId:String, successBlock: @escaping () -> ()){
		let r = SettlementAPI.getpayqrcode(inviterId: inviteId)
		
		DDHTTPRequest.request(r: r, requestSuccess: { (result) in
			self.wechatQR = JSON.init(result)["wechat"].string
			self.alipayQR = JSON.init(result)["alipay"].string
			
			successBlock()
		}, requestError: { (result, errorModel) in
			BFunction.shared.showToastMessge(errorModel.message)
		}) { (error) in
			
		}
		
	}
	
	func payOrderAgent(orders: String, addressID: String ,invoice:String,total:String,orderType:String,paymentNumber:String,paymentImg:UIImage,successBlock: @escaping () -> ())  {
		let r = SettlementAPI.payOrdersAgent(orders: orders, addressID: addressID, invoice: invoice, total: total, orderType: orderType, paymentNumber: paymentNumber, paymentImg: paymentImg)
		
		DDHTTPRequest.upLoadImages(r: r, requestSuccess: { (responds) in
			
			let jsonRequest = JSON.init(responds);
		BFunction.shared.showSuccessMessage(jsonRequest["message"].stringValue);
			
			successBlock();
			
		}, requestError: { (responds, ErrorModel) in
			
			let jsonRequest = JSON.init(responds);
			let code = jsonRequest["code"].intValue
			var message:String?
			switch code {
			case 101:
				message = "请登录"
			case 102:
				message = "上传出错"
			case 103:
				message = "图片格式不正确"
			case 108:
				message = "请求超时"
			case 110:
				message = "签名不正确"
			case 111:
				message = " 未知错误"
			default:
				message = " Error"
			}
			
			BFunction.shared.showErrorMessage(message!);
			
		}) { (error) in
			
		}
		
	}
    
}

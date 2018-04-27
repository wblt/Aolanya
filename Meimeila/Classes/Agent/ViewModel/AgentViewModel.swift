//
//  AgentViewModel.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/12.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class AgentViewModel: NSObject {
	
	var examineoneUid = ""
	
	// 获取默认 邀请码
	func getToExamineoneUid(successBlock:@escaping () -> Void) {
		let url =   API.baseServer + API.getToExamineoneUidAPI
		
		Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
			
			let jsonRequest = JSON.init(response.result.value as![String:Any]);
			self.examineoneUid = jsonRequest["uid"].stringValue
			successBlock()
		}
	}
	
	
	/*
	{
	"uid": "710",
	"realName": "qwer",
	"phone": "15674522640",
	"weixin": "wdrt",
	"regionAdress": "湖南省",
	"temporaryRegionLevel": 2
	}
	*/
	// 省合伙人
	func writeRegionApply(uid:String ,realName:String ,phone:String ,weixin:String,regionAdress:String,temporaryRegionLevel:String,successBlock:@escaping () ->Void){
		let r = AgentApplyAPI.writeRegion(uid: uid, realName: realName, phone: phone, weixin: weixin, regionAdress: regionAdress, temporaryRegionLevel: temporaryRegionLevel)
		DDHTTPRequest.requestWithJsonCoding(r: r, requestSuccess: { (responds) in
			print(responds);
			let json = JSON.init(responds);
			
			BFunction.shared.showToastMessge(json["message"].stringValue);
			successBlock()
		}, requestError: { (responds, ErrorModel) in
			BFunction.shared.showToastMessge(ErrorModel.message);
		}) { (error) in
			
		}
		
	}
	
	
	// 上传申请 带支付宝图片
	func applyAgentJoin(uid:String ,name:String ,phone:String ,weixin:String ,adress:String ,invitationCode:String ,agentLevel:String ,weChatPayment:UIImage,alipayPayment:UIImage,successBlock:@escaping () -> Void) {
		
		let r = AgentApplyAPI.writeJoin(uid: uid, name: name, phone: phone, weixin: weixin, adress: adress, invitationCode: invitationCode, agentLevel: agentLevel, weChatPayment: weChatPayment, alipayPayment: alipayPayment)
		
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

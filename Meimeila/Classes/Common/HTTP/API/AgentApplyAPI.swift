//
//  AgentApplyAPI.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/10.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import Foundation
enum AgentApplyAPI {
	//验证邀请码
	//提交代理申请信息
	
	case invitationCodeAPI(code:String)
	
	case writeJoin(uid:String ,name:String ,phone:String ,weixin:String ,adress:String ,invitationCode:String ,agentLevel:String  ,weChatPayment:UIImage,alipayPayment:UIImage)
	
	case writeJointoWithExamineone(uid:String ,name:String ,phone:String ,weixin:String ,adress:String ,invitationCode:String ,agentLevel:String  ,weChatPayment:UIImage,alipayPayment:UIImage,toExamineone:String)
	
	case getToExamineoneUid()
	case writeRegion(uid:String,realName:String,phone:String,weixin:String,regionAdress:String,temporaryRegionLevel:String)
	
}

extension AgentApplyAPI:Request{
	
	var path: String {
		
		switch self {
		case .invitationCodeAPI(code: _):
			return API.checkInvitatiobCodeAPI
		case .writeJoin(uid: _,name:_ ,phone:_ ,weixin:_ ,adress:_ ,invitationCode:_ ,agentLevel:_  ,weChatPayment:_,alipayPayment:_):
			return API.writeApplyMsgAPI
		case .getToExamineoneUid:
			return API.getToExamineoneUidAPI
			
		case .writeRegion(uid: _, realName: _, phone: _, weixin: _, regionAdress: _, temporaryRegionLevel: _):
			return API.writeRegionAPI
		case .writeJointoWithExamineone(uid: _,name:_ ,phone:_ ,weixin:_ ,adress:_ ,invitationCode:_ ,agentLevel:_  ,weChatPayment:_,alipayPayment:_,toExamineone:_):
			
			return API.writeApplyMsgAPI
		}
	}
		
	
	var parameters: [String : Any]?{
		switch self {
		case .invitationCodeAPI(let code):
			var p = postParameters();
			p["invitationCode"] = code
			return  p // DDIntegrationOfTheParameter(params: p);
		case .writeJoin(let uid, let name, let phone, let weixin, let adress, let invitationCode, let agentLevel, let weChatPayment, let alipayPayment):
			var p = postParameters();
			p["uid"] = uid
			p["name"] = name
			p["phone"] = phone
			p["weixin"] = weixin
			p["adress"] = adress
			p["invitationCode"] = invitationCode
			p["agentLevel"] = agentLevel
			p["weChatPayment"] = weChatPayment
			p["alipayPayment"] = alipayPayment
			
			
			return  p
		case .getToExamineoneUid:
			return nil
		case .writeRegion(let uid, let realName, let phone, let weixin, let regionAdress, let temporaryRegionLevel):
			var p = [String: Any]();
			p["uid"] = uid
			p["realName"] = realName
			p["phone"] = phone
			p["weixin"] = weixin
			p["regionAdress"] = regionAdress
			p["temporaryRegionLevel"] = temporaryRegionLevel
			return  p
		case .writeJointoWithExamineone(let uid, let name, let phone, let weixin, let adress, let invitationCode, let agentLevel, let weChatPayment, let alipayPayment, let toExamineone):
			var p = postParameters();
			p["uid"] = uid
			p["name"] = name
			p["phone"] = phone
			p["weixin"] = weixin
			p["adress"] = adress
			p["invitationCode"] = invitationCode
			p["agentLevel"] = agentLevel
			p["weChatPayment"] = weChatPayment
			p["alipayPayment"] = alipayPayment
			p["toExamineone"] = toExamineone
			
			return  p
		}
	}
}


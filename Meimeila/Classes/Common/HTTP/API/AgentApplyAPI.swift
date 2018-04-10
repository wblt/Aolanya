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
	
}

extension AgentApplyAPI:Request{
	var path: String {
		
		switch self {
		case .invitationCodeAPI(code: _):
			return API.checkInvitatiobCodeAPI;
		}
	}
	
	var parameters: [String : Any]?{
		switch self {
		case .invitationCodeAPI(let code):
			var p = postParameters();
			p["invitationCode"] = code
			return  p // DDIntegrationOfTheParameter(params: p);
		}
	}
}


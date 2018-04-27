//
//  AgentManagerAPI.swift
//  Meimeila
//
//  Created by wy on 2018/4/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import Foundation
import SwiftyJSON
enum AgentManageAPI {
    //验证邀请码
    //提交代理申请信息
    //获取订单管理数据
	//拒绝区域审核
	//同意区域审核
    case getAgentManageAPI(uid:String)
    case getAllRegionShoopingAPI(uid:String)
    case getSubordinateShopping(uid:String)
	case agreenAgentAPI(uid:String,targetUid:String,remarks:String,apply:String,toExamineoneUid:String)
	case agreenRegionAPI(uid:String,targetUid:String,apply:String,agentLevel:String,level:String,inviter:String,regionLevel:String)
	//jsons	{"uid":"0","targetUid":"710","apply":"true","agentLevel":4,"level":4,"inviter":"55","regionLevel":2}
}

extension AgentManageAPI:Request{
    
    var path: String {
        
        switch self {
        case .getAgentManageAPI(uid: _):
            return API.getAgentManageData
		case .getAllRegionShoopingAPI(uid: _):
			return API.getAllRegionShoppingData
		
		case .getSubordinateShopping(uid: _):
			return API.getSubordinateShoppingData
		case .agreenAgentAPI(uid:_,targetUid:_,remarks:_,apply:_,toExamineoneUid:_):
			return API.agreeAgent
			
		case .agreenRegionAPI(uid:_,targetUid:_,apply:_,agentLevel:_,level:_,inviter:_,regionLevel:_):
			return API.agreeRegion
		}
	}
    
    var parameters: [String : Any]?{
        
        switch self {
        case .getAgentManageAPI(let uid):
           var p = [String : Any]();
           p["uid"] = uid
          return  p
			
		case .getAllRegionShoopingAPI(let uid):
			var p = [String : Any]();
			p["uid"] = uid
			return  p
		case .getSubordinateShopping(let uid):
			var p = [String : Any]();
			p["uid"] = uid
			return  p
		case .agreenAgentAPI(let uid, let targetUid, let remarks, let apply, let toExamineoneUid):
			var p = [String : Any]();
			p["uid"] = uid
			p["targetUid"] = targetUid
			p["remarks"] = remarks
			p["apply"] = apply
			p["toExamineoneUid"] = toExamineoneUid
			
			var pp = [String : Any]();
			
			let data = try?JSONSerialization.data(withJSONObject: p, options: JSONSerialization.WritingOptions.prettyPrinted)
			let jsons = String.init(data: data!, encoding:String.Encoding(rawValue: String.Encoding.utf8.rawValue) )!
			
			pp["jsons"] = jsons
			// 照着安卓 的要传图片,随便传的一个
			pp["authorizeImg"] = UIImage.init(named: "address")
			return  pp
		case .agreenRegionAPI(let uid, let targetUid, let apply, let agentLevel, let level, let inviter, let regionLevel):
			var p = [String : Any]();
			p["uid"] = uid
			p["targetUid"] = targetUid
			p["agentLevel"] = agentLevel
			p["apply"] = apply
			p["level"] = level
			p["inviter"] = inviter
			p["regionLevel"] = regionLevel
			
			var pp = [String : Any]();
			
			let data = try?JSONSerialization.data(withJSONObject: p, options: JSONSerialization.WritingOptions.prettyPrinted)
			let jsons = String.init(data: data!, encoding:String.Encoding(rawValue: String.Encoding.utf8.rawValue) )!
			
			pp["jsons"] = jsons
			// 照着安卓 的要传图片,随便传的一个
			pp["authorizeImg"] = UIImage.init(named: "address")
			
			return  pp
		}
        
    }
}

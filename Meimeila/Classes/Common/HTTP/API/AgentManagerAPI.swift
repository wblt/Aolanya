//
//  AgentManagerAPI.swift
//  Meimeila
//
//  Created by wy on 2018/4/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import Foundation
enum AgentManageAPI {
    //验证邀请码
    //提交代理申请信息
    
    case getAgentManageAPI(uid:String)
    case getAllRegionShoopingAPI(uid:String)
    case getSubordinateShopping(uid:String)
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
		}
        
    }
}

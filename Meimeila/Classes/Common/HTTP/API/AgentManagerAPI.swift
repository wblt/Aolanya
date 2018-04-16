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
    
    
}

extension AgentManageAPI:Request{
    
    var path: String {
        
        switch self {
        case .getAgentManageAPI(uid: _):
            return API.getAgentManageData
        }
    }
    
    
    var parameters: [String : Any]?{
        
        switch self {
        case .getAgentManageAPI(let uid):
           var p = [String : Any]();
           p["uid"] = uid
          return  p
        }
        
    }
}

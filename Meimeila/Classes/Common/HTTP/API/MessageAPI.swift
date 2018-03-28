//
//  MessageAPI.swift
//  Mythsbears
//
//  Created by macos on 2017/10/13.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit


enum MessageAPI {
    case customMessag
    case systemMessage
}


extension MessageAPI:Request{
    var path: String {
        switch self {
        case .customMessag:
            return API.customerMessageAPI
        case .systemMessage:
            return API.systemMessageAPI
        }
    }
    
    var host: String {
        return API.baseServer
    }
    
    var isCheckNetStatus: Bool {
        return true
    }
    
    var isCheckRequestError: Bool {
        return true
    }
    
    var parameters: [String : Any]?{
        
        switch self {
        case .systemMessage:
            let parameter = postParameters();
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true)
        case .customMessag:
            let parameter = postParameters();
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true)
        }
    }
    
}

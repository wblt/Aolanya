//
//  SystemNoticeAPI.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit


enum SystemNoticeAPI {
    case getSystemMessageList(numberPages: Int)
}

extension SystemNoticeAPI: Request {
    var path: String {
        return API.getSystemNotice
    }
    
    var parameters: [String : Any]? {
        switch self {

        case .getSystemMessageList(let numberPages):
            var params = postParameters()
            params["numberPages"] = numberPages
            return DDIntegrationOfTheParameter(params: params)
        }
    }
    
    
    
}

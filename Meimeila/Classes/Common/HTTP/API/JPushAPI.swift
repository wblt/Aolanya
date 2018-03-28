//
//  JPushAPI.swift
//  Mythsbears
//
//  Created by HJQ on 2017/11/15.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit


enum JPushAPI {
    // 上传极光推送的registerID
    case uploadRegistID(registID: String)
}

extension JPushAPI: Request {
    var path: String {
        return API.getRegistrationID
    }
    
    var parameters: [String : Any]? {
        switch self {

        case .uploadRegistID(let registID):
            var params = postParameters()
            params["registID"] = registID
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        }
    }
    
    var isCheckRequestError: Bool {
        return false
    }
}

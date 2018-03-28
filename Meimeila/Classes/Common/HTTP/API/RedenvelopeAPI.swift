//
//  RedenvelopeAPI.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// 领取签到红包
enum RedenvelopeAPI {
    case receiveRedenvelope(type: Int)
}

extension RedenvelopeAPI: Request {
    
    var path: String {
        return API.addSignRed
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .receiveRedenvelope(let type):
            var params = postParameters()
            params["type"] = type
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)

        }
    }
    
}

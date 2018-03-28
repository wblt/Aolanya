//
//  UseRedPacketsAPI.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/22.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// 商品详情领取抵现红包
enum UseRedPacketsAPI {
    case useRedPackets(shopingID: String)
}

extension UseRedPacketsAPI: Request {
    var path: String {
        return API.useRedPackets
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .useRedPackets(let shopingID):
            var params = postParameters()
            params["shopingID"] = shopingID
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        }
    }

}

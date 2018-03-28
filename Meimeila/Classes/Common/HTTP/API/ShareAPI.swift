//
//  ShareAPI.swift
//  Mythsbears
//
//  Created by HJQ on 2017/11/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// 分享成功
enum ShareAPI  {
    case shareSuccess()
}

extension ShareAPI: Request {
    var path: String {
        return API.share
    }
    
    var parameters: [String : Any]? {
        var params = postParameters()
        params["status"] = 1
        return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
    }
    
    
}

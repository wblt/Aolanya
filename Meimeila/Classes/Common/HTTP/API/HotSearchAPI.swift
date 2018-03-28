//
//  HotSearchAPI.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import Alamofire

// 热门搜索
enum HotSearchAPI {
    case getHotSearchKeywords
}


extension HotSearchAPI: Request {
    var path: String {
        return API.hotSearchKeyword
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
    
    var method: HTTPMethod {
        return .post
    }
    
    var parameters: [String : Any]? {
        let params = postParameters()
        return DDIntegrationOfTheParameter(params: params)
    }
    
    
}

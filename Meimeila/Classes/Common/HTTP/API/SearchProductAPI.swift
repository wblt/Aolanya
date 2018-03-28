//
//  SearchProductAPI.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import Alamofire

// 商品搜索列表
enum SearchProductAPI {
    case searchProduct(keyword: String, numberPages: Int, type: Int)
}

extension SearchProductAPI: Request {
    var path: String {
        return API.searchProduct
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var host: String {
        return API.baseServer
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .searchProduct(let keyword, let numberPages, let type):
            var params = postParameters()
            params["keyword"] = keyword
            params["numberPages"] = numberPages
            params["type"] = type
            return DDIntegrationOfTheParameter(params: params)
        }

    }
    
    var isCheckNetStatus: Bool {
        return true
    }
    
    var isCheckRequestError: Bool {
        return true
    }
    
    
}

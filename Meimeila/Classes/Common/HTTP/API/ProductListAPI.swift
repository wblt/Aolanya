//
//  ProductListAPI.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/10.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import Alamofire

// 获取商品列表
enum ProductListAPI {
    case productList(keyword: String, numberPages: Int, type: Int)
}

extension ProductListAPI: Request {
    
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
        case .productList(let keyword, let numberPages, let type):
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

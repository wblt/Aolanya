//
//  ShoppingcarAPI.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import Alamofire

// 购物车
enum ShoppingcarAPI {
    case getShoppingCarList(numberPages: Int)
    case productIncrease(shoppingID: String, number: String)
    case productDeIncrease(shoppingID: String, number: String)
    case productDeleted(shoppingID: String)
}

extension ShoppingcarAPI: Request {
    var path: String {
        switch self {
            
        case .getShoppingCarList(_):
            return API.shoppingcarList
        case .productIncrease(_, _):
            return API.productIncrease
        case .productDeIncrease(_, _):
            return API.productDeIncrease
        case .productDeleted(_):
            return API.productDeleted
        }
    }
    
    var host: String {
        return API.baseServer
    }
    
    var parameters: [String : Any]? {
        switch self {
            
        case .getShoppingCarList(let numberPages):
            var params = postParameters()
            params["numberPages"] = numberPages
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
            
        case .productIncrease(let shoppingID, let number):
            var params = postParameters()
            params["shoppingID"] = shoppingID
            params["number"] = number
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
            
        case .productDeIncrease(let shoppingID, let number):
            var params = postParameters()
            params["shoppingID"] = shoppingID
            params["number"] = number
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
            
        case .productDeleted(let shoppingID):
            var params = postParameters()
            params["shoppingID"] = shoppingID
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var isCheckNetStatus: Bool {
        return true
    }
    
    var isCheckRequestError: Bool {
        return true
    }
    
    
}

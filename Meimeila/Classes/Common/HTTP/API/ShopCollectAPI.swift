//
//  ShopCollectAPI.swift
//  Mythsbears
//
//  Created by macos on 2017/10/12.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// 用户商品收藏列表
enum ShopCollectAPI {
    
    case shopList(numberPages: Int)
    
}

extension ShopCollectAPI:Request{
    

    var path: String {
        switch self {
            case .shopList(_):
                return API.shopCollectListAPI
        }
    }

    var host: String {
        return API.baseServer
    }

    var isCheckNetStatus: Bool {
        return true
    }

    var isCheckRequestError: Bool {
        return  true
    }
    
  
    var parameters: [String : Any]?{
        
        switch self {
        case .shopList(let numberPages):
            var params = postParameters()
            params ["numberPages"] = numberPages
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        }
        
    }
    
}

//
//  ProductDetailsAPI.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import Alamofire

// 获取商品详情
enum ProductDetailsAPI {
    case productDetails(shopingID: String)
    case productCollection(shopingID: String)
    case cancelProductCollection(shopingID: String)
    case addProductToCar(shoppingID: String, shoppingNumber: String)
    case addShopFabulous(shoppingID: String, evaluateID: String) // 商品评价点赞
    case delShopFabulous(shoppingID: String, evaluateID: String) // 商品评价点赞
    case queryIsCollection(shopingID: String) // 查询是否已经收藏
    case getEvalutionList(shopingID: String, numberPages: Int)
}

extension ProductDetailsAPI: Request {
    var path: String {
        switch self {
        case .productDetails(_):
            return API.productDetails
            
        case .productCollection:
            return API.addShopCollection
            
        case .cancelProductCollection:
            return API.delShopCollection
            
        case .addProductToCar(_,_):
            return API.addShoppingCart
            
        case .addShopFabulous(_, _):
            return API.addShopFabulous
            
        case .delShopFabulous(_, _):
            return API.delShopFabulous
        case .getEvalutionList(_, _):
            return API.getEvaluation

        case .queryIsCollection(_):
            return API.isCollection
        }
    }
    
    var host: String {
        return API.baseServer
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .productDetails(let shopingID):
            var params = postParameters()
            params["shopingID"] = shopingID
			let uid = DDUDManager.share.getUserID()
			params["uid"] = uid
            return DDIntegrationOfTheParameter(params: params)
            
        case .productCollection(let shopingID):
            var params = postParameters()
            params["shopingID"] = shopingID
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
            
        case .cancelProductCollection(let shopingID):
            var params = postParameters()
            params["shopingID"] = shopingID
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        case .addProductToCar(let shoppingID, let shoppingNumber):
            var params = postParameters()
            params["shoppingID"] = shoppingID
            params["shoppingNumber"] = shoppingNumber
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        case .addShopFabulous(let shoppingID, let evaluateID):
            var params = postParameters()
            params["shopingID"] = shoppingID
            params["evaluateID"] = evaluateID
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        case .delShopFabulous(let shoppingID, let evaluateID):
            var params = postParameters()
            params["shopingID"] = shoppingID
            params["evaluateID"] = evaluateID
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        case .getEvalutionList(let shopingID, let numberPages):
            var params = postParameters()
            params["shopingID"] = shopingID
            params["numberPages"] = numberPages
            return DDIntegrationOfTheParameter(params: params)
        case .queryIsCollection(let shopingID):
            var params = postParameters()
            params["shopingID"] = shopingID
            return DDIntegrationOfTheParameter(params: params,isNeedLogin: true)
        }
    }
    
    // 请求方式
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

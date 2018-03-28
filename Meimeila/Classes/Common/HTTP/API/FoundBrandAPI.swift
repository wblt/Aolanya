//
//  FoundBrandAPI.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/14.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum FoundBrandAPI {
    case getFoundBrandList(numberPages: Int)
}

extension FoundBrandAPI: Request {
    var path: String {
        return API.getFoundBrand
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getFoundBrandList(let numberPages):
            var params = postParameters()
            params["numberPages"] = numberPages
            return DDIntegrationOfTheParameter(params: params)
        }
    }
    
    
}

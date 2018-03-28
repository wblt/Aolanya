//
//  MMLBeansToMonayAPI.swift
//  Meimeila
//
//  Created by macos on 2017/12/26.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum MMLBeansToMonayAPI{

    case beanToMonayExchangeRate
    case beanToMonayExchange(num:String)
    
}

extension MMLBeansToMonayAPI:Request{
    var path: String {
        
        switch self {
        case .beanToMonayExchangeRate:
            return API.beansToMoneyExchangeRateAPI
        case .beanToMonayExchange(num: _):
            return API.beansToMoneyExchangeAPI
        }
    }
    
    var parameters: [String : Any]?{
        
        switch self {
        case .beanToMonayExchange(let num):
            var p = postParameters();
            p["num"] = num;
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);
        case .beanToMonayExchangeRate:
            let p = postParameters();
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: false);
        }
    }
    
}

//
//  HealthBeansAPI.swift
//  Meimeila
//
//  Created by macos on 2017/12/11.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum HealthBeansAPI {
    case beansCount
    case beanRecord(numberPages:Int)
    
}

extension HealthBeansAPI:Request{
    var path: String {
        switch self {
        case .beanRecord(numberPages: _):
            return API.healthBeansRecordAPI;
        case .beansCount:
            return API.healthBeansAPI;
            
        }
    }
    
    
    var parameters: [String : Any]?{
        
        switch self {
        case .beanRecord(let numberPages):
            var p = postParameters();
            p["numberPages"] = "\(numberPages)"
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);
        case .beansCount:
            let p = postParameters();
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);
        }
        
    }
    
}

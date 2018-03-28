//
//  MMLDetailAPI.swift
//  Meimeila
//
//  Created by macos on 2017/11/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum MMLDetailAPI{

    case detail(numberPages:Int)
    
}

extension MMLDetailAPI:Request{
    var path: String {
        return API.detailAPI;
    }
    
    var parameters: [String : Any]?{
        
        switch self {
        case .detail( let numberPages):
        
            var p = postParameters();
            p["numberPages"] = "\(numberPages)";
            
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);
        }
        
    }
    
    
    
}

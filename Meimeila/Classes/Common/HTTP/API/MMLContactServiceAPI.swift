//
//  MMLContactServiceAPI.swift
//  Meimeila
//
//  Created by macos on 2017/12/29.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum MMLContactServiceAPI {

    case service
}

extension MMLContactServiceAPI:Request{
    var path: String {
        return API.contactServiceAPI;
    }
    
    var parameters: [String : Any]?{
        
        let p = postParameters();
        return DDIntegrationOfTheParameter(params: p, isNeedLogin: false);
    }
    
    
}

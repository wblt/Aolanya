//
//  DayTaskAPI.swift
//  Mythsbears
//
//  Created by macos on 2017/11/18.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum DayTaskAPI{
    case dayTask
}


extension DayTaskAPI:Request{
    
    var path: String{
        
        return API.dayTaskAPI;
        
    }
    
    
    var parameters: [String : Any]?{
        
        let p = postParameters()
        
        return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);
    }
    
}

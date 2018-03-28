//
//  MaskAPI.swift
//  Mythsbears
//
//  Created by macos on 2017/11/15.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum MaskAPI {

    case addMaskData(water:String,oily:String)
    case getMaskDataList
}

extension MaskAPI:Request{
    var path: String {
        switch self {
        case .addMaskData(water: _, oily: _):
            return API.maskDataupLoadAPI;
        case .getMaskDataList:
            return API.maskDataListAPI;
        }
    }
    
    var parameters: [String : Any]?{
        
        switch self {
        case .addMaskData(let water,let oily):
            
            var parameter = postParameters();
            parameter["water"] = water
            parameter["oily"] = oily
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true);
        case.getMaskDataList:
            let parameter = postParameters();
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true);
        }
        
    }
    
    
}

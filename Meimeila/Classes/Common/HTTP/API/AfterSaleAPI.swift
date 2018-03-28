//
//  AfterSaleAPI.swift
//  Mythsbears
//
//  Created by macos on 2017/11/4.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum AfterSaleAPI {

    case afterSaleList(numberPage:Int)
    case afterSaleDetail(orderID:String)
    case afterSaleApply(orderID:String,return_type:Int,return_reason:String,return_explains:String)
}

extension AfterSaleAPI:Request{
    var path: String {
        switch self {
        case .afterSaleDetail(orderID: _):
            return API.afterSaleDetailAPI
        case .afterSaleList(numberPage: _):
            return API.afterSaleListAPI
        case .afterSaleApply(orderID: _, return_type: _, return_reason: _,return_explains:_):
            return API.afterSaleApplyAPI
        }
    }
    
    var parameters: [String : Any]?{
        
        switch self {
        case .afterSaleList(let numberPage):
            var parameter = postParameters();
            parameter["numberPages"] = "\(numberPage)";
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true);
        case .afterSaleDetail(let orderID):
            var parameter = postParameters();
            parameter["orderID"] = "\(orderID)";
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true);
        case .afterSaleApply(let orderID, let return_type, let return_reason,let return_explains):
            var parameter = postParameters();
            parameter["orderID"] = "\(orderID)";
            parameter["return_type"] = "\(return_type)";
            parameter["return_reason"] = return_reason;
            parameter["return_explains"] = return_explains;
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true);
        }
        
    }
    
    var isCheckRequestError: Bool{
        return true;
    }
    
    var isCheckNetStatus: Bool{
        
        return true;
    }
}

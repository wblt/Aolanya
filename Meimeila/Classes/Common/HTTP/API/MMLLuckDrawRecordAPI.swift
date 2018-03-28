//
//  MMLLuckDrawRecordAPI.swift
//  Meimeila
//
//  Created by macos on 2017/12/26.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum MMLLuckDrawRecordAPI {

    case luckDrawRecord(numberPages:Int)
    case exchangeGiftRecord(numberPages:Int)
    case exchangeGift(payment_pwd:String,consignee:String,addresseePhone:String,localArea:String,detailedAddress:String,postcode:String?,postage:String,id:String)

}

extension MMLLuckDrawRecordAPI:Request{
    
    var path: String{
        
        switch self {
        case .exchangeGiftRecord(numberPages: _):
            return API.exchangeGiftAPI;
        case . luckDrawRecord(numberPages: _):
            return API.luckDrawRecordAPI;
        case .exchangeGift(let payment_pwd,let consignee, let addresseePhone, let localArea, let detailedAddress, let postcode,let postage, let id):
            
            return API.exchangeGift2_0API
        }
        
    }
    
    var parameters: [String : Any]?{
        
        switch self {
        case .luckDrawRecord(let numberPages):
            
            var p = postParameters();
            p["numberPages"] = numberPages;
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);
        case .exchangeGiftRecord(let numberPages):
            var p = postParameters();
            p["numberPages"] = numberPages;
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);
        case .exchangeGift(let payment_pw,let consignee, let addresseePhone, let localArea, let detailedAddress, let postcode,let postage, let id):
           
            var p = postParameters();
            p["consignee"] = consignee;
            p["addresseePhone"] = addresseePhone;
            p["localArea"] = localArea;
            p["detailedAddress"] = detailedAddress;
            p["payment_pwd"] = payment_pw;
            p["postage"] =  postage
            if let _ = postcode{
                p["postcode"] = postcode;
            }
            
            p["id"] = id;
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);
            
        }
    
    }
}

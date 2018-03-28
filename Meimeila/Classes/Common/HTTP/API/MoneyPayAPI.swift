//
//  MoneyPayAPI.swift
//  Meimeila
//
//  Created by macos on 2017/12/8.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum MoneyPayAPI {

    //0代表充值支付
    //1代表商品支付
    //2代表健康豆充值
    
    case moneyPay_RecordAPI(numberPages:Int)
    case moneyPay_OrderAPI(payment_pwd:String,orderID:String?,orders:String,orderType:String,adressID:String,invoice:String?)//还有appkey
    case moneyPay_BeanAPI(payment_pwd:String,orderPrice:String,orderType:String,invoice:String?)
    case moneyPay_SetPwdAPI(payment_pwd:String,code:String)
    case moneyPay_BindPhone(code:String,type:String,phone:String)
}

extension MoneyPayAPI:Request{
    var path: String {
        
        switch self {
        case .moneyPay_RecordAPI(numberPages: _):
            return API.moneyPayRecordAPI;
        case .moneyPay_OrderAPI(payment_pwd: _, orderID: _, orders: _, orderType: _, adressID: _, invoice:_):
            return API.momeyPayOrderAPI;
        case .moneyPay_BeanAPI(payment_pwd: _, orderPrice: _, orderType: _,invoice: _):
            return API.moneyPayHealthBeanAPI;
            
        case .moneyPay_SetPwdAPI(payment_pwd: _,code:_):
            return API.moneyPay_PW_API;
        case .moneyPay_BindPhone(code: _, type: _, phone: _):
            return API.moneyPayBindPhoneAPI;
        }
    }
    
    
    var parameters: [String : Any]?{
        
        switch self {
        case .moneyPay_RecordAPI(let numberPages):
            var p = postParameters();
            p["numberPages"] = "\(numberPages)"
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);
        case .moneyPay_OrderAPI(let payment_pwd,let orderID,let orders,let  orderType,let adressID,let invoice):
            var p = postParameters();
            p["payment_pwd"] = payment_pwd;
            
            if let _ = orderID{
                p["orderID"] = orderID;
            }
            p["app_key"] = kApp_key;
            p["orders"] = orders;
            p["orderType"] = orderType;
            p["adressID"] = adressID;
            
            if let _ = invoice{
                p["invoice"] = invoice!
                
            }
            
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);
        case .moneyPay_BindPhone(let code,let type ,let phone):
            var p = postParameters();
            p["code"] = code;
            p["type"] = type;
            p["phone"] = phone;
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);
            
        case .moneyPay_BeanAPI(let payment_pwd,let orderPrice,let orderType, let invoice):
            var p = postParameters();
            p["payment_pwd"] = payment_pwd;
            p["orderPrice"] = orderPrice;
            p["orderType"] = orderType
            
            if let _ = invoice{
                p["invoice"] = invoice!
                
            }
            
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);
        case .moneyPay_SetPwdAPI(let payment_pwd,let code):
            var p = postParameters();
            p["payment_pwd"] = payment_pwd;
            p["code"] = code;
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);
        }
    }
}

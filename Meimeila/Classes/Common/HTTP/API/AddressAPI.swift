//
//  AddressAPI.swift
//  Mythsbears
//
//  Created by macos on 2017/10/13.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum AddressAPI {
    
    case addressList(numberPages:Int)
    
    case addNewAddress(
        consignee:String,
        localArea:String,
        detailedAddress:String,
        defaultAddress:String,
        addresseePhone:String,postcode:String)
    case modifiedAddress(
        consignee:String,
        localArea:String,
        detailedAddress:String,
        defaultAddress:String,
        addresseePhone:String,
        adressID:String,
        postcode:String)
    case deleteAddress(adressID:String)
    
    case defaultAddress
    
    //修改订单选择的收货地址
    case orderAddressSelect(orderID:String,orderState:String,adressID:String)
}

extension AddressAPI:Request{
    var path: String {
        switch self {
        case .addNewAddress(consignee: _, localArea: _, detailedAddress: _, defaultAddress: _, addresseePhone: _,postcode:_):
            return API.addNewAddressAPI
        case .modifiedAddress(consignee: _, localArea: _, detailedAddress: _, defaultAddress: _, addresseePhone: _,adressID:_,postcode:_):
            return API.modifiedAddressAPI
        case .deleteAddress(adressID: _):
            return API.deleteAddressAPI
            
        case .addressList(numberPages: _):
            return API.addressListAPI
        case .defaultAddress:
            return API.defaultAddressAPI
        case .orderAddressSelect:
            return API.orderAddressSelect
        }
    }
    
    var host: String {
        return API.baseServer
    }
    
    var isCheckNetStatus: Bool {
        return true
    }
    
    var isCheckRequestError: Bool {
        return true
    }
    
    
    var parameters: [String : Any]?{
        
        switch self {
        case .addNewAddress(let consignee,let localArea,let detailedAddress,let defaultAddress,let addresseePhone,let postcode):
            
            var parameter = postParameters()
            parameter["consignee"] = consignee
            parameter["localArea"] = localArea
            parameter["detailedAddress"] = detailedAddress
            parameter["defaultAddress"] = defaultAddress
            parameter["addresseePhone"] = addresseePhone
            parameter["postcode"] = postcode
            
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true)
        case .modifiedAddress(let consignee,let localArea,let detailedAddress,let defaultAddress,let addresseePhone,let adressID,let postcode):
            var parameter = postParameters()
            parameter["consignee"] = consignee
            parameter["localArea"] = localArea
            parameter["detailedAddress"] = detailedAddress
            parameter["defaultAddress"] = defaultAddress
            parameter["addresseePhone"] = addresseePhone
            parameter["adressID"] = adressID
            parameter["postcode"] = postcode
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true)
        case .deleteAddress(let adressID):
            var parameter = postParameters()
            parameter["adressID"] = adressID
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true)
            
        case .addressList(let numberPages):
            var parameter = postParameters()
            parameter["numberPages"] = numberPages;
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true)
            
        case .defaultAddress:
            let parameter = postParameters()
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true)
            
        case .orderAddressSelect(let orderID, let orderState, let adressID):
            var parameter = postParameters()
            parameter["orderID"] = orderID;
            parameter["orderState"] = orderState;
            parameter["adressID"] = adressID;
            return DDIntegrationOfTheParameter(params: parameter, isNeedLogin: true)
            
        }
        
    }
}



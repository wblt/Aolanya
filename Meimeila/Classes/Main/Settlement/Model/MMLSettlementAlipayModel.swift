//
//  MMLSettlementAlipayModel.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import SwiftyJSON

class MMLSettlementAlipayModel{
    
    var code : String!
    var getAlipay : String!
    var message : String!
    var orderID : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        code = json["code"].stringValue
        getAlipay = json["getAlipay"].stringValue
        message = json["message"].stringValue
        orderID = json["orderID"].stringValue
    }
    
}

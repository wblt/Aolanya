//
//  MMLProductDetailsEvaluateData.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import SwiftyJSON

class MMLProductDetailsEvaluateData{
    
    var code : String!
    var evaluateID : String!
    var evaluateImg : String!
    var evaluateMessage : String!
    var evaluateTime : String!
    var evaluateType : String!
    var fabulous : String!
    var message : String!
    var name : String!
    var picture : String!
    var score : String!
    var shoppingID : String!
    var totalFabulous : Int = 0
    var uid : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        code = json["code"].stringValue
        evaluateID = json["evaluateID"].stringValue
        evaluateImg = json["evaluateImg"].stringValue
        evaluateMessage = json["evaluateMessage"].stringValue
        evaluateTime = json["evaluateTime"].stringValue
        evaluateType = json["evaluateType"].stringValue
        fabulous = json["fabulous"].stringValue
        message = json["message"].stringValue
        name = json["name"].stringValue
        picture = json["picture"].stringValue
        score = json["score"].stringValue
        shoppingID = json["shoppingID"].stringValue
        totalFabulous = json["totalFabulous"].intValue
        uid = json["uid"].stringValue
    }
    
}

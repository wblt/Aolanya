//
//  DDProductDetailsAddCarModel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

// 加入购物车模型
class DDProductDetailsAddCarModel {

    var code : String!
    var message : String!
    var shoppingCartNumber : Int!
    var shoppingID : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        code = json["code"].stringValue
        message = json["message"].stringValue
        shoppingCartNumber = json["shoppingCartNumber"].intValue
        shoppingID = json["shoppingID"].stringValue
    }
    
}

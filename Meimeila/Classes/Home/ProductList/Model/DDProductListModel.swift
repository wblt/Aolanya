//
//  DDProductListModel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/10.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class DDProductListModel {

    var code : String!
    var message : String!
    var shopping : [DDProductListShopping]!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        code = json["code"].stringValue
        message = json["message"].stringValue
        shopping = [DDProductListShopping]()
        let shoppingArray = json["shopping"].arrayValue
        for shoppingJson in shoppingArray{
            let value = DDProductListShopping(fromJson: shoppingJson)
            shopping.append(value)
        }
    }


}

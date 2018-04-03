//
//  DDProductDetailsShoppingIntroduce.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class DDProductDetailsShoppingIntroduce {

    var introduceImg : String!
    var introduceImgUrl : String!
    var shoppingID : String!
    var shoppingIntroduceID : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        introduceImg = json["introduceImg"].stringValue
        introduceImgUrl = json["introduceImgUrl"].stringValue
        shoppingID = json["shoppingID"].stringValue
        shoppingIntroduceID = json["shoppingIntroduceID"].stringValue
    }
    
}

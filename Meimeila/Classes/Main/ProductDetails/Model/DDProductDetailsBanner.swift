//
//  DDProductDetailsBanner.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class DDProductDetailsBanner {

    var shoppingBannerID : String!
    var shoppingBannerImg : String!
    var shoppingBannerLink : String!
    var shoppingBannerName : String!
    var shoppingBannerTitle : String!
    var shoppingBannerType : String!
    var shoppingID : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        shoppingBannerID = json["shoppingBannerID"].stringValue
        shoppingBannerImg = json["shoppingBannerImg"].stringValue
        shoppingBannerLink = json["shoppingBannerLink"].stringValue
        shoppingBannerName = json["shoppingBannerName"].stringValue
        shoppingBannerTitle = json["shoppingBannerTitle"].stringValue
        shoppingBannerType = json["shoppingBannerType"].stringValue
        shoppingID = json["shoppingID"].stringValue
    }
}

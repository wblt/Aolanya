//
//  DDProductDetailsProductDetail.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class DDProductDetailsProductDetail {
    
    var isProductDetails : Int!
    var productDetailsID : String!
    var productDetailsImg : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        isProductDetails = json["isProductDetails"].intValue
        productDetailsID = json["productDetailsID"].stringValue
        productDetailsImg = json["productDetailsImg"].stringValue
    }
}

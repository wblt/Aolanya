//
//  ShopOrderInfoModel.swift
//  Mythsbears
//
//  Created by macos on 2017/10/14.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class ShopOrderInfoModel{

    var shopingID:String?
    var shopingName:String?
    var shopingImg:String?
    var price:String?
    var specifications:String?
    var shoppingNumber:String?
    
    init(fromJson json:JSON) {
        shopingID = json["shoppingID"].stringValue
        shopingName = json["shopingName"].stringValue
        shopingImg = json["shopingImg"].stringValue
        price = json["price"].stringValue
        specifications = json["specifications"].stringValue
        shoppingNumber = json["shoppingNumber"].stringValue
    }
    
}

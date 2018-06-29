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
	// 因为有些接口 服务器返回的参数 不一样，所以多写一遍  pp 
    var shopingID:String?
    var shopingName:String?
	var shoppingName:String?
    var shopingImg:String?
	var shoppingImg:String?
    var price:String?
    var specifications:String?
    var shoppingNumber:String?
	
	var shoppingTime:String?
	var orderNumber:String?
	var uid :String?
	var orderState:String?
    
    init(fromJson json:JSON) {
        shopingID = json["shoppingID"].stringValue
        shopingName = json["shopingName"].stringValue
		shoppingName = json["shoppingName"].stringValue
        shopingImg = json["shopingImg"].stringValue
		shoppingImg = json["shoppingImg"].stringValue
        price = json["price"].stringValue
        specifications = json["specifications"].stringValue
        shoppingNumber = json["shoppingNumber"].stringValue
    }
    
}

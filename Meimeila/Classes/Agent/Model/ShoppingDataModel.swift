//
//  ShoppingDataModel.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/17.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class ShoppingDataModel: NSObject {
	var shoppingId : String!
	var shoppingName : String!
	var shoppingTotalNum : String!
	var shoppingUnitPrice : String!
	var shoppingImg : String!
	var specifications : String!
	
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		shoppingId = json["shoppingId"].stringValue
		shoppingName = json["shoppingName"].stringValue
		shoppingTotalNum = json["shoppingTotalNum"].stringValue
		shoppingUnitPrice = json["shoppingUnitPrice"].stringValue
		shoppingImg = json["shoppingImg"].stringValue
		specifications = json["specifications"].stringValue
	}
	
}

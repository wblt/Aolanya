//
//  ShopDataModel.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/17.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class ShopDataModel: NSObject {
	var time : String?
	var shoppingDate : Array<Any>?
	
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		time = json["time"].stringValue
		shoppingDate = json["shoppingDate"].arrayValue
		
	}
}

//
//  RegionShoppingModel.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/17.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegionShoppingModel{
	var regionProvince : String!
	var regionCity : String!
	var shoppingDate : [Any]!
	
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		regionProvince = json["regionProvince"].stringValue
		regionCity = json["regionCity"].stringValue
		shoppingDate = json["shoppingDate"].arrayValue
		
	}
	
}

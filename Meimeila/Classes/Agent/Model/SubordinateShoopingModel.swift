//
//  SubordinateShoopingModel.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/17.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class SubordinateShoopingModel {
	var uid : String!
	var dataCount : String!
	var level : String!
	var realName : String!
	var shoppingHistoryData : [Any]!
	
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		uid = json["uid"].stringValue
		dataCount = json["dataCount"].stringValue
		level = json["level"].stringValue
		realName = json["realName"].stringValue
		shoppingHistoryData = json["shoppingHistoryData"].arrayValue
		
	}
}

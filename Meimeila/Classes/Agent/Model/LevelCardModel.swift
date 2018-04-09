//
//  LevelCardModel.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/9.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class LevelCardModel {
	var id : String!
	var type : String!
	var title : String!
	var url : String!
	var remarks : String!
	var isUrl : Bool!
	var money : String!
	var money2 : String!
	var color_bg: String!
	var discount: String!
	
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		id = json["id"].stringValue
		type = json["type"].stringValue
		title = json["title"].stringValue
		url = json["url"].stringValue
		title = json["title"].stringValue
		remarks = json["remarks"].stringValue
		isUrl = json["isUrl"].bool
		money = json["money"].stringValue
		money2 = json["money2"].stringValue
		color_bg = json["color_bg"].stringValue
		discount = json["discount"].stringValue
	}
	
}

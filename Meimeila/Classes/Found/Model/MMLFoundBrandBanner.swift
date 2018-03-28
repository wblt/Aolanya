//
//	MMLFoundBrandBanner.swift
//
//	Create by 家仟 黄 on 14/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLFoundBrandBanner{

	var id : String!
	var img : String!
	var link : String!
	var name : String!
	var shoppingID : String!
	var title : String!
	var type : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		id = json["id"].stringValue
		img = json["img"].stringValue
		link = json["link"].stringValue
		name = json["name"].stringValue
		shoppingID = json["shoppingID"].stringValue
		title = json["title"].stringValue
		type = json["type"].stringValue
	}

}

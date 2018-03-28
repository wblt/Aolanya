//
//	MMLHomeDataBanner.swift
//
//	Create by 家仟 黄 on 19/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLHomeDataBanner{

	var id : String!
	var img : String!
	var link : String!
	var name : String!
	var title : String!
	var type : String!
    var shoppingID : String!


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
		title = json["title"].stringValue
		type = json["type"].stringValue
        shoppingID = json["shoppingID"].stringValue
	}

}

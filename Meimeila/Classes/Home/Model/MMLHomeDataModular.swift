//
//	MMLHomeDataModular.swift
//
//	Create by 家仟 黄 on 19/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLHomeDataModular{

	var modularBody : String!
	var modularID : String!
	var modularImg : String!
	var modularName : String!
	var modularType : String!
	var modularUrl : String!
	var shoppingID : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		modularBody = json["modularBody"].stringValue
		modularID = json["modularID"].stringValue
		modularImg = json["modularImg"].stringValue
		modularName = json["modularName"].stringValue
		modularType = json["modularType"].stringValue
		modularUrl = json["modularUrl"].stringValue
		shoppingID = json["shoppingID"].stringValue
	}

}

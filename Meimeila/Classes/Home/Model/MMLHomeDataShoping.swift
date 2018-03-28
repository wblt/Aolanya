//
//	MMLHomeDataShoping.swift
//
//	Create by 家仟 黄 on 19/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLHomeDataShoping{

	var businessID : String!
	var collectionCount : String!
	var discount : String!
	var isFrozen : String!
	var price : String!
	var readingCount : String!
	var salesCount : String!
	var shopingID : String!
	var shopingImg : String!
	var shopingMessage : String!
	var shopingName : String!
	var shopingNumber : String!
	var shoppingIsRelease : String!
	var shoppingSource : String!
	var shoppingTime : String!
	var shoppingType : String!
	var specifications : String!
    var market_value: String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		businessID = json["businessID"].stringValue
		collectionCount = json["collectionCount"].stringValue
		discount = json["discount"].stringValue
		isFrozen = json["isFrozen"].stringValue
		price = json["price"].stringValue
		readingCount = json["readingCount"].stringValue
		salesCount = json["salesCount"].stringValue
		shopingID = json["shopingID"].stringValue
		shopingImg = json["shopingImg"].stringValue
		shopingMessage = json["shopingMessage"].stringValue
		shopingName = json["shopingName"].stringValue
		shopingNumber = json["shopingNumber"].stringValue
		shoppingIsRelease = json["shoppingIsRelease"].stringValue
		shoppingSource = json["shoppingSource"].stringValue
		shoppingTime = json["shoppingTime"].stringValue
		shoppingType = json["shoppingType"].stringValue
		specifications = json["specifications"].stringValue
        market_value = json["market_value"].stringValue
	}

}

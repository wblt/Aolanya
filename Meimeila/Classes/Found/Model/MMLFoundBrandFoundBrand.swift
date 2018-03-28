//
//	MMLFoundBrandFoundBrand.swift
//
//	Create by 家仟 黄 on 14/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLFoundBrandFoundBrand{

	var brandImg : String!
	var brandMessage : String!
	var brandName : String!
	var brandTime : String!
	var collectionCount : String!
	var foundID : String!
	var foundReadCount : String!
	var foundType : String!
	var foundUrl : String!
	var price : String!
	var readingCount : String!
	var shopingID : String!
	var totalCollection : String!
	var uid : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		brandImg = json["brandImg"].stringValue
		brandMessage = json["brandMessage"].stringValue
		brandName = json["brandName"].stringValue
		brandTime = json["brandTime"].stringValue
		collectionCount = json["collectionCount"].stringValue
		foundID = json["foundID"].stringValue
		foundReadCount = json["foundReadCount"].stringValue
		foundType = json["foundType"].stringValue
		foundUrl = json["foundUrl"].stringValue
		price = json["price"].stringValue
		readingCount = json["readingCount"].stringValue
		shopingID = json["shopingID"].stringValue
		totalCollection = json["totalCollection"].stringValue
		uid = json["uid"].stringValue
	}

}
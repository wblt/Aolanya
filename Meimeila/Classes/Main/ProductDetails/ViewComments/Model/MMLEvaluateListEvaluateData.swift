//
//	MMLEvaluateListEvaluateData.swift
//
//	Create by 家仟 黄 on 25/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLEvaluateListEvaluateData{

	var evaluateID : String!
	var evaluateImg : String!
	var evaluateMessage : String!
	var evaluateTime : String!
	var evaluateType : String!
	var fabulous : String!
	var fabulousID : String!
	var name : String!
	var picture : String!
	var score : String!
	var shoppingID : String!
	var totalFabulous : String!
	var uid : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		evaluateID = json["evaluateID"].stringValue
		evaluateImg = json["evaluateImg"].stringValue
		evaluateMessage = json["evaluateMessage"].stringValue
		evaluateTime = json["evaluateTime"].stringValue
		evaluateType = json["evaluateType"].stringValue
		fabulous = json["fabulous"].stringValue
		fabulousID = json["fabulousID"].stringValue
		name = json["name"].stringValue
		picture = json["picture"].stringValue
		score = json["score"].stringValue
		shoppingID = json["shoppingID"].stringValue
		totalFabulous = json["totalFabulous"].stringValue
		uid = json["uid"].stringValue
	}

}

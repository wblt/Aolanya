//
//	MMLSystemMessageListData.swift
//
//	Create by 家仟 黄 on 28/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLSystemMessageListData{

	var msgAddTime : String!
	var msgBody : String!
	var msgID : String!
	var msgPublisher : String!
	var msgTitle : String!
	var msgType : String!
	var uid : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		msgAddTime = json["msgAddTime"].stringValue
		msgBody = json["msgBody"].stringValue
		msgID = json["msgID"].stringValue
		msgPublisher = json["msgPublisher"].stringValue
		msgTitle = json["msgTitle"].stringValue
		msgType = json["msgType"].stringValue
		uid = json["uid"].stringValue
	}

}
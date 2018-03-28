//
//	MMLSystemMessageList.swift
//
//	Create by 家仟 黄 on 28/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLSystemMessageList{

	var code : String!
	var data : [MMLSystemMessageListData]!
	var message : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		code = json["code"].stringValue
		data = [MMLSystemMessageListData]()
		let dataArray = json["data"].arrayValue
		for dataJson in dataArray{
			let value = MMLSystemMessageListData(fromJson: dataJson)
			data.append(value)
		}
		message = json["message"].stringValue
	}

}
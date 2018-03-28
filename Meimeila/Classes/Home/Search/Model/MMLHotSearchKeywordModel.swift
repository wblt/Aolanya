//
//	MMLHotSearchKeywordModel.swift
//
//	Create by 家仟 黄 on 20/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLHotSearchKeywordModel{

	var code : String!
	var hot : [MMLHotSearchKeywordHot]!
	var message : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		code = json["code"].stringValue
		hot = [MMLHotSearchKeywordHot]()
		let hotArray = json["hot"].arrayValue
		for hotJson in hotArray{
			let value = MMLHotSearchKeywordHot(fromJson: hotJson)
			hot.append(value)
		}
		message = json["message"].stringValue
	}

}
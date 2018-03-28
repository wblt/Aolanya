//
//	MMLHotSearchKeywordHot.swift
//
//	Create by 家仟 黄 on 20/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLHotSearchKeywordHot{

	var keyword : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		keyword = json["keyword"].stringValue
	}

}
//
//	MMLEvaluateListModel.swift
//
//	Create by 家仟 黄 on 25/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLEvaluateListModel{

	var code : String!
	var evaluateData : [MMLProductDetailsEvaluateData]!
	var message : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		code = json["code"].stringValue
		evaluateData = [MMLProductDetailsEvaluateData]()
		let evaluateDataArray = json["evaluateData"].arrayValue
		for evaluateDataJson in evaluateDataArray{
			let value = MMLProductDetailsEvaluateData(fromJson: evaluateDataJson)
			evaluateData.append(value)
		}
		message = json["message"].stringValue
	}

}

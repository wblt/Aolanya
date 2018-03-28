//
//	MMLWithdrawRecordModel.swift
//
//	Create by 家仟 黄 on 23/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLWithdrawRecordModel{

	var code : String!
	var data : [MMLWithdrawRecordData]!
	var message : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		code = json["code"].stringValue
		data = [MMLWithdrawRecordData]()
		let dataArray = json["data"].arrayValue
		for dataJson in dataArray{
			let value = MMLWithdrawRecordData(fromJson: dataJson)
			data.append(value)
		}
		message = json["message"].stringValue
	}

}
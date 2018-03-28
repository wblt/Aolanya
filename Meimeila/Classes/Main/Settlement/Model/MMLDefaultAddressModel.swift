//
//	MMLDefaultAddressModel.swift
//
//	Create by 家仟 黄 on 21/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLDefaultAddressModel{

	var code : String!
	var data : MMLDefaultAddressData!
	var message : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		code = json["code"].stringValue
		let dataJson = json["data"]
		if !dataJson.isEmpty{
			data = MMLDefaultAddressData(fromJson: dataJson)
		}
		message = json["message"].stringValue
	}

}
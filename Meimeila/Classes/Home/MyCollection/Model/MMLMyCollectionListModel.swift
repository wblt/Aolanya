//
//	MMLMyCollectionListModel.swift
//
//	Create by 家仟 黄 on 21/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLMyCollectionListModel{

	var code : String!
	var data : [MMLMyCollectionListData]!
	var message : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		code = json["code"].stringValue
		data = [MMLMyCollectionListData]()
		let dataArray = json["data"].arrayValue
		for dataJson in dataArray{
			let value = MMLMyCollectionListData(fromJson: dataJson)
			data.append(value)
		}
		message = json["message"].stringValue
	}

}
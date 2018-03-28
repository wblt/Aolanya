//
//	MMLDefaultAddressData.swift
//
//	Create by 家仟 黄 on 21/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLDefaultAddressData{

	var addAdress : String!
	var addresseePhone : String!
	var adressID : String!
	var consignee : String!
	var defaultAddress : String!
	var detailedAddress : String!
	var localArea : String!
	var postcode : String!
	var uid : String!
	var whetherChange : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		addAdress = json["addAdress"].stringValue
		addresseePhone = json["addresseePhone"].stringValue
		adressID = json["adressID"].stringValue
		consignee = json["consignee"].stringValue
		defaultAddress = json["defaultAddress"].stringValue
		detailedAddress = json["detailedAddress"].stringValue
		localArea = json["localArea"].stringValue
		postcode = json["postcode"].stringValue
		uid = json["uid"].stringValue
		whetherChange = json["whetherChange"].stringValue
	}

}
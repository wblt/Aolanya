//
//	MMLHomeDataModel.swift
//
//	Create by 家仟 黄 on 19/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLHomeDataModel{

	var banner : [MMLHomeDataBanner]!
	var code : String!
	var message : String!
	var modular : [MMLHomeDataModular]!
	var shoping : [MMLHomeDataShoping]!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		banner = [MMLHomeDataBanner]()
		let bannerArray = json["banner"].arrayValue
		for bannerJson in bannerArray{
			let value = MMLHomeDataBanner(fromJson: bannerJson)
			banner.append(value)
		}
		code = json["code"].stringValue
		message = json["message"].stringValue
		modular = [MMLHomeDataModular]()
		let modularArray = json["modular"].arrayValue
		for modularJson in modularArray{
			let value = MMLHomeDataModular(fromJson: modularJson)
			modular.append(value)
		}
		shoping = [MMLHomeDataShoping]()
		let shopingArray = json["shoping"].arrayValue
		for shopingJson in shopingArray{
			let value = MMLHomeDataShoping(fromJson: shopingJson)
			shoping.append(value)
		}
	}

}
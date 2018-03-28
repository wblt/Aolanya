//
//	MMLFoundBrandModel.swift
//
//	Create by 家仟 黄 on 14/11/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLFoundBrandModel{

	var banner : [MMLFoundBrandBanner]!
	var code : String!
	var foundBrand : [MMLFoundBrandFoundBrand]!
	var message : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		banner = [MMLFoundBrandBanner]()
		let bannerArray = json["banner"].arrayValue
		for bannerJson in bannerArray{
			let value = MMLFoundBrandBanner(fromJson: bannerJson)
			banner.append(value)
		}
		code = json["code"].stringValue
		foundBrand = [MMLFoundBrandFoundBrand]()
		let foundBrandArray = json["foundBrand"].arrayValue
		for foundBrandJson in foundBrandArray{
			let value = MMLFoundBrandFoundBrand(fromJson: foundBrandJson)
			foundBrand.append(value)
		}
		message = json["message"].stringValue
	}

}
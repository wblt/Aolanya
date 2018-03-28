//
//	MMLWithdrawRecordData.swift
//
//	Create by 家仟 黄 on 23/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class MMLWithdrawRecordData{

	var withdrawalsMoney : String!
	var withdrawalsName : String!
	var withdrawalsState : Int!
	var withdrawalsTime : String!
	var withdrawalsType : Int!
	var accessToken : String!
	var alipay : String!
	var applyTime : String!
	var expiresIn : String!
	var openid : String!
	var realName : String!
	var refreshToken : String!
	var uid : String!
	var unionid : String!
	var withdrawalsID : String!
	var withdrawalsAdmin : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		withdrawalsMoney = json["WithdrawalsMoney"].stringValue
		withdrawalsName = json["WithdrawalsName"].stringValue
		withdrawalsState = json["WithdrawalsState"].intValue
		withdrawalsTime = json["WithdrawalsTime"].stringValue
		withdrawalsType = json["WithdrawalsType"].intValue
		accessToken = json["access_token"].stringValue
		alipay = json["alipay"].stringValue
		applyTime = json["applyTime"].stringValue
		expiresIn = json["expires_in"].stringValue
		openid = json["openid"].stringValue
		realName = json["realName"].stringValue
		refreshToken = json["refresh_token"].stringValue
		uid = json["uid"].stringValue
		unionid = json["unionid"].stringValue
		withdrawalsID = json["withdrawalsID"].stringValue
		withdrawalsAdmin = json["withdrawals_admin"].stringValue
	}

}

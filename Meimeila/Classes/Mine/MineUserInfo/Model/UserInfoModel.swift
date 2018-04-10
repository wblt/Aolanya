//
//  UserInfoModel.swift
//  Mythsbears
//
//  Created by macos on 2017/10/11.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class UserInfoModel{


    var accessToken:String?;
    var addtime:String?;
    var birth:String?;
    var address:String?;
    var email:String?;
    var gender:String?;
    var inviter:String?;
    var ip:String?;
    var level:String?;
    var loginCount:String?;
    var name:String?;
    var occupation:String?;
    var openid:String?;
    var personalizedSignature:String?;
    var phone:String?;
    var picture:String?;
    var qq:String?;
    var realmName:String?;
    var statue:String?;
    var uid:String?;
    
    init(formJson json:JSON) {
        if json.isEmpty {
            return;
        }
        
        accessToken = json["accessToken"].stringValue;
        addtime = json["addtime"].stringValue;
        //出生年月日
        birth = json["birth"].stringValue;
        address = json["address"].stringValue;
        email = json["email"].stringValue;
        //性别
        gender = json["gender"].stringValue;
        inviter = json["inviter"].stringValue;
        ip = json["ip"].stringValue;
        level = json["level"].stringValue;
        loginCount = json["loginCount"].stringValue;
        name = json["name"].stringValue;
        //职业
        occupation = json["occupation"].stringValue;
        openid = json["openid"].stringValue;
        //个性签名
        personalizedSignature = json["personalizedSignature"].stringValue;
        phone = json["phone"].stringValue;
        //头像
        picture = json["picture"].stringValue;
        qq = json["qq"].stringValue;
        //真是姓名
        realmName = json["realmName"].stringValue;
        statue = json["statue"].stringValue;
        uid = json["uid"].stringValue;
    }
//-----------------------------------处理归档解档---------------------------------
//	// MARK:- 处理需要归档的字段
//	func encode(with aCoder:NSCoder) {
//		aCoder.encode(phone, forKey:"phone")
//		aCoder.encode(level, forKey:"level")
//		aCoder.encode(name, forKey:"name")
//	}
//
//	// MARK:- 处理需要解档的字段
//	required init(coder aDecoder:NSCoder) {
//		level = aDecoder.decodeObject(forKey:"level")as?String
//		phone = aDecoder.decodeObject(forKey:"phone")as?String
//		name = aDecoder.decodeObject(forKey:"name")as?String
//	}

//	//归档保存
//	func saveUserInfo(userModel:UserInfoModel) {
//		let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
//				archive									   FileManager.SearchPathDomainMask.userDomainMask,true).first!
//		let userAccountPath = "\(path)/userAccount.data"
//		NSKeyedArchiver.archiveRootObject(userModel, toFile: userAccountPath)
//	}
//	//获取用户的手机以及 等级信息
//	func getUserInfoFormDB() -> UserInfoModel {
//		let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
//													   FileManager.SearchPathDomainMask.userDomainMask,true).first!
//		let userAccountPath = "\(path)/userAccount.archive"
//		let userModel = UserInfoModel()
//		if NSKeyedUnarchiver.unarchiveObject(withFile:userAccountPath) != nil {
//
//			userModel = NSKeyedUnarchiver.unarchiveObject(withFile:userAccountPath)as? UserInfoModel
//			return userModel!
//		}
//		return userModel
//	}
	
}

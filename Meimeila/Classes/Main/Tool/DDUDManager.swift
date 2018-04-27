//
//  DDUDManager.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import UIKit


// MARK: - 使用方式
extension UserDefaults {
    struct ServerInfo: UserDefaultSettable {
        enum  UserDafaultKey: String {
            // 推送的token
            case pushToken
            case systemUUID
            case userToken
            case userID
			case level
			case aoLanYaAdmin  // 管理员  1  就是管理员
        }
    }
}

class DDUDManager {
    
    // 单例
    static let share = DDUDManager()
    private init(){}
    
    /**
     保存设备Token
     
     - parameter deviceToken: 设备Token
     
     - returns: true:保存成功 false:保存失败
     */
    @discardableResult
    func savePushToken(_ deviceToken: Data) -> Bool {
        
        let token: NSMutableString = NSMutableString(format: "%@", deviceToken as CVarArg)
        token.replaceOccurrences(of: " ", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSMakeRange(0, token.length))
        token.replaceOccurrences(of: "<", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSMakeRange(0, token.length))
        token.replaceOccurrences(of: ">", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSMakeRange(0, token.length))
        
        UserDefaults.ServerInfo.set(value: token, forKey: .pushToken)
        return UserDefaults.standard.synchronize()
    }
    
    /**
     保存设备Token
     
     - parameter deviceToken: 设备Token
     
     - returns: true:保存成功 false:保存失败
     */
    func savePushToken(_ deviceToken: String, ss:String = "") -> Bool {
        
        UserDefaults.ServerInfo.set(value: deviceToken, forKey: .pushToken)
        return UserDefaults.standard.synchronize()
    }
    
    
    /**
     设备token
     
     - returns: 设备token
     */
    func pushToken() -> String {
        
        if let token = UserDefaults.ServerInfo.string(forKey: .pushToken) {
            return token
        }else{
            return ""
        }
    }
    
    
    /**
     设备UUID
     
     - returns: 设备UUID
     */
    func uuid() -> String? {
        
        if let uuid = UserDefaults.ServerInfo.string(forKey: .systemUUID) {
            return uuid
        }else{
            
            let uuid = UIDevice.current.uuid
            UserDefaults.ServerInfo.set(value: uuid, forKey: .systemUUID)
            UserDefaults.standard.synchronize()
            return uuid
        }
    }
    
    
    // 保存用户的id
    func saveUserID(uid: String) {
        UserDefaults.ServerInfo.set(value: uid, forKey: .userID)
        UserDefaults.standard.synchronize()
    }
	
	
	/**
	删除用户id
	*/
	func removeUserID() -> Bool {
		UserDefaults.ServerInfo.removeObject(forkey: .userID)
		return UserDefaults.standard.synchronize()
	}
	
    
    // 获取用户id
    func getUserID() -> String {
        if let uid = UserDefaults.ServerInfo.string(forKey: .userID) {
            return uid
        }else{
            return ""
        }
    }
    
    /**
     保存用户Token
     
     - parameter token: 用户Token
     */
    func saveUserToken(_ token: String) {
        UserDefaults.ServerInfo.set(value: token, forKey: .userToken)
        UserDefaults.standard.synchronize()
    }
    
    /**
     删除用户Token
     */
    func removeUserToken() -> Bool {
        
        UserDefaults.ServerInfo.removeObject(forkey: .userToken)
        //NotificationCenter.default.post(name: cNDidLogout, object: nil)
        return UserDefaults.standard.synchronize()
    }
    
    /**
     读取用户Token
     
     - returns: 用户Token
     */
    func userToken() -> String {
        
        if let token = UserDefaults.ServerInfo.string(forKey: .userToken) {
            return token
        }else{
            return ""
        }
    }
	
	/**
	 保存用户等级Level
	*/
	func saveUserLevel(_ level:String) {
		UserDefaults.ServerInfo.set(value: level, forKey: .level)
		UserDefaults.standard.synchronize()
	}
	
	/**
	删除用户等级Level
	*/
	func removeUserLevel() -> Bool {
		
		UserDefaults.ServerInfo.removeObject(forkey: .level)
		//NotificationCenter.default.post(name: cNDidLogout, object: nil)
		return UserDefaults.standard.synchronize()
	}
	
	/**
	读取用户等级Level
	*/
	func getUserLevel() -> String {
		
		if let level = UserDefaults.ServerInfo.string(forKey: .level) {
			return level
		}else{
			return ""
		}
	}
	
	/**
	保存用户aoLanYaAdmin
	*/
	func saveUseraoLanYaAdmin(_ level:String) {
		UserDefaults.ServerInfo.set(value: level, forKey: .aoLanYaAdmin)
		UserDefaults.standard.synchronize()
	}
	
	/**
	删除用户aoLanYaAdmin
	*/
	func removeUseraoLanYaAdmin() -> Bool {
		
		UserDefaults.ServerInfo.removeObject(forkey: .aoLanYaAdmin)
		//NotificationCenter.default.post(name: cNDidLogout, object: nil)
		return UserDefaults.standard.synchronize()
	}
	
	/**
	读取用户aoLanYaAdmin
	*/
	func getUseraoLanYaAdmin() -> String {
		
		if let level = UserDefaults.ServerInfo.string(forKey: .aoLanYaAdmin) {
			return level
		}else{
			return ""
		}
	}
}

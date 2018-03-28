//
//  LoginAPI.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/6.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Alamofire

enum LoginAPI {
    case getSmsCode(phone: String, type: Int)
    case login(phone: String, password: String)
    case registered(phone: String, password: String, code: String ,inviate:String?)
    case changePassword(original: String, new: String, verify:String)
    case forgetPassword(phone: String, newPassword: String, sms:String)
    case outLogin
    case weChatLogin(openid:String,login_type:Int,name:String,gender:String,iconurl:String)

}

extension LoginAPI: Request {

    // 服务器基本地址
    var host: String {
        return API.baseServer
    }
    
    // 是否检查网络状态
    var isCheckNetStatus: Bool {
        return true
    }
    
    // 是否检查请求错误
    var isCheckRequestError: Bool {
        return true
    }
    
    // 方法名
    var path: String {
        switch self {
        case .getSmsCode(_, _):
            return API.smsCode
        case .login(_, _):
            return API.login
        case .registered(_, _, _, _):
            return API.register
        case .changePassword(original: _, new: _, verify: _):
            return API.checkPassword
        case .forgetPassword(phone:_, newPassword: _, sms: _):
            return API.findPassword
        case .outLogin:
            return API.userLogout
        case .weChatLogin(openid: _, login_type: _, name: _, gender: _, iconurl: _):
            return API.login_weChat
        }
    }
    
    // 请求类型
    var method: HTTPMethod {
        switch self {
        case .getSmsCode(_, _):
            return .post
        case .login(_, _):
            return .post
        case .registered(_, _, _, _):
            return .post
        case .changePassword(original: _, new: _, verify: _):
            return .post
        case .forgetPassword(phone: _, newPassword: _, sms: _):
            return .post
        case .outLogin:
            return .post
        case .weChatLogin(openid: _, login_type: _, name: _, gender: _, iconurl: _):
            return .post
        }
    }
    
    // 请求参数
    var parameters: [String: Any]? {
        switch self {
        case .getSmsCode(let phone, let type):
            // 公共参数 + 请求参数
            var param = postParameters()
            param["phone"] = phone
            param["type"] = "\(type)"
            param["message"] = DDGenerateARandomNumber()
            return DDIntegrationOfTheParameter(params: param)
            
        case .login(let phone, let password):
            var param = postParameters()
            param["phone"] = phone
            param["password"] = password.MD5.uppercased()
            return DDIntegrationOfTheParameter(params: param)
            
        case .registered(let phone, let password, let code, let inviter):
            var param = postParameters()
            param["phone"] = phone
            param["password"] = password.MD5.uppercased()
            param["code"] = code
            param["inviter"] = inviter
            return DDIntegrationOfTheParameter(params: param)
        
        case .changePassword(let original, let new, let verify):
            var param = postParameters()
            param["oldpassword"] = original
            param["password"] = new.MD5.uppercased()
            param["repassword"] = verify.MD5.uppercased()
            param["app_key"] = kApp_key
            return DDIntegrationOfTheParameter(params: param, isNeedLogin: true)
       
        case .forgetPassword(let phone, let newPassword,let sms):
            var param = postParameters()
            param["phone"] = phone
            param["password"] = newPassword.MD5.uppercased()
            param["code"] = sms
            return DDIntegrationOfTheParameter(params: param)
            
        case .weChatLogin(let openid,let login_type,let name,let gender,let iconurl):
            var param = postParameters()
            param["openid"] = openid
            param["login_type"] = login_type
            param["name"] = name
            param["gender"] = gender
            param["iconurl"] = iconurl
            return DDIntegrationOfTheParameter(params: param, isNeedLogin: true);
      
        case .outLogin:
            let param =  postParameters()
            return DDIntegrationOfTheParameter(params: param ,isNeedLogin: true);
        }
        
    }
    
}

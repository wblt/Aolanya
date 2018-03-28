//
//  UserInfoAPI.swift
//  Mythsbears
//
//  Created by macos on 2017/10/11.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum UserInfoAPI {
    case userInfo
    case userIconUpload(image:UIImage)
    case userMemberLv
    case userInfoUpData(name:String? ,sex:String?,age:String?,
        email:String?,qq:String?,address:String?,personalizedSignature:String?,
        occupation:String?)
}

extension UserInfoAPI:Request{
    var host: String {
        
        switch self {
        case .userInfo:
            return API.baseServer
        case .userMemberLv:
            return API.baseServer
        case .userInfoUpData(name: _, sex: _, age: _, email: _,qq:_,address:_,personalizedSignature:_,occupation:_):
            return API.baseServer
        case .userIconUpload(image: _):
            return API.baseServer

        }
    }
    
    var isCheckNetStatus: Bool {
        return true
    }
    
    var isCheckRequestError: Bool {
        return true
    }
    
    var path:String{
        
        switch self {
        case .userInfo:
            return API.userInfoAPI
        case .userIconUpload(image:_):
            return API.feedbackImg
        
        case .userMemberLv:
            return API.memberLevelAPI
            
        case .userInfoUpData(name: _, sex: _, age: _, email: _, qq: _, address: _, personalizedSignature: _, occupation: _):
            return API.userInfoUpDataAPI
        }
        
    }
    
    
    var parameters: [String : Any]? {
        switch self {
        case .userInfo:
            let params = postParameters()
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
       
        case .userIconUpload(let image):
            var params = postParameters()
            params["attach"] = image
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        
        case .userMemberLv:
            let params = postParameters()
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        case .userInfoUpData(let name, let sex,let age,let email, let qq,let address,let personalizedSignature, let occupation):
            var params = postParameters()
            
            if let _ = name {
                params["name"] = name!
            }
            
            if let _  = sex {
                params["gender"] = sex!
            }
            
            if let _  = age {
                params["birth"] = age!
            }
            
            if let _ = email{
                params["email"] = email!;
            }
            
            if let _ = qq{
                params["qq"] = qq!;
            }
            
            if let _ = address{
                params["address"] = address!;
            }
            
            if let _ = personalizedSignature{
                params["personalizedSignature"] = personalizedSignature!;
            }
            
            if let _ = occupation{
                params["occupation"] = occupation!;
            }
            
       
            
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        }
        
    }
    
}

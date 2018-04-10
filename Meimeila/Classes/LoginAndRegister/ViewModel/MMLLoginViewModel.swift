//
//  MMLLoginViewModel.swift
//  Meimeila
//
//  Created by macos on 2017/10/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class MMLLoginViewModel {
    
    static let shared = MMLLoginViewModel();
    private init(){}
    
    //登录
    func loginAction(phone:String ,password:String ,succeed:@escaping () -> Void) {
        
        let getLogin = LoginAPI.login(phone: phone, password:password);
        
        DDHTTPRequest.request(r: getLogin, requestSuccess: { (responds) in
            
            print(responds);
            // 保存用户的uid和token
            let jsonResult = JSON.init(responds)
            let uid = jsonResult["data"]["uid"].stringValue
            let token = jsonResult["data"]["token"].stringValue
			let level = jsonResult["data"]["level"].stringValue
            DDUDManager.share.saveUserID(uid: uid)
            DDUDManager.share.saveUserToken(token)
			DDUDManager.share.saveUserLevel(level)

			BFunction.shared.showToastMessge(jsonResult["message"].stringValue)
            
            DDDeviceManager.shared.saveLoginStatue(isLogin: true);
            succeed();
            
        }, requestError: { (responds, errorModel) in
            
            print(responds,errorModel.message,errorModel.status);
            
            BFunction.shared.showErrorMessage(errorModel.message);
            
        }) { (Error) in
            
            print(Error);
        }
        
        
    }
    
    //注册
    func registerAction(phone:String,password:String,sms:String,inviter:String?,succeeds:@escaping ()->()) {
        let goRegister = LoginAPI.registered(phone: phone, password: password, code: sms,inviate: inviter);
        
        DDHTTPRequest.request(r: goRegister, requestSuccess: { (responds) in
            
            BFunction.shared.showSuccessMessage("注册成功");
            
            succeeds();
            
        }, requestError: { (responds, ErrorModel) in
            BFunction.shared.showErrorMessage(ErrorModel.message);
            
        }) { (Error) in
            
            
        }
    }
    
    //忘记密码
    func forgetPasswordAction(phone:String,newPassword:String,sms:String) {
        let r = LoginAPI.forgetPassword(phone: phone, newPassword: newPassword, sms: sms);
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            
            BFunction.shared.showSuccessMessage("设置成功");
            
        }, requestError: { (responds, ErrorModel) in
            BFunction.shared.showErrorMessage(ErrorModel.message);
            
        }) { (Error) in
            
            
        }
    }
    
    //修改密码
    func changePasswordAction(original:String, newPassword:String ,verifyPassword:String) {
        
        let r = LoginAPI.changePassword(original: original, new: newPassword, verify: verifyPassword);
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            
            BFunction.shared.showSuccessMessage("修改成功");
            
        }, requestError: { (responds, ErrorModel) in
            
            BFunction.shared.showErrorMessage(ErrorModel.message);
            
        }) { (Error) in
            BFunction.shared.showErrorMessage("error");
            
        }
    }
    
    
    //获取验证码
    func getSMSAction(phone:String,type:Int,succeeds:@escaping ( _ isSucceeds:Bool) -> Void){
        
        let r = LoginAPI.getSmsCode(phone: phone, type: type);
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            
            succeeds(true);
            
        }, requestError: { (responds, ErrorModel) in
            
            BFunction.shared.showErrorMessage(ErrorModel.message);
            
        }) { (Error) in
            
        }
    }
    
    //退出登录
    func outLoginAction(outSucceed:@escaping () -> Void) {
        
        let r = LoginAPI.outLogin;
        print(r);
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            
            let json = JSON.init(responds);
            BFunction.shared.showToastMessge(json["message"].stringValue);
			
//			DDUDManager.share.removeUserToken();
//			DDUDManager.share.removeUserID();
			DDUDManager.share.saveUserID(uid: "0");
			DDUDManager.share.saveUserToken("0")
			
            DDDeviceManager.shared.saveLoginStatue(isLogin: false);
            
            outSucceed();
            
        }, requestError: { (responds, ErrorModel) in
            
            BFunction.shared.showErrorMessage(ErrorModel.message);
            DDUDManager.share.saveUserToken("");
            DDDeviceManager.shared.saveLoginStatue(isLogin: false);
            
        }) { (Error) in
            DDUDManager.share.saveUserToken("");
            DDDeviceManager.shared.saveLoginStatue(isLogin: false);
            
        }
    }
    
    
    ///微信登录
    func loginWeChatAction(openid:String ,name:String,gender:String,iconurl:String ,succeed:@escaping () -> Void) {
        
        let r = LoginAPI.weChatLogin(openid: openid, login_type: 1, name: name, gender: gender, iconurl: iconurl)
        
        DDHTTPRequest.requestWithJsonCoding(r: r, requestSuccess: { (responds) in
            
            print(responds);
            // 保存用户的uid和token
            let jsonResult = JSON.init(responds)
            let uid = jsonResult["data"]["uid"].stringValue
            let token = jsonResult["data"]["token"].stringValue
            DDUDManager.share.saveUserID(uid: uid)
            DDUDManager.share.saveUserToken(token)
            BFunction.shared.showToastMessge(jsonResult["message"].stringValue)
            
            DDDeviceManager.shared.saveLoginStatue(isLogin: true);
            succeed();
            
        }, requestError: { (responds, errorModel) in
            
            print(responds,errorModel.message,errorModel.status);
            
            BFunction.shared.showErrorMessage(errorModel.message);
            
        }) { (Error) in
            
            print(Error);
        }
        
        
    }
    
}

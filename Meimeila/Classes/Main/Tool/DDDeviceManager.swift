//
//  DDDeviceManager.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/7.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// MARK: - 使用方式
extension UserDefaults {
    struct DeviceInfo: UserDefaultSettable {
        enum  UserDafaultKey: String {
            // 加载引导图
            case firstLoad
            // 是否显示新手福利
            case isShowNewsWelfare
            // 是否登录
            case isLogin
        }
    }
}


class DDDeviceManager {

    static let shared = DDDeviceManager()
    private init() {}
    
    // 是否第一次启动
    func saveFirstLoadStatus(isFirst: Bool) {
        UserDefaults.DeviceInfo.set(value: isFirst, forKey: .firstLoad)
        UserDefaults.standard.synchronize()
    }
    
    func firstLoadStatus() ->  Bool{
        if let firstLoad = UserDefaults.DeviceInfo.bool(forKey: .firstLoad) {
            return firstLoad
        }
        return false
    }
    
    // 是否显示新手福利
    func saveShowNewsWelfare(isShowNewsWelfare: Bool) {
        UserDefaults.DeviceInfo.set(value: isShowNewsWelfare, forKey: .isShowNewsWelfare)
        UserDefaults.standard.synchronize()
    }
    
    func showNewsWelfare() ->  Bool{
        if let isShowNewsWelfare = UserDefaults.DeviceInfo.bool(forKey: .isShowNewsWelfare) {
            return isShowNewsWelfare
        }
        return false
    }
    
    
    // 是否登录
    func saveLoginStatue(isLogin: Bool) {
        UserDefaults.DeviceInfo.set(value: isLogin, forKey: .isLogin)
        UserDefaults.standard.synchronize();
    }
    
    func loginStatue() -> Bool {
        
        if  let login = UserDefaults.DeviceInfo.bool(forKey: .isLogin) {
            return login
        }
        return false;
    }
    
}

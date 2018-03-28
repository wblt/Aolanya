//
//  AppDelegate-RongCloud.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/14.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation

private let kRongCloudAppKey = ""
private let isNeedRongCloudMessagPush = false

// 客服ID
let kRongcloudServiceID = ""


extension AppDelegate {
    
    // 聊天初始化
    func initRongcloud() {
        
        // 初始化
        RCIM.shared().initWithAppKey(kRongCloudAppKey)
        // 设置用户信息的提供者
        RCIM.shared().userInfoDataSource = DDRongCloudDataMannager.shared
        RCIM.shared().groupInfoDataSource = DDRongCloudDataMannager.shared
        // 如果设置为yes 则会在每一条发送的消息中携带当前登录用户的用户信息
        RCIM.shared().enableMessageAttachUserInfo = true
    }
    
    // 注册融云消息推送
    func RongCloud_register(application: UIApplication) {
        if isNeedRongCloudMessagPush {
            if #available(iOS 10.0, *) {
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
                    if error == nil {
                        DispatchQueue.main.async {
                           application.registerForRemoteNotifications()
                        }
                    }
                })
            }else if #available(iOS 8.0, *) {
                let setting = UIUserNotificationSettings.init(types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(setting)
            }else {
                UIApplication.shared.registerForRemoteNotifications(matching: [.alert, .badge, .sound])
            }
        }
    }
    
    // 注册融云推送token
    func RongCloud_registerToken(deviceToken: Data) {
        if isNeedRongCloudMessagPush {
            let data = NSData.init(data: deviceToken)
            let token = data.description.replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: "")
            RCIMClient.shared().setDeviceToken(token)
        }
    }
    
    // 接送融云推送的消息
    func RongCloud_receiveRemoteNotification(didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        if isNeedRongCloudMessagPush {
            debugLog("融云接送到的推送消息：\(userInfo)")
        }
    }
    
    

}

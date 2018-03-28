//
//  AppDelegate-JPush.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/14.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation


private let kJPushAppKey = ""
private let kJPushChanel = "Publish channel"
// 是否是发布环境
private let isApsProduct = false

// 是否需要极光推送
private let isNeedOpenJPush = false

extension AppDelegate {

    // 注册极光推送
    func JPush_register(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        
        if isNeedOpenJPush {
            // 通知注册实体类
            let entity = JPUSHRegisterEntity()
            entity.types = Int(JPAuthorizationOptions.alert.rawValue) | Int(JPAuthorizationOptions.sound.rawValue) | Int(JPAuthorizationOptions.badge.rawValue); JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
            // 注册极光推送
            JPUSHService.setup(withOption: launchOptions, appKey: kJPushAppKey, channel: kJPushChanel, apsForProduction: isApsProduct)
            
            // 2.1.9版本新增获取registration id block接口
            JPUSHService.registrationIDCompletionHandler { (resCode, registrationID) in
                if resCode == 0 {
                    debugLog("获取registrationID成功---->" + (registrationID ?? ""))
                }else {
                    debugLog("获取registrationID失败")
                }
            }
        }

    }
    
}

// MARK: - JPUSHRegisterDelegate
extension AppDelegate: JPUSHRegisterDelegate {
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
            debugLog("iOS10 前台收到远程通知\(userInfo)")
        }else {
            debugLog("收到本地推送消息")
        }
        
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue | UNNotificationPresentationOptions.sound.rawValue | UNNotificationPresentationOptions.badge.rawValue))
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
            debugLog("iOS10收到远程推送消息\(userInfo)")
        }else {
            debugLog("收到本地推送消息")
        }
        completionHandler()
    }
    
}

// 收到极光推送的远程消息
extension AppDelegate {
    
    // 注册APNs成功并上报DeviceToken
    func JPush_registerDeviceToken(deviceToken: Data) {
        if isNeedOpenJPush {
           JPUSHService.registerDeviceToken(deviceToken)
        }
    }
    
    func JPush_receiveLocalNotification(notification: UILocalNotification) {
        if isNeedOpenJPush {
            if #available(iOS 10.0, *) {
                //iOS 10以上系统
            } else {
                //iOS 10之前的系统
                JPUSHService.showLocalNotification(atFront: notification, identifierKey: "")
            }
        }

    }
    
    // ios 7及以上系统收到推送通知
    func JPush_receiveRemoteNotification(didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        if isNeedOpenJPush {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        
    }
}

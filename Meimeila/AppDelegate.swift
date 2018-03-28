//
//  AppDelegate.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let baseTabBar = DDTabBarViewController();
    let manager = NetworkReachabilityManager(host: "https://developer.apple.com")
    var isHaveNetwork: Bool = true
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        jq_application(application, didFinishLaunchingWithOptions: launchOptions)
        // 注册极光推送
        JPush_register(launchOptions: launchOptions)
        // 注册融云推送
        RongCloud_register(application: application)
        window?.rootViewController = baseTabBar
        
        return true
    }
    
}

// MARK: - 推送相关
extension AppDelegate {
    // 上传deviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPush_registerDeviceToken(deviceToken: deviceToken)
        RongCloud_registerToken(deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugLog("远程推送注册失败")
    }
    
    // 本地推送通知
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        JPush_receiveLocalNotification(notification: notification)
    }
    
    // ios7及以上系统收到通知
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPush_receiveRemoteNotification(didReceiveRemoteNotification: userInfo)
        RongCloud_receiveRemoteNotification(didReceiveRemoteNotification: userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    // apns 在ios8系统中，还需要添加这个方法，通过新的api注册推送服务
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }
}

// MARK: - 应用生命周期相关
extension AppDelegate {
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// MARK: - 微信支付和支付宝支付相关
extension AppDelegate {
    // // NOTE: 9.0以后使用新API接口
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        debugLog(url.host)
        if url.host == "safepay" {
            // 支付宝支付
            alipay_application(app, open: url, options: options)
        }else if (url.host == "pay" || url.host == "oauth") { // 微信
            return wechat_application(app, handleOpen: url)
        }else if (url.host?.hasPrefix("shopingID"))!{
            openProductDetails(url: url.host)
        }else{ // 友盟推送
            return UMeng_handleOpenURL(url: url, options: options)
            
        }
        return true
    }
    
    // iOS 8
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if url.host == "safepay" {
            // 支付宝支付
            alipay_application(application, open: url, options: [:])
        }else if (url.host == "pay" || url.host == "oauth") { // 微信
            return wechat_application(application, handleOpen: url)
        }else if (url.host?.hasPrefix("shopingID"))!{
            openProductDetails(url: url.host)
        }else {
            return UMeng_handleOpenURL(url: url)
        }
        return true
        
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.host == "safepay" {
            // 支付宝支付
            alipay_application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        } else if (url.host == "pay" || url.host == "oauth") {
            return wechat_application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        }else if (url.host?.hasPrefix("shopingID"))!{
            openProductDetails(url: url.host)
        }else {
            return UMeng_handleOpenURL(url: url, sourceApplication: sourceApplication ?? "", annotation: annotation)
        }
        return true
    }

    
    // 打开商品详情页面
    private func openProductDetails(url: String?) {
        let array = url?.components(separatedBy: "=")
        var shopingID = " "
        if  !(array?.isEmpty)!{
            if array!.count > 1  {
                shopingID = array![1]
            }
        }
        
        if let nav: UINavigationController =  baseTabBar.selectedViewController as? UINavigationController {
            nav.popToRootViewController(animated: false)
            baseTabBar.tabBarController?.selectedIndex = 0
            let currentNav = baseTabBar.selectedViewController as! UINavigationController
            let VC = MMLProductDetailsVC()
            VC.shoppingID = shopingID
            currentNav.pushViewController(VC, animated: true)
        }
    }
    
    
}



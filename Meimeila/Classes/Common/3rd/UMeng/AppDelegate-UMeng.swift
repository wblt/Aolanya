//
//  AppDelegate-UMeng.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation

private let UMengAppkey = "5a139a8fb27b0a33b5000044"
private let UmSocialAppSecret = ""
private let kWebsiteLinks = "http://nnddkj.com"

// QQ
private let QQ_AppId = "1106420525"
private let QQ_APPSecret = "E2ivF5s0hgPQsuVX"

// sina
private let Sina_AppId = "3921700954"
private let Sina_APPSecret = "04b48b094faeb16683c32669824ebdad"

extension AppDelegate {
    
    //  友盟的相关配置
    func UMeng_Setup() {
        
        UMeng_SetupTrack()
        UMeng_SetupShare()
    }
    
    // 设置友盟的回调
    func UMeng_handleOpenURL(url: URL) -> Bool {
        return UMSocialManager.default().handleOpen(url)
    }
    
    func UMeng_handleOpenURL(url: URL, options: [AnyHashable : Any]) -> Bool {
        return UMSocialManager.default().handleOpen(url, options: options)
    }
    
    func UMeng_handleOpenURL(url: URL, sourceApplication: String, annotation: Any) -> Bool{
        return UMSocialManager.default().handleOpen(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    // MARK: - Private methods
    // 友盟统计
    private func UMeng_SetupTrack() {
        //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
        //MobClick.setAppVersion(XcodeAppVersion)
        // 是否开启日志
        MobClick.setLogEnabled(true)
        UMAnalyticsConfig.sharedInstance().appKey = UMengAppkey
        UMAnalyticsConfig.sharedInstance().secret = "secretstringaldfkals"
        MobClick.setCrashReportEnabled(true)
        MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())
        
    }
    
    // 友盟分享
    private func UMeng_SetupShare() {
        // 开启日志调试
        UMSocialManager.default().openLog(true)
        UMSocialManager.default().umSocialAppkey = UMengAppkey
        UMSocialManager.default().umSocialAppSecret = "secretstringaldfkals"
        
        /* 设置微信的appKey和appSecret */
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: WX_APPID, appSecret: WX_APPSecret, redirectURL: kWebsiteLinks)
        
        // QQ
        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: QQ_AppId, appSecret: QQ_APPSecret, redirectURL: kWebsiteLinks)
        
        // 微博
        UMSocialManager.default().setPlaform(UMSocialPlatformType.sina, appKey: Sina_AppId, appSecret:  Sina_APPSecret, redirectURL: kWebsiteLinks)
    }
    
    
    
}

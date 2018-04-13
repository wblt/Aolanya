//
//  Application-Extension.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import Kingfisher
import IQKeyboardManagerSwift

extension AppDelegate {
    
    public func jq_application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        //sleep(1)
        if #available(iOS 11.0, *) {
            // 适配iOS 11的系统
           UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .red
        window?.makeKeyAndVisible()
        //UIApplication.shared.statusBarStyle = .lightContent;
        configImages()
        // 初始化友盟推送
        UMeng_Setup()
        // 初始化微信配置
	    wechat_setup()
    
    }
    
    // 如果收到内存警告清除内存缓存
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        getImageCache().clearMemoryCache()
    }
    
    // 监听当前的网络状态
    private func monitorTheNetworkStatusAction() {
        manager!.listener = { status in
            switch status {
            case .notReachable:
                self.isHaveNetwork = false
            case .unknown:
                self.isHaveNetwork = false
            case .reachable(.ethernetOrWiFi):
                self.isHaveNetwork = true
            case .reachable(.wwan):
                self.isHaveNetwork = true
            }
        }
        manager!.startListening()
    }
    
    // MARK: - 关于图片设置
    private func configImages() {
        
        let cache = KingfisherManager.shared.cache
        
        // 设置硬盘最大缓存50M ，默认无限
        cache.maxDiskCacheSize = 50 * 1024 * 1024
        // 设置硬盘最大保存3天 ， 默认1周
        cache.maxCachePeriodInSecond = 60 * 60 * 24 * 3
    }
    
    // 获取ImageCache instance
    public func getImageCache() -> ImageCache {
        return KingfisherManager.shared.cache;
    }
    
}

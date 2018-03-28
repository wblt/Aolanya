//
//  DDRongCloudDataMannager.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/14.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// 融云数据的提供者
class DDRongCloudDataMannager: NSObject {
   
    // 单例
    static let shared = DDRongCloudDataMannager()
    private override init() {}
    
    // 登录
    func loginRongCloudWithUserInfo(userInfo: RCUserInfo?, token: String) {
        // 使用token来登录
        // B/YgF2FvtiaGkt66w7D2b2QWQazupcxbl6fLmhkZye24UOiUKcjC7HC3XKJRpwBWq+SPGCOFQlqMJP/UyK2RoA==
        RCIM.shared().connect(withToken: token, success: { (sucessResult) in
            
            print("用户id\(String(describing: sucessResult))")
            //RCIM.shared().globalNavigationBarTintColor = UIColor.red
            
            // 同步好友信息
            
            // 设置当前登录的用户信息
            RCIMClient.shared().currentUserInfo = userInfo
            DDRongCloudDataMannager.shared.refreshBadgeValue()
            
        }, error: { (errorCode) in
            
            print("登录的错误码为：\(errorCode)")
            
        }, tokenIncorrect: {
            print("token错误")
        })
    }
    
    
    // 获取未读的消息数
    func refreshBadgeValue() {
        // 在主线程中更新UI
        DispatchQueue.main.async {
            let typeArray = [
                RCConversationType.ConversationType_PRIVATE,
                RCConversationType.ConversationType_DISCUSSION,
                RCConversationType.ConversationType_GROUP,
                RCConversationType.ConversationType_CHATROOM
            ]
            let unReadMessageCount = RCIMClient.shared().getUnreadCount(typeArray)
            print("当前未读的消息数--->\(unReadMessageCount)")
        }
    }
    
    
}

extension DDRongCloudDataMannager: RCIMUserInfoDataSource {
    
    func getUserInfo(withUserId userId: String!, completion: ((RCUserInfo?) -> Void)!) {
        
    }
    
}

extension DDRongCloudDataMannager: RCIMGroupInfoDataSource {
    func getGroupInfo(withGroupId groupId: String!, completion: ((RCGroup?) -> Void)!) {
        
    }
}

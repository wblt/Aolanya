//
//  Meimeila_bridge.h
//  Meimeila
//
//  Created by HJQ on 2017/10/16.
//  Copyright © 2017年 HJQ. All rights reserved.
//

#ifndef Meimeila_bridge_h
#define Meimeila_bridge_h

// MD5的头文件
#import <CommonCrypto/CommonCrypto.h>
// 微信支付
#import "WXApi.h"
// 支付宝
#import <AlipaySDK/AlipaySDK.h>
// 蓝牙
#import "BabyBluetooth.h"

// 引入极光推送所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

// 融云
#import <RongIMKit/RongIMKit.h>

// 友盟
#import <UMMobClick/MobClick.h>
#import <UMSocialCore/UMSocialCore.h>

#import <StreamingKit/STKAudioPlayer.h>

// 模拟微信弹框
#import "HCPopupCommon.h"
#import "HCBasePopupViewController.h"
#import "HCBottomPopupAction.h"
#import "HCBottomPopupViewController.h"
#import "HCCenterPopAlertViewController.h"

//广告页
#import "AdvertiseView.h"
#import "AdvertiseViewController.h"

#endif /* Meimeila_bridge_h */

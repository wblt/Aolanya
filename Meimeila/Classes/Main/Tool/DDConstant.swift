//
//  DDConstant.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import UIKit


// MARK: - 自定义Log打印
func debugLog<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName):(\(lineNum))-\(messsage)")
    #endif
}

enum ShoppingCarBottomViewBtnType: Int {
    // 全选删除按钮
    case deletedSelectedAllType = 0
    // 全选结算按钮
    case tosettleaccountsSelectedAllType = 1
    // 删除
    case deletedType = 2
    // 去结算
    case tosettleaccountsType = 3
}

// 屏幕相关
struct Screen {
    static var width = UIScreen.main.bounds.size.width
    static var height = UIScreen.main.bounds.size.height
}

// 全局的背景颜色
func DDGlobalBGColor() -> UIColor {
    return UIColor.init(r: 243, g: 244, b: 245)
}

// 导航栏标题颜色
func DDGlobalNavTitleColor() -> UIColor {
    return UIColor.init(r: 58, g: 58, b: 58)
}

// 导航栏背景颜色
func DDGlobalNavBarColor() -> UIColor {
    return UIColor.init(r: 60, g: 182, b: 74)
}

// 获取重用标识
func DDGetReuseidentifier(subject: AnyClass) -> String{
    return String.init(describing: subject)
}

// 时间戳转时间
func timestampToDate(format: String, timestamp: String) -> String{
    let time = Double(timestamp)
    let dateF = DateFormatter()
    dateF.dateFormat = format
    let date = Date.init(timeIntervalSince1970: time!)
    return dateF.string(from: date)
}

// 获取当前的时间戳
func DDGetNowTimestamp() -> Int64 {
    //return Int(Date.currentTimestamp())
    let now = Date()
    //当前时间的时间戳
    let timeInterval: TimeInterval = now.timeIntervalSince1970
    let timeStamp = Int64(timeInterval * 1000)
    return timeStamp
}

// 生成一个六位随机数
func DDGenerateARandomNumber() -> Int {
//    let numberLength = 6
//    let sourceStr = "123456789"
//    var resultStr = ""
//    for i in 0..<sourceStr.count {
//        let index = Int(Int(arc4random()) % Int(sourceStr.count))
//        // 截取一位
//        //_ = sourceStr.index(index, offsetBy: 1)
//    }
    
    return Int(arc4random() % 1000000)
}

// 整合参数
func DDIntegrationOfTheParameter(params: [String: Any], isNeedLogin: Bool = false) -> [String: Any] {
    
    var token = DDUDManager.share.userToken()
    var key: String = ""
    let uid = DDUDManager.share.getUserID()
    
    var keysDict = params
    if isNeedLogin { // 如果需要登录
        if !(uid == "") {
            keysDict["uid"] = uid
        }
        //keysDict["app_key"] = ""
        if !(token == "") {
            keysDict["token"] = token
        }
    }else {
        token = ""
    }
    
    // 按照键升序排序
    let asceArrTemp = keysDict.sorted(by: { (t1, t2) -> Bool in
        return String(t1.0).compare(String(t2.0)) == ComparisonResult.orderedAscending
        //return t1.0 < t2.0 ? true : false
    })
    //debugLog("升序后的数据\(asceArrTemp)")
    for (k,v) in asceArrTemp {
        key += k + "\(v)"
    }
    debugLog("拼接成的key = " + key)
    
    // 密钥
    let secret = kSecret
    let contentStr = (secret + key + token).mattress_MD5()!.uppercased()
    keysDict["sign"] = contentStr
    return keysDict
}

/// 签名相关
// 常量App_key
let kApp_key = ""
// 密钥
let kSecret = ""

// 图片的前缀链接
let kPrefixLink = "http://meimeila.nnddkj.com/"

// 导航栏(动态获取主要为了适配iphone X)
let kNavigationBarH : CGFloat = 44.0
let kTabBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height > 20 ? 83 : 49
let kStatusBarH : CGFloat = UIApplication.shared.statusBarFrame.size.height

/// 首页头部的功能
let kHomefunction: Double = 100.0

/// 首页间距
let kHomeSpace: Double = 10.0

/// 首页关爱
let kHomecare: Double = 76.0




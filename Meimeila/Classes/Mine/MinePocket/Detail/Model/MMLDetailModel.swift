//
//  MMLDetailModel.swift
//  Meimeila
//
//  Created by macos on 2017/11/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class MMLDetailModel {

//    "id": "21",  //明细表id
//    "uid": "10083",  //用户id
//    "amount": "0.02",  //金额
//    "amountSource": "未知",  //来源
//    "createTime": "1504598253",  //交易时间时间
//    "balance": "50.3",  //用户余额
//    "payType": "4",  //支付方式:1是支付宝支付,2是微信支付,3是余额支付
//    "remarks": "午间签到领取红包",  //备注
//    "orderDetail": "签到领取红包",  //订单详情
//    "orderID": "签到领取红包",  //订单id
//    "isPay": "2"  //是否支付，1是支付2是收入
    
    var id:String?
    var uid:String?
    var amount:String?
    var amountSource:String?
    var createTime:String?
    var balance:String?
    var payType:String?
    var remarks:String?
    var orderDetail:String?
    var orderID:String?
    var isPay:Int?
    
    
    init(from json:JSON) {
        id = json["id"].stringValue
        uid = json["uid"].stringValue
        amount = json["amount"].stringValue
        amountSource = json["amountSource"].stringValue
        createTime = json["createTime"].stringValue
        balance = json["balance"].stringValue
        payType = json["payType"].stringValue
        remarks = json["remarks"].stringValue
        orderDetail = json["orderDetail"].stringValue
        orderID = json["orderID"].stringValue
        isPay = json["isPay"].intValue

    }
    
}

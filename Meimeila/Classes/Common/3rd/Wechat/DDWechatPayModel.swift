//
//  DDWechatPayModel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/10.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class DDWechatPayModel {

//    // appid
//    var appid: String = ""
//    // 商户号
//    var partnerid: String = ""
//    // 预支付id
//    var prepayid: String = ""
//    // 时间戳
//    var timestamp: UInt32 = 0
//    // 随机串
//    var nonceStr: String = ""
//    // 加密串
//    var package: String = ""
//    var sign: String = ""
    
    var appid : String!
    var noncestr : String!
    var package : String!
    var partnerid : String!
    var prepayid : String!
    var sign : String!
    var timestamp : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        appid = json["appid"].stringValue
        noncestr = json["noncestr"].stringValue
        package = json["package"].stringValue
        partnerid = json["partnerid"].stringValue
        prepayid = json["prepayid"].stringValue
        sign = json["sign"].stringValue
        timestamp = json["timestamp"].intValue
    }
}

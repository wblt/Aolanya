//
//  DDWechatLoginResultModel.swift
//  Mythsbears
//
//  Created by macos on 2017/10/31.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class DDWechatLoginResultModel {

    var city:String?
    var headimgurl:String?
    var unionid:String?
    var openid:String?
    var nickname:String?
    var language:String?
    var province:String?
    var sex:String?
    var country:String?
    
    
    init(from json:JSON) {
        
        city = json["city"].stringValue
        headimgurl = json["headimgurl"].stringValue
        unionid = json["unionid"].stringValue
        openid = json["openid"].stringValue
        nickname = json["nickname"].stringValue
        language = json["language"].stringValue
        province = json["province"].stringValue
        sex = json["sex"].stringValue
        country = json["country"].stringValue
    }
    
}

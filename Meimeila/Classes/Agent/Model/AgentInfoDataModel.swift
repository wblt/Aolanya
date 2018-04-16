//
//  AgentInfoDataModel.swift
//  Meimeila
//
//  Created by wy on 2018/4/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class AgentInfoDataModel {
    // 共有的
    var uid : String!
    var realName : String!
    var level : String!
    var phone : String!
    var weChat : String!
    var address : String!
    
    //上级代理人拥有的属性
    var regionAdress : String!
    var temporaryRegionLevel : String!
    var aoLanYaAdmin : String!
    
    //下级代理人拥有的属性
    var inviter : String!
    var weChatPayment : String!
    var alipayPayment : String!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        uid = json["uid"].stringValue
        realName = json["realName"].stringValue
        level = json["level"].stringValue
        phone = json["phone"].stringValue
        weChat = json["weChat"].stringValue
        address = json["address"].stringValue
        
        inviter = json["inviter"].stringValue
        weChatPayment = json["weChatPayment"].stringValue
        alipayPayment = json["alipayPayment"].stringValue
    }
    
   
    
}

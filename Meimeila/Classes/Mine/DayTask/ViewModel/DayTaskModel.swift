//
//  DayTaskModel.swift
//  Mythsbears
//
//  Created by macos on 2017/11/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class DayTaskModel{

//
//    "id": "1",
//    "name": "每日分享",
//    "type": "1",  //1是分享，2是敷面膜，3是商城购物
//    "reward": "20",
//    "shopingID": "1257",
//    "status": "0"
 
    
    var id:String?
    var name:String?
    var reward:String?
    var status:String?
    var type:String?
    var shopingID:String?
    
    var statusSteing = "未完成"
    
    init(from json:JSON) {
        
        id = json["id"].stringValue;
        name = json["name"].stringValue;
        reward = json["reward"].stringValue;
        status = json["status"].stringValue;
        type = json["type"].stringValue;
        shopingID = json["shopingID"].stringValue;
        
        if status == "0"{
            statusSteing = "未完成";
        }else{
            statusSteing = "已完成";
        }
    
    }
    
}

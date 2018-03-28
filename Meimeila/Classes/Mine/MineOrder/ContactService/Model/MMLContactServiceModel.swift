//
//  MMLContactServiceModel.swift
//  Meimeila
//
//  Created by macos on 2017/12/29.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class MMLContactServiceModel: NSObject {

//    "id": "1",
//    "name": "客服电话",
//    "type": "1",     //1是客服电话，2是客服微信号，3是邮箱，4是微信粉丝福利群
//    "contact": "400-611-5808"
    
    var id:String?
    var name:String?
    var type:Int?
    var contact:String?
    
    var title:String?
    
    init(from json:JSON) {
        
        id = json["id"].stringValue;
        name = json["name"].stringValue;
        type = json["type"].intValue;
        contact = json["contact"].stringValue;
        
        if type == 1 {
            title = "客服电话"
        }else if type == 2{
            title = "微信客服"
        }else if type == 4{
            
            title = "微信粉丝福利群"
            contact = "保存群二维码至相册"
        }
    }
    
    
}

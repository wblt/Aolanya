//
//  MMLExchangeModel.swift
//  Meimeila
//
//  Created by macos on 2017/12/29.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class MMLExchangeModel: NSObject {

    var id:String?
    var uid:String?
    var name:String?
    var phone:String?
    var prizename:String?
    var drawtime:String?
    var status:Int?
    var postage:String?
    var statusTitle:String = "未领取"
    
    init(from json:JSON) {
        
        id = json["id"].stringValue;
        uid = json["uid"].stringValue;
        name = json["name"].stringValue;
        phone = json["phone"].stringValue;
        prizename = json["prizename"].stringValue;
        drawtime = json["drawtime"].stringValue;
        status = json["status"].intValue;
        postage = json["postage"].string;
        
        if status == 1{
            statusTitle = "已领取"
        }
    }
    
}

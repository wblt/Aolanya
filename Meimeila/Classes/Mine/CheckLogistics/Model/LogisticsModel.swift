//
//  LogisticsModel.swift
//  Mythsbears
//
//  Created by macos on 2017/10/31.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class LogisticsModel{

    
//    "datetime": "2017-10-03 19:19:39",
//    "remark": "顺丰速运 已收取快件",
//    "zone": ""
    var datetime:String = "";
    var remark:String = "";
    var zone:String = "";
    
    init(from json:JSON) {
        datetime = json["datetime"].stringValue
        remark = json["remark"].stringValue
        zone = json["zone"].stringValue
    }
}

//
//  MMLBeansDetailModel.swift
//  Meimeila
//
//  Created by macos on 2017/12/12.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class MMLBeansDetailModel {

//    "id": "1",
//    "uid": "10088",
//    "beans": "100",
//    "isPay": "2",     //1是支出，2是获得
//    "remarks": "抽奖获得100颗",
//    "banlance": "99",
//    "addtime": "213246546"
    
    var id:String?
    var uid:String?
    var beans:String?
    var isPay:String?
    var remarks:String?
    var banlance:String?
    var addtime:String?
    
    init(from json:JSON) {
        
        id = json["id"].stringValue
        uid = json["uid"].stringValue
        beans = json["beans"].stringValue
        isPay = json["isPay"].stringValue
        remarks = json["remarks"].stringValue
        banlance = json["banlance"].stringValue
        addtime = json["addtime"].stringValue
    }
}

//
//  BeansModel.swift
//  Meimeila
//
//  Created by macos on 2017/12/12.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class BeansModel {
//    "id":20,
//    "uid":10088,
//    "beans":540,
//    "isUse":1,
    
    var id:String?
    var uid:String?
    var beans:String?
    var isUse:String?
    
    init(from json:JSON) {
        
        id = json["id"].stringValue
        uid = json["uid"].stringValue
        beans = json["beans"].stringValue
        isUse = json["isUse"].stringValue
    }
    
    
}

//
//  SmartmaskListModel.swift
//  Mythsbears
//
//  Created by macos on 2017/11/15.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class SmartmaskListModel{

//    "id": "1",
//    "uid": "10092",
//    "water": "40%",
//    "oily": "50%",
//    "detectiontime": "111"

    
    var id:String?
    var uid:String?
    var lastwater:Double = 0
    var lastoily:Double = 0
    var detectiontime:String?
    var water:Double = 0
    var oily:Double = 0
    
    init(from json:JSON) {
        
        id = json["id"].stringValue
        uid = json["uid"].stringValue
        water = json["water"].doubleValue
        oily = json["oily"].doubleValue
        detectiontime = json["detectiontime"].stringValue
   
        lastwater = json["lastwater"].doubleValue
        lastoily = json["lastoily"].doubleValue
        
    }
 
    
    
}

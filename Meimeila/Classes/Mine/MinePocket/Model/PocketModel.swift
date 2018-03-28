//
//  PocketModel.swift
//  Mythsbears
//
//  Created by macos on 2017/11/1.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class PocketModel{

    var beans:String?
    var isUse:String?
    var money:String?
    var moneyID:String?
    var uid:String?
    
    init(form json:JSON) {
        
        beans = json["beans"].stringValue;
        isUse = json["isUse"].stringValue;
        money = json["money"].stringValue;
        moneyID = json["moneyID"].stringValue;
        uid = json["uid"].stringValue;
    }
}

//
//  DDRequestModel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import SwiftyJSON

class DDRequestModel {
    
    var code: Int =  0
    var message: String = ""
    var data: Any!
    
    
    init(jsonData: JSON) {
        
        code = jsonData["code"].intValue
        message = jsonData["message"].stringValue
        data = jsonData["data"]
    }
}

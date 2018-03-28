//
//  DDErrorModel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation

class DDErrorModel {
    
    var status: Int = 0
    var message: String = ""
    
    
    init(status: Int,message: String) {
        self.status = status
        self.message = message
    }
}

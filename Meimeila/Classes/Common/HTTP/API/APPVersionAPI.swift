//
//  APPVersionAPI.swift
//  Mythsbears
//
//  Created by macos on 2017/11/16.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

fileprivate let appid = "1289607905"

enum APPVersionAPI {
    
    case appStoreLookup
    case appStoreUrl

}

extension APPVersionAPI{
    
    var path:String {
        
        switch self {
        case .appStoreLookup:
            return  "https://itunes.apple.com/lookup?id=\(appid)"
        case .appStoreUrl:
            return  "itms-apps://itunes.apple.com/app/id\(appid)"
        }
        
    }
    
}

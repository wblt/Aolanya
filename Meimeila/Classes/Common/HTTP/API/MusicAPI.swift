//
//  MusicAPI.swift
//  Meimeila
//
//  Created by macos on 2017/11/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum MusicAPI {

    case musicList(num:Int)
    case musicListen(keyword:String,page:Int,pagesize:Int)
}

extension MusicAPI:Request{
    var path: String {
        
        switch self {
        case .musicList(num: _):
            return API.musicList
        case .musicListen(keyword: _, page: _, pagesize: _):
            return API.musicListen
        }
    }
    
    
    var parameters: [String : Any]?{
        switch self {
        case .musicList(let num):
       
            var p = postParameters();
            p["num"] = "\(num)"
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: false);
        case .musicListen(let keyword,let page,let pagesize):
            
            var p = postParameters();
            p["page"] = "\(page)"
            p["pagesize"] = "\(pagesize)"
            p["keyword"] = "\(keyword)"
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: false);
        }
        
    }
}

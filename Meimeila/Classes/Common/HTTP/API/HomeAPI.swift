//
//  HomeAPI.swift
//  YSBRXSwift
//
//  Created by HJQ on 2017/6/12.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Alamofire

// 首页数据
enum HomeAPI {
    case homeData(numberPages: Int)

}

// MARK: - 遵守的协议要实现
extension HomeAPI: Request {
    var path: String {
        switch self {
        case .homeData(_):
            return API.homeData
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .homeData(_):
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {

        case .homeData(let numberPages):
            var params = postParameters()
            params["numberPages"] = numberPages
            return DDIntegrationOfTheParameter(params: params)
        }
    }
    
    var host: String {
        return API.baseServer
    }
    
    var isCheckNetStatus: Bool {
        return true
    }
    var isCheckRequestError: Bool {
        return true
    }
    
}

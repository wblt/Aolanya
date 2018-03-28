//
//  DDHTTPRequst.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import SwiftyJSON

class DDHTTPRequest {
    
    // 基本的网络请求
    class func request(r: Request, requestSuccess: @escaping RequestSucceed, requestError: @escaping RequestError, requestFailure: @escaping RequestFailure) {
        
        DispatchQueue.main.async {
             UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
       
        HTTPClient.sharedInstance.send(r, success: { (result) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            debugLog("result====>" + "\(result)")
            interceptResponse(r: r, response: result, requestSuccess: requestSuccess, requestError: requestError, requestFailure: requestFailure)
        }, failure: { (error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            debugLog("error====>" + "\(error)")
            requestFailure(error)
            if r.isCheckNetStatus {
                check(netWork: error)
            }
        }) { (response, errorModel) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            requestError(response, errorModel)
            debugLog("未知错误")
        }
        
    }
    
    
    // 图片上传网络请求
    class func upLoadImages(r: Request, requestSuccess: @escaping RequestSucceed, requestError: @escaping RequestError, requestFailure: @escaping RequestFailure) {
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        HTTPClient.sharedInstance.upload(r, success: { (result) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            debugLog("result====>" + "\(result)")
          interceptResponse(r: r, response: result, requestSuccess: requestSuccess, requestError: requestError, requestFailure: requestFailure)
            
        }, failure: { (error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
             requestFailure(error)
            if r.isCheckNetStatus {
                check(netWork: error)
            }
        }) { (response, errorModel) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            requestError(response, errorModel)
            debugLog("未知错误")
        }
    
    }

}

extension DDHTTPRequest {
    
    // 处理数据
    fileprivate class func interceptResponse(r: Request, response: [String: AnyObject], requestSuccess: @escaping RequestSucceed, requestError: @escaping RequestError, requestFailure: @escaping RequestFailure) {
        let object = DDRequestModel.init(jsonData: JSON.init(response))
        let status = object.code
        let msg = object.message
        //let data = object.data
        
        switch status {
        case 110: // 签名不正确
            BFunction.shared.hideLoadingMessage()
            //NotificationCenter.default.post(name: cNShouldLogin, object: nil)
            DDDeviceManager.shared.saveLoginStatue(isLogin: false)
            let m = DDErrorModel(status: 110, message: "登录凭证失效")
            requestError(response, m)
            break
        case 100: // 请求成功
            requestSuccess(response)
            break
            
        case 101: // 请登录
            DDDeviceManager.shared.saveLoginStatue(isLogin: false)
            let m = DDErrorModel(status: status, message: msg)
            requestError(response, m)
            break
            
        case 108: // 请求超时
            
            let m = DDErrorModel(status: status, message: msg)
            requestError(response, m)
            break
            
        default:
            let m = DDErrorModel(status: status, message: msg)
            
            /* if isCheckRequestError {
             BFunction.shared.showErrorMessage(m.message)
             }
             */
            requestError(response, m)
            break
        }
        
    }
}

extension DDHTTPRequest {
    /// 检查网络错误状态
    ///
    /// - Parameter error: Error
    class func check(netWork error: Error) {
        debugLog("错误码 ===》" + "\(error._code)" + "错误描述 ===》" + error.localizedDescription)
        
        switch error._code {
        case -1009: BFunction.shared.showErrorMessage("似乎网络断开了连接")
        case -1004: BFunction.shared.showErrorMessage("与服务器断开连接")
        case -999 : debugLog("服务器主动断开网络请求")
        case -1001: BFunction.shared.showErrorMessage("请求超时")
        case -1011: BFunction.shared.showErrorMessage("攻城狮正在抢修服务器...")
        default   : BFunction.shared.showErrorMessage("您的网络好像有点问题")
        }
    }
     func showNetWorkErrorMessage(_ message:String) {
        BFunction.shared.showMessage(message)
    }
     func showServerErrorMessage() {
        BFunction.shared.showMessage("服务器异常")
    }
}

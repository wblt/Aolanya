//
//  HTTPClient.swift
//  HTTPClientDemo
//
//  Created by HJQ on 2017/9/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import Alamofire

/// 请求成功
typealias RequestSucceed = (_ result: [String: AnyObject]) -> ()
/// 请求失败
typealias RequestFailure = (_ error: Error) -> ()
/// 请求错误回调
typealias RequestError      = (_ result: [String: AnyObject], _ errorObject: DDErrorModel) -> ()
/// 空数据回调
//typealias RequestEmptyData  = () -> ()

// MARK: - 面向协议编程
public protocol Request {
    // 接口
    var path: String { get }
    // 请求方式
    var method: HTTPMethod { get }
    // 请求参数
    var parameters: [String: Any]? { get }
    // 是否显示指示器
    var hud: Bool { get }
    // 自定义头部
    //var headers: [String: String] {get}
    // 服务器的基本地址
    var host: String { get }
    // 是否检查网络状态
    var isCheckNetStatus: Bool { get }
    // 是否检查请求错误
    var isCheckRequestError:Bool { get }
}

extension Request {
    
    var hud: Bool {
        return false
    }
    
    var method: HTTPMethod {
        return HTTPMethod.post
    }
    
    // 服务器的基本地址
    var host: String {
        return API.baseServer
    }
    // 是否检查网络状态
    var isCheckNetStatus: Bool {
        return true
    }
    // 是否检查请求错误
    var isCheckRequestError:Bool {
        return true
    }
    
    var parameters: [String: Any]? {
        return DDIntegrationOfTheParameter(params: postParameters())
    }
    
    /// 默认请求参数
    ///
    /// - Returns: [String: Any]
    func postParameters() -> [String: Any] {
        
        var parameters = [String: Any]()
        let timestamp = DDGetNowTimestamp()
        parameters["timestamp"] = "\(timestamp)"
        return parameters
    }
}

//protocol RequestClient {
//    // var host: String { get }
//     func send<T: Request>(_ r: T, success:@escaping RequestSucceed, failure:@escaping RequestFailure)
//     func upload<T: Request>(_ r: T, success:@escaping RequestSucceed, failure:@escaping RequestFailure)
//}

// MARK: - 网络请求相关
class HTTPClient {

    // 创建单例
    static var sharedInstance = HTTPClient()

    
    // 普通的网络请求
    func send(_ r: Request, success: @escaping RequestSucceed, failure: @escaping RequestFailure, requestError: @escaping RequestError) {
        if r.hud {}
        
        // 2.自定义头部
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        debugLog("请求链接:\(r.host + r.path)")
        debugLog("请求参数:\( r.parameters ?? [:] )")
		
		sessionManager.request(r.host + r.path, method: r.method, parameters: r.parameters,encoding:JSONEncoding.default,headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                debugLog("Progress: \(progress.fractionCompleted)")
            
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                switch response.result{
                case .success(_):
                    //debugLog(response.result.value)
                    if let value = response.result.value as? [String: AnyObject] {
                        success(value)
                        return
                    }
                    // 未知错误
                    let m = DDErrorModel(status: -11211, message: "未知的错误")
                    requestError([:], m)
                case .failure(let error):
                    failure(error)
                }
        }
    }


    // 图片上传
    func upload(_ r: Request, success: @escaping RequestSucceed, failure: @escaping RequestFailure, requestError: @escaping RequestError) {
        if r.hud {
            
        }
        // 2.自定义头部
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "content-type":"multipart/form-data"
        ]
        
        debugLog("请求链接:\(r.host + r.path)")
        debugLog("请求参数:\( r.parameters ?? [:] )")
        
        // 3.发送网络请求
        sessionManager.upload( multipartFormData: { multipartFormData in
            // 图片数据绑定
            for (key, value) in r.parameters! {
                if (value as AnyObject).isKind(of: UIImage.self) {
                    let fileName = key + ".jpg"
                    // 图片压缩可能导致图片变形，最好是按比例缩放
                    multipartFormData.append(UIImageJPEGRepresentation(value as! UIImage, 0.5)!, withName: key , fileName: fileName, mimeType: "image/jpeg")
                    
                }else {
                    assert(value is String)
                    let utf8Value = (value as AnyObject).data(using: String.Encoding.utf8.rawValue)!
                    multipartFormData.append(utf8Value, withName: key )
                }
            }
        },to: r.host + r.path, headers: headers, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                        return
                    }
                    // 未知错误
                    let m = DDErrorModel(status: -11211, message: "未知的错误")
                    requestError([:], m)
                }
            case .failure(let error):
                failure(error)
                break
            }
        })
    }
    
    // MARK: - lazy load
    private lazy var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        // 设置请求超时时间
        configuration.timeoutIntervalForRequest = 15
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
    
}



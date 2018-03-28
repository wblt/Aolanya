//
//  MSXVersionViewModel.swift
//  Mythsbears
//
//  Created by macos on 2017/11/16.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MSXVersionViewModel:NSObject{

    static let shared = MSXVersionViewModel.init();
    fileprivate override init(){}
    
    let bundleName = UIApplication.shared.appBundleName()
    let bundleDispalyName = UIApplication.shared.appBundleDispalyName()
    let bundleID = UIApplication.shared.appBundleID()
    let version = UIApplication.shared.appVersion();
    let buildVision = UIApplication.shared.appBuildVersion();

   

}


extension MSXVersionViewModel{
    

    func appStoreVersion() {
    
        versionRequest();
    }
    
    func versionRequest(){
        
        Alamofire.request(APPVersionAPI.appStoreLookup.path , method:.post).responseJSON {[weak self] (returnResult) in
            print("POST_Request --> post 请求 --> returnResult = \(returnResult)");
        
            let value = returnResult.value
            
            let json = JSON.init(value as Any);
            
            let arr = json["results"].arrayValue
            
            var appStoreVersion = "0.0.0";
            arr.forEach({ (json) in
               let version = json["version"].stringValue
                
                if !version.isEmpty{
                    
                    appStoreVersion = version
                }
            })
            
            if (self?.version)! < appStoreVersion {
                
                self?.showAlert();
                
                print(self?.version as Any,"<--->",appStoreVersion);

            }else{
            
                print(self?.version as Any,"<--->",appStoreVersion);
            
            }
            switch returnResult.result.isSuccess {
            case true:
                print("数据获取成功!")
            case false:
                print(returnResult.result.error ?? Error.self)
            }
            
        }
    }

    func showAlert() {
        
        let alter = UIAlertView.init(title: "版本更新", message: "有新的版本啦！", delegate: self, cancelButtonTitle: "更新", otherButtonTitles: "忽略");
        
            alter.show();
        
    }
    
}

extension MSXVersionViewModel:UIAlertViewDelegate{

    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        if buttonIndex == 0 {
            
            let urlString = APPVersionAPI.appStoreUrl.path
            if let url = URL(string: urlString) {
                //根据iOS系统版本，分别处理
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:],
                                              completionHandler: {
                                                (success) in
                    })
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}

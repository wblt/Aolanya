//
//  MMLServiceViewModel.swift
//  Meimeila
//
//  Created by macos on 2017/12/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class MMLServiceViewModel: NSObject {

    var titleDic = [["name1":"微信福利粉丝群","name2":"点击自动保存二维码"],
                    ["name1":"微信客服","name2":""],
                    ["name1":"电话客服","name2":""]];
    
    var modelArr = [MMLContactServiceModel]();
}

extension MMLServiceViewModel{
    
    ///网络请求
    func request(succeeds:@escaping ()->()) {
        
        let r = MMLContactServiceAPI.service
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            
            let json = JSON.init(responds);
            let data = json["data"].arrayValue;
            
            self?.modelArr.removeAll();
            
            data.forEach({ (jsons) in
                let model = MMLContactServiceModel.init(from: jsons);
                self?.modelArr.append(model);
            })
            
            succeeds()
        }, requestError: { (responds, errorModel) in
            
        }) { (error) in
            
        }
    }
    
    
    
    
    ///打电话
    func callPhone(tel:String) {
        
        UIApplication.shared.openURL(URL.init(string: "tel:\(tel)")!)
    }
    
    ///保存二维码到相册
    func saveImageToPhoneLibrary(codeString:String) {
        
        let image = UIImage.CN_creatQRImage(codeString: codeString, sizes: 200);
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil);
    }
    
    @objc func image(image:UIImage,didFinishSavingWithError error:Error?,contextInfo:AnyObject) {
        
        if error != nil {
            BFunction.shared.showErrorMessage("保存失败")
        } else {
            BFunction.shared.showErrorMessage("保存成功")
        }
    }
    
    ///文本复制
    func copyText(copyString:String) {
        let past = UIPasteboard.general;
        past.string = copyString;
        
        if let _ = past.string {
            print("拷贝成功");
        }else{
            print("拷贝失败");
        }
    }
}

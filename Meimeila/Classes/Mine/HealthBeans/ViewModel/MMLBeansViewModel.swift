//
//  MMLBeansViewModel.swift
//  Meimeila
//
//  Created by macos on 2017/12/11.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class MMLBeansViewModel {

   
    var selectState = [true,false,false];
    
    var cellDic = [["name":"微信","icon":"wenxin_ico"],
                   ["name":"支付宝","icon":"alipay_ico"],
                   ["name":"余额","icon":"icon_minePocket"]
                   ]
    
    var numberPages = 0;
    var tableView:UITableView?

}

extension MMLBeansViewModel {
    
    ///健康豆数量
    func beansCount(succeeds:@escaping (_ count:String)->()) {
        
        let r = HealthBeansAPI.beansCount;
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
          
            let json = JSON.init(responds);
            print(json);
            
            let data = json["data"].dictionaryValue;
            succeeds((data["beans"]?.stringValue)!);
            
        }, requestError: { (responds, errormodel) in
            BFunction.shared.showErrorMessage(errormodel.message)
        }) { (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription)

            
        }
        
    }
    
    ///健康豆明细
    func beansRecord() {
        
        let r = HealthBeansAPI.beanRecord(numberPages: numberPages);
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            
            let json = JSON.init(responds);
            print(json);
            
        }, requestError: { (responds, errormodel) in
            BFunction.shared.showErrorMessage(errormodel.message)
        }) { (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription)
            
            
        }
    }
    
    
    ///健康豆换钱
    func beansToMonayExchange(num:String,succeeds:@escaping ()->()) {
        
        let r = MMLBeansToMonayAPI.beanToMonayExchange(num: num);
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            
            let json = JSON.init(responds);
            print(json);
                    
            succeeds();
        }, requestError: { (responds, errorModel) in
            
            
        }) { (error) in
            
            
        }
        
    }
    
    
    // tableView停止刷新
    private func endRefresh(isNomore: Bool = false) {
        if numberPages == 0 {
            tableView?.mj_header.endRefreshing()
        }else {
            tableView?.mj_footer.endRefreshing()
            if isNomore {
                tableView?.mj_footer.endRefreshingWithNoMoreData()
            }
        }
    }
}

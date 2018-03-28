//
//  MMLDetailViewModel.swift
//  Meimeila
//
//  Created by macos on 2017/11/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class MMLDetailViewModel: NSObject {

    var tableView:UITableView?
    var numberPager = 0;
    var moderArr = [MMLDetailModel]()
    
    var beansArr = [MMLBeansDetailModel]()
}

extension MMLDetailViewModel{
    
    func requestData(succeeds:@escaping ()->()) {
        
        let r = MMLDetailAPI.detail(numberPages: numberPager);
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            let json = JSON.init(responds);
            print(json);
            
            if self.numberPager == 0{
                
                self.moderArr.removeAll();
            }
            
            let data = json["data"].arrayValue;
            data.forEach({ (item) in
                let model = MMLDetailModel.init(from: item);
                self.moderArr.append(model);
            })
            
            let isNoMore = self.moderArr.count > 0 ? false : true;
            self.endRefresh(isNomore: isNoMore);
            succeeds()
            
        }, requestError: { (responds, errorModel) in
            BFunction.shared.showErrorMessage(errorModel.message)
            self.endRefresh();
        }) { (error) in
            self.endRefresh();
            BFunction.shared.showErrorMessage(error.localizedDescription)

        }
    }
    
    ///健康豆记录
    func beansRecord(succeeds:@escaping ()->()) {
        
        let r = HealthBeansAPI.beanRecord(numberPages: numberPager);
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            
            let json = JSON.init(responds);
            print(json);
            
            if self.numberPager == 0{
                
                self.beansArr.removeAll();
            }
            
            let data = json["data"].arrayValue;
            data.forEach({ (item) in
                let model = MMLBeansDetailModel.init(from: item);
                self.beansArr.append(model);
            })
            
            let isNoMore = self.beansArr.count > 0 ? false : true;
            self.endRefresh(isNomore: isNoMore);
            succeeds()
            
        }, requestError: { (responds, errormodel) in
            let json = JSON.init(responds);
            print(json);
            
            
            BFunction.shared.showErrorMessage(json["message"].stringValue)
        }) { (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription)
            
            
        }
    }
    
    // tableView停止刷新
    private func endRefresh(isNomore: Bool = false) {
        if numberPager == 0 {
            tableView?.mj_header.endRefreshing()
        }else {
            tableView?.mj_footer.endRefreshing()
            if isNomore {
                tableView?.mj_footer.endRefreshingWithNoMoreData()
            }
        }
    }
    
}

//
//  MSXMessageVM.swift
//  Mythsbears
//
//  Created by macos on 2017/10/13.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class MSXMessageVM {

    var tableView:UITableView?
    var numberPage = 0;
    var userMessageArr = [MineMessageModel]();
    //用户消息
    func userMessage( succeeds:@escaping () -> Void) {
        let r = MessageAPI.customMessag
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            let json = JSON.init(responds);
            print(json);
            if self?.numberPage == 0{
                self?.userMessageArr.removeAll();
            }
            
            let jsonArr = json["data"].arrayValue;
            
            jsonArr.forEach({ (jsonModel) in
                
                let model = MineMessageModel.init(from: jsonModel);
                self?.userMessageArr.append(model);
            })
            
            self?.endRefresh(isNomore: self?.userMessageArr.count ?? 0 > 0 ?false:true);
            
            succeeds()
            
        }, requestError: { (responds, ErrorModel) in
            
            self.endRefresh();
            
        }) { (error) in
            
            self.endRefresh();
        }
    }
    
    // tableView停止刷新
    private func endRefresh(isNomore: Bool = false) {
        if numberPage == 0 {
            tableView?.mj_header.endRefreshing()
        }else {
            tableView?.mj_footer.endRefreshing()
            if isNomore {
                tableView?.mj_footer.endRefreshingWithNoMoreData()
            }
        }
    }
}

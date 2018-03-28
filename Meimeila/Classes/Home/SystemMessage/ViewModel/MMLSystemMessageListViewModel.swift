//
//  MMLSystemMessageListViewModel.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class MMLSystemMessageListViewModel: NSObject {

    weak var tableView: UITableView!
    var numberPages: Int = 0
    
    var datas: [MMLSystemMessageListData] =  [MMLSystemMessageListData]()
    
    func getSystemMessageList(successBlock: @escaping () -> ()) {
        
        let request = SystemNoticeAPI.getSystemMessageList(numberPages: numberPages)
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            
            let model = MMLSystemMessageList.init(fromJson: JSON.init(result))
            if self.numberPages == 0 {
                self.datas = model.data
            }else {
                model.data.forEach({ (data) in
                    self.datas.append(data)
                })
            }
            let isNomore = model.data.count > 0 ? false : true
            self.endRefresh(isNomore: isNomore)
            successBlock()
            
        }, requestError: { (_, errorModel) in
            self.endRefresh(isNomore: true)
            
        }) { (error) in
            self.endRefresh(isNomore: true)
            
        }
    }
    
    
    // tableView停止刷新
    private func endRefresh(isNomore: Bool = false) {
        if numberPages == 0 {
            tableView.mj_header.endRefreshing()
        }else {
            tableView.mj_footer.endRefreshing()
            if isNomore {
                tableView.mj_footer.endRefreshingWithNoMoreData()
            }
        }
    }
}

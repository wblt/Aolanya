//
//  DDHomeDataViewModel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/7.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class DDHomeDataViewModel {
    
    var tableView: UITableView!
    var numberPages: Int = 0
    var productListDatas: [MMLHomeDataShoping] =  [MMLHomeDataShoping]()
    var homeDataModel: MMLHomeDataModel?
    
    // 获取首页的数据
    func getHomeData(successBlock:@escaping () -> ()) {
        DDHTTPRequest.request(r: HomeAPI.homeData(numberPages: numberPages), requestSuccess: { (result) in
            
            print(result);
            
            let model = MMLHomeDataModel.init(fromJson: JSON.init(result))
            self.homeDataModel = model
            
            if self.numberPages == 0 {
                self.productListDatas = model.shoping
            }else {
                model.shoping.forEach({ (data) in
                    self.productListDatas.append(data)
                })
            }
            let isNomore = model.shoping.count > 0 ? false : true
            self.endRefresh(isNomore: isNomore)
            successBlock()
        }, requestError: { (result, errorModel) in
            
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

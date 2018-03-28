//
//  MMLMyCollectionViewModel.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class MMLMyCollectionViewModel {

    var numberPages: Int = 0
    var tableView: UITableView!
    var myCollectionList: [MMLMyCollectionListData] =  [MMLMyCollectionListData]()
    
    func  getMyCollectionList(successBlock: @escaping () -> ()) {
        let request = ShopCollectAPI.shopList(numberPages: numberPages)
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            let model = MMLMyCollectionListModel.init(fromJson: JSON.init(result))
            if self.numberPages == 0 {
                self.myCollectionList = model.data
            }else {
                model.data.forEach({ (data) in
                    self.myCollectionList.append(data)
                })
            }
            let isNomore = model.data.count > 0 ? false : true
            self.endRefresh(isNomore: isNomore)
            successBlock()
        }, requestError: { (result, errorModel) in
            BFunction.shared.showToastMessge(errorModel.message)
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

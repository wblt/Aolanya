//
//  DDProductListViewModel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/10.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class DDProductListViewModel {

    var productListDatas: [DDProductListShopping] =  [DDProductListShopping]()
    var numberPages: Int = 0
    var tableView: UITableView!
    
    func getProductList(keyword: String, type: Int, successBlock: @escaping () -> ()) {
        DDHTTPRequest.request(r: ProductListAPI.productList(keyword: keyword, numberPages: numberPages, type: type), requestSuccess: { (result) in
            let model = DDProductListModel.init(fromJson: JSON.init(result))
            if self.numberPages == 0 {
                self.productListDatas = model.shopping
            }else {
                model.shopping.forEach({ (data) in
                    self.productListDatas.append(data)
                })
            }
            let isNomore = model.shopping.count > 0 ? false : true
            self.endRefresh(isNomore: isNomore)
            successBlock()
            
        }, requestError: { (result, error) in
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

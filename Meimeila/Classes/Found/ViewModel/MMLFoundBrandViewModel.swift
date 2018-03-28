//
//  MMLFoundBrandViewModel.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/14.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class MMLFoundBrandViewModel {
    
    var numberPages: Int = 0
    weak var tableView: UITableView!
    var foundBrandModel: MMLFoundBrandModel?
    var brandList: [MMLFoundBrandFoundBrand] = [MMLFoundBrandFoundBrand]()
    
    // 获取发现页数据
    func getFoundBrandList(successBlock: @escaping ()->()) {
        let request = FoundBrandAPI.getFoundBrandList(numberPages: numberPages)
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            let model = MMLFoundBrandModel.init(fromJson: JSON.init(result))
            self.foundBrandModel = model
            if self.numberPages == 0 {
                self.brandList = model.foundBrand
            }else {
                model.foundBrand.forEach({ (data) in
                    self.brandList.append(data)
                })
            }
            let isNomore = model.foundBrand.count > 0 ? false : true
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
        tableView.reloadData()
    }

}

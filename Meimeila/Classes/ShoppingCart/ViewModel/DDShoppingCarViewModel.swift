//
//  DDShoppingCarViewModel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class DDShoppingCarViewModel {

    var numberPages: Int = 0
    var tableView: UITableView!
    // 购物车商品列表
    var shoppingCarListDatas: [DDShoppingCarListData] = [DDShoppingCarListData]()
    
    // 获取购物车列表
    func getshoppingCarList(successBlock: @escaping () -> ()) {
        DDHTTPRequest.request(r: ShoppingcarAPI.getShoppingCarList(numberPages: numberPages), requestSuccess: { (result) in
            
            print("--->",JSON.init(result));
            
            let model = DDShoppingCarListModel.init(fromJson: JSON.init(result))
            if self.numberPages == 0 {
                self.shoppingCarListDatas = model.data
            }else {
                model.data.forEach({ (data) in
                    self.shoppingCarListDatas.append(data)
                })
            }
            let isNomore = model.data.count > 0 ? false : true
            self.endRefresh(isNomore: isNomore)
            successBlock()
            
        }, requestError: { (result, errorModel) in
            if self.numberPages == 0 {
                self.shoppingCarListDatas.removeAll()
                successBlock()
            }
            BFunction.shared.showToastMessge(errorModel.message)
            self.endRefresh(isNomore: true)
        }) { (error) in
            self.endRefresh(isNomore: true)
        }
    }
    
    // 商品数量增加
    func productIncrease(shoppingID: String, number: String, successBlock: @escaping () -> ()) {
        DDHTTPRequest.request(r: ShoppingcarAPI.productIncrease(shoppingID: shoppingID, number: number), requestSuccess: { (result) in
            successBlock()
        }, requestError: { (result, errorModel) in
           BFunction.shared.showToastMessge(errorModel.message)
        }) { (error) in
            
        }
    }
    
    // 商品减少
    func productDeincrease(shoppingID: String, number: String, successBlock: @escaping () -> ()) {
        DDHTTPRequest.request(r: ShoppingcarAPI.productDeIncrease(shoppingID: shoppingID, number: number), requestSuccess: { (result) in
            successBlock()
        }, requestError: { (result, errorModel) in
            BFunction.shared.showToastMessge(errorModel.message)
        }) { (error) in
            
        }
    }
    
    // 商品删除
    func productDeleted(shoppingID: String, successBlock:  @escaping () -> ()) {
        DDHTTPRequest.request(r: ShoppingcarAPI.productDeleted(shoppingID: shoppingID), requestSuccess: { (result) in
            BFunction.shared.showToastMessge(JSON.init(result)["message"].stringValue)
            successBlock()
        }, requestError: { (result, errorModel) in
            BFunction.shared.showToastMessge(errorModel.message)
        }) { (error) in
            
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

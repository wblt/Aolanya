//
//  DDProductDetailsViewModel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import SwiftyJSON

class DDProductDetailsViewModel {
    
    var productDetailsModel: DDProductDetailsModel?
    var addCarModel: DDProductDetailsAddCarModel?
    weak var tableView: UITableView!
    var numberPages: Int = 0
    
    // 商品是否已经收藏
    var iscollect: Int = 0
    var shoppingCarNumber: Int = 0
    
    // 评价列表
    var evaluetionListDatas: [MMLProductDetailsEvaluateData] = [MMLProductDetailsEvaluateData]()
    
    
    // 获取商品详情
    func getProductDetails(shoppingID: String, successBlock: @escaping () -> (), failBlock: @escaping () -> ()) {
        DDHTTPRequest.request(r: ProductDetailsAPI.productDetails(shopingID: shoppingID), requestSuccess: { (result) in
            self.productDetailsModel = DDProductDetailsModel.init(fromJson: JSON.init(result))
            successBlock()
        }, requestError: { (result, errorModel) in
            failBlock()
        }) { (error) in
            failBlock()
        }
    }
    
    // 收藏商品
    func addProductCollection(shoppingID: String, successBlock: @escaping () -> ()) {
        DDHTTPRequest.request(r: ProductDetailsAPI.productCollection(shopingID: shoppingID), requestSuccess: { (result) in
            
            successBlock()
            
        }, requestError: { (result, errorModel) in
            BFunction.shared.showToastMessge(errorModel.message)
            
        }) { (error) in
            
        }
    }
    
    // 取消商品收藏
    func cancelProductCollection(shoppingID: String, successBlock: @escaping () -> ()) {
        DDHTTPRequest.request(r: ProductDetailsAPI.cancelProductCollection(shopingID: shoppingID), requestSuccess: { (result) in

             successBlock()
        }, requestError: { (result, errorModel) in
            BFunction.shared.showToastMessge(errorModel.message)
        }) { (error) in
            
        }
    }
    
    // 添加到购物车
    func productIncrease(shoppingID: String, number: String, successBlock: @escaping () -> ()) {
        DDHTTPRequest.request(r: ProductDetailsAPI.addProductToCar(shoppingID: shoppingID, shoppingNumber: number), requestSuccess: { (result) in
            self.addCarModel = DDProductDetailsAddCarModel.init(fromJson:JSON.init(result))
            if let _ = self.addCarModel {
                BFunction.shared.showMessage(self.addCarModel!.message)
            }
            successBlock()
        }, requestError: { (result, errorModel) in
            BFunction.shared.showMessage(errorModel.message)
        }) { (error) in
            
        }
    }
    
    // 商品评价点赞
    func addShopFabulous(shoppingID: String, evaluateID: String, successBlock: @escaping ()->()) {
        let request = ProductDetailsAPI.addShopFabulous(shoppingID: shoppingID, evaluateID: evaluateID)
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            let jsonData = JSON.init(result)
            let message = jsonData["message"].stringValue
            BFunction.shared.showMessage(message)
            successBlock()
        }, requestError: { (result, errorModel) in
            BFunction.shared.showMessage(errorModel.message)
        }) { (error) in
            
        }
    }
    
    // 商品评价取消点赞
    func delShopFabulous(shoppingID: String, evaluateID: String, successBlock: @escaping ()->()) {
        let request = ProductDetailsAPI.delShopFabulous(shoppingID: shoppingID, evaluateID: evaluateID)
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            let jsonData = JSON.init(result)
            let message = jsonData["message"].stringValue
            BFunction.shared.showMessage(message)
            successBlock()
        }, requestError: { (result, errorModel) in
            BFunction.shared.showMessage(errorModel.message)
        }) { (error) in
            
        }
    }
    
    // 查询商品是否已经收藏过了
    func queryGoodIsCollection(shoppingID: String, successBlock: @escaping ()->(), failureBlock: @escaping (_ status: Int)->()) {
        DDHTTPRequest.request(r: ProductDetailsAPI.queryIsCollection(shopingID: shoppingID), requestSuccess: { (result) in
            self.iscollect = JSON.init(result)["iscollect"].intValue
            self.shoppingCarNumber = JSON.init(result)["shoppingCarNumber"].intValue
            successBlock()
        }, requestError: { (result, errorModel) in
            failureBlock(errorModel.status)
        }) { (error) in
            
        }
    }
    
    // 获取商品评价列表
    func getEvalutionList(shoppingID: String, successBlock: @escaping ()->()) {
        let request = ProductDetailsAPI.getEvalutionList(shopingID: shoppingID, numberPages: numberPages)
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            let model = MMLEvaluateListModel.init(fromJson: JSON.init(result))
            if self.numberPages == 0 {
                self.evaluetionListDatas = model.evaluateData
            }else {
                model.evaluateData.forEach({ (data) in
                    self.evaluetionListDatas.append(data)
                })
            }
            let isNomore = model.evaluateData.count > 0 ? false : true
            self.endRefresh(isNomore: isNomore)
            successBlock()
        }, requestError: { (result, errorModel) in
            self.endRefresh(isNomore: true)
            BFunction.shared.showMessage(errorModel.message)
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

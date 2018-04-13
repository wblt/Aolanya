//
//  DDHomeDataViewModel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/7.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class DDHomeDataViewModel {
    
    var tableView: UITableView!
    var numberPages: Int = 0
    var productListDatas: [MMLHomeDataShoping] =  [MMLHomeDataShoping]()
    var homeDataModel: MMLHomeDataModel?
    
    var imgurl :String!
    var imglink :String!
    var type :String!   // 升级类型,0=不需要升级，1=可选升级，2=强制升级
    var downurl :String!  //下载地址
    
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
            
			
        }) { (error) in
            
        }
    }
    
    //获取广告 以及更新信息
    func requestSplah(successBlock:@escaping () -> Void) {
        let url =   API.baseServer + API.splashData
		
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            let jsonRequest = JSON.init(response.result.value as![String:Any]);
            self.imgurl = jsonRequest["splash"]["imgurl"].stringValue
            self.imglink = jsonRequest["splash"]["imgurl"].stringValue
            self.imglink = jsonRequest["upgrade"]["type"].stringValue
            self.imglink = jsonRequest["upgrade"]["downurl"].stringValue
            successBlock()
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

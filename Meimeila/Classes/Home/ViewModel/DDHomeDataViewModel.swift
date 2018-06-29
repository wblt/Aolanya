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
    
    //获取广告 以及
    func requestSplah(successBlock:@escaping () -> Void) {
        let url =   API.baseServer + API.splashData
		var p = [String:Any]()
		p["osversion"] = "android7.0"
		p["sign"] = "2CED2E5DB0BDF8EA444A369BF019EF58"
		p["longitude"] = "112.984986"
		p["package"] = "com.welcare.aolaiya"
		p["version"] = "9"
		p["latitude"] = "28.175034"
		p["timestamp"] = "1524122646"
		p["ostype"] = "M5 Note"
		p["manufactory"] = "Meizu"
		p["maptype"] = "2"
		p["devicesid"] = "862841036387482"
		/*
		"osversion": "android7.0",
		"sign": "2CED2E5DB0BDF8EA444A369BF019EF58",
		"longitude": "112.984986",
		"package": "com.welcare.aolaiya",
		"version": "9",
		"latitude": "28.175034",
		"timestamp": "1524122646",
		"ostype": "M5 Note",
		"manufactory": "Meizu",
		"maptype": "2",
		"devicesid": "862841036387482"
		*/
//		let sysVersion = UIDevice.current.systemVersion
//		p["osversion"] = sysVersion
//		p["sign"] = "2CED2E5DB0BDF8EA444A369BF019EF58"
//		p["longitude"] = "112.984986"
//		p["package"] = "com.welcare.aolaiya"
//		p["version"] = "9"
//		p["latitude"] = "28.175034"
//		p["timestamp"] = "1524122646"
//		let deviceModel = UIDevice.current.model
//		p["ostype"] = deviceModel
//		let sysName = UIDevice.current.systemName
//		p["manufactory"] = sysName
//		p["maptype"] = "2"
//		let deviceUUID = UIDevice.current.identifierForVendor?.uuidString //identifierForVendor.UUIDString
//		p["devicesid"] = deviceUUID
		
        Alamofire.request(url, method: .post, parameters: p, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
			print(response);
			if response.result.value != nil{
				let jsonRequest = JSON.init(response.result.value as![String:Any]);
				self.imgurl = jsonRequest["splash"]["imgurl"].stringValue ?? ""
				self.imglink = jsonRequest["splash"]["imgurl"].stringValue ?? ""
				self.imglink = jsonRequest["upgrade"]["type"].stringValue ?? ""
				self.imglink = jsonRequest["upgrade"]["downurl"].stringValue ?? ""
				successBlock()
			}
			
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

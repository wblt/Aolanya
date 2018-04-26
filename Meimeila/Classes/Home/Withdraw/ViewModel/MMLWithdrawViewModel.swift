//
//  MMLWithdrawViewModel.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class MMLWithdrawViewModel {
    
    var tableView: UITableView!
    var recordModel: MMLWithdrawRecordModel?
    
    // 获取提现记录
    func getWithdrawRecord(successBlock: @escaping ()->()) {
        let request = WithdrawAPI.withdrawRecord()
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            self.recordModel = MMLWithdrawRecordModel.init(fromJson: JSON.init(result))
            self.tableView.mj_header.endRefreshing()
            successBlock()
        }, requestError: { (result, error) in
            self.tableView.mj_header.endRefreshing()
            BFunction.shared.showToastMessge(error.message)
        }) { (error) in
            self.tableView.mj_header.endRefreshing()
        }
    }
    
    // 提现
	func withdraw(type: Int, money: Double, alipay: String, realName: String, payImg:UIImage,successBlock: @escaping ()->()) {
		let r = WithdrawAPI.withdraw(type: type, money: money, alipay: alipay, realName: realName ,payImg: payImg)
		
		DDHTTPRequest.upLoadImages(r: r, requestSuccess: { (responds) in
			
			let jsonRequest = JSON.init(responds);
			BFunction.shared.showSuccessMessage(jsonRequest["message"].stringValue);
			
			successBlock();
			
		}, requestError: { (responds, ErrorModel) in
			
			let jsonRequest = JSON.init(responds);
			let code = jsonRequest["code"].intValue
			var message:String?
			switch code {
			case 101:
				message = "请登录"
			case 102:
				message = "上传出错"
			case 103:
				message = "图片格式不正确"
			case 108:
				message = "请求超时"
			case 110:
				message = "签名不正确"
			case 111:
				message = " 未知错误"
			default:
				message = " Error"
			}
			
			 //BFunction.shared.showErrorMessage(message!);
			 BFunction.shared.showToastMessge(jsonRequest["message"].stringValue)
		}) { (error) in
			
		}
		
//		DDHTTPRequest.request(r: request, requestSuccess: { (result) in
//            let josnData = JSON.init(result)
//            let message = josnData["message"].string
//            BFunction.shared.showToastMessge(message)
//            successBlock()
//        }, requestError: { (result, error) in
//            BFunction.shared.showToastMessge(error.message)
//        }) { (error) in
//
//        }
		
    }
}

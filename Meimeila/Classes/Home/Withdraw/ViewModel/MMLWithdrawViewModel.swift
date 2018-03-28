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
    func withdraw(type: Int, money: Double, alipay: String, realName: String, successBlock: @escaping ()->()) {
        let request = WithdrawAPI.withdraw(type: type, money: money, alipay: alipay, realName: realName)
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            let josnData = JSON.init(result)
            let message = josnData["message"].string
            BFunction.shared.showToastMessge(message)
            successBlock()
        }, requestError: { (result, error) in
            BFunction.shared.showToastMessge(error.message)
        }) { (error) in
            
        }
    
    }
}

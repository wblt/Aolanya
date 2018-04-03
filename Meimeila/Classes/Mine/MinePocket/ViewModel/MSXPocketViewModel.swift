//
//  MSXPocketViewModel.swift
//  Mythsbears
//
//  Created by macos on 2017/11/1.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class MSXPocketViewModel{

    var moneyModel:PocketModel?
    
    var beansModel:BeansModel?
    
    var tableView:UITableView?
    var rechargeMoney:String = "0.00"
    
    var WechatPayModel:DDWechatPayModel!
    var aliPayModel: MMLSettlementAlipayModel!

    ///钱包余额
    func  getMoneyBalance(succeed:@escaping ()->()) {
        
        let r = PocketMonayAPI.moneyBalance
        
        DDHTTPRequest.requestWithJsonCoding(r: r, requestSuccess: { [weak self](responds) in
            
            let json = JSON.init(responds);
            let model = PocketModel.init(form: json["data"]);
            self?.moneyModel = model;
            self?.stopMJRefresh();
            
            succeed();
            
        }, requestError: {[weak self] (responds, errorModel) in
            self?.stopMJRefresh();

        }) {[weak self] (error) in
            self?.stopMJRefresh();

            
        }
        
    }
    
    
    ///健康豆数量
    func beansCount(succeed:@escaping ()->()) {
        
        let r = HealthBeansAPI.beansCount;
        
        DDHTTPRequest.request(r: r, requestSuccess: { [weak self](responds) in
            
            let json = JSON.init(responds);
            print(json);
            
            self?.beansModel = BeansModel.init(from: json["data"]);
            
            succeed();
            
        }, requestError: { (responds, errormodel) in
            BFunction.shared.showErrorMessage(errormodel.message)
        }) { (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription)
            
            
        }
        
    }
    
    
    ///钱包充值_支付宝
    func  reChargeMoneyWith_alipay(price:String ,orderID:String?,type:Int,invoice:String?,succeeds:@escaping ()->()) {
        
        let r = PocketMonayAPI.moneyRecharge_aliPay(orderID: orderID, orderPrice: price, type: type,invoice: invoice)
        
        DDHTTPRequest.request(r: r, requestSuccess: { [weak self](responds) in
            
            let json = JSON.init(responds);
            
            print(json)
            
            self?.aliPayModel = MMLSettlementAlipayModel.init(fromJson: json);
            
            self?.stopMJRefresh();
            
            BFunction.shared.showMessage(json["message"].stringValue);
            
            succeeds();
            
            }, requestError: {[weak self] (responds, errorModel) in
                self?.stopMJRefresh();
                
        }) {[weak self] (error) in
            self?.stopMJRefresh();
            
            
        }
        
    }
    
    
    ///钱包充值_微信
    func  reChargeMoneyWith_weChatPay(price:String ,orderID:String?,type:Int,invoice:String?,succeeds:@escaping ()->()) {
        
        let r = PocketMonayAPI.moneyRecharge_weChatPay(orderID: orderID, orderPrice: price, type: type,invoice: invoice)
        
        DDHTTPRequest.request(r: r, requestSuccess: { [weak self](responds) in
            
            let json = JSON.init(responds);
            
            
            self?.WechatPayModel = DDWechatPayModel.init(fromJson: json["getWechaPay"]);
            
            self?.stopMJRefresh();
            
            BFunction.shared.showMessage(json["message"].stringValue);
            succeeds();
            }, requestError: {[weak self] (responds, errorModel) in
                self?.stopMJRefresh();
                
        }) {[weak self] (error) in
            self?.stopMJRefresh();
            
            
        }
        
    }
    
    
    func stopMJRefresh() {
        
        if let _ = tableView?.mj_header {
            tableView?.mj_header.endRefreshing();

        }
        

    }
    
}

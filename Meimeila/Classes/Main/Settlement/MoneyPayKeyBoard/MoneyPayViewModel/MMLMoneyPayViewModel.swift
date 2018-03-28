//
//  MMLMoneyPayViewModel.swift
//  Meimeila
//
//  Created by macos on 2017/12/8.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class MMLMoneyPayViewModel{

    static var shared = MMLMoneyPayViewModel.init();
    fileprivate init(){}
    
    var numberPages:Int = 0;
    var tableView:UITableView?
    
}

extension MMLMoneyPayViewModel{
    
    ///余额订单支付
    
    func moneyPayOrder(payment_pwd:String,orderID:String?,orders:String,orderType:String = "1",adressID:String,invoice:String?,succeeds:@escaping ()->(),fails:@escaping ()->())  {
        
        let r = MoneyPayAPI.moneyPay_OrderAPI(payment_pwd: payment_pwd, orderID: orderID, orders: orders, orderType: orderType, adressID: adressID,invoice: invoice)
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            
            let json = JSON.init(responds);
            
            debugLog(json)
            
            BFunction.shared.showMessage(json["message"].stringValue)
            succeeds()
        }, requestError: {[weak self] (responds, errorModel) in
            
            let json = JSON.init(responds);
            
            debugLog(json)
            
            BFunction.shared.showErrorMessage(errorModel.message);
            fails()
        }) {[weak self] (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription);
            fails()
        }
        
        
    }
    
    
    ///余额充值记录
    func moneyPayRecord(numberPages:Int,succeeds:@escaping ()->(),fails:@escaping ()->()) {
        let r = MoneyPayAPI.moneyPay_RecordAPI(numberPages: numberPages)
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            
            let json = JSON.init(responds);
            
            debugLog(json)
            succeeds()
            }, requestError: {[weak self] (responds, errorModel) in
                BFunction.shared.showErrorMessage(errorModel.message);
                fails()
        }) {[weak self] (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription);
            fails()
        }
    }
    
    ///健康豆充值
    func moneyPayBeanRecharge(payment_pwd:String,orderPrice:String,orderType:String = "2",succeeds:@escaping ()->(),fails:@escaping ()->()) {
        let r = MoneyPayAPI.moneyPay_BeanAPI(payment_pwd: payment_pwd, orderPrice: orderPrice, orderType: orderType,invoice: nil)
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            
            let json = JSON.init(responds);
            
            debugLog(json)
            succeeds()
            }, requestError: {[weak self] (responds, errorModel) in
                BFunction.shared.showErrorMessage(errorModel.message);
                fails()
        }) {[weak self] (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription);
            fails()
        }
    }
    
    ///绑定手机号
    func moneyPayBindPhone(code:String,type:String = "1",phone:String,succeeds:@escaping ()->(),fails:@escaping ()->()) {
        
        let r = MoneyPayAPI.moneyPay_BindPhone(code: code, type: type, phone: phone)
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            
            let json = JSON.init(responds);
            
            debugLog(json)
            BFunction.shared.showMessage("succeeds")
            succeeds()
            }, requestError: {[weak self] (responds, errorModel) in
                BFunction.shared.showErrorMessage(errorModel.message);
                fails()
        }) {[weak self] (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription);
            fails()
        }
    }
    
    ///设置或修改支付密码
    func moneyPaySetPwd(payment_pwd:String,code:String,succeeds:@escaping ()->(),fails:@escaping ()->()) {
       
        let r = MoneyPayAPI.moneyPay_SetPwdAPI(payment_pwd: payment_pwd,code: code)
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            
            let json = JSON.init(responds);
            
            debugLog(json)
            
            BFunction.shared.showMessage("succeeds")
            succeeds()
            }, requestError: {[weak self] (responds, errorModel) in
                BFunction.shared.showErrorMessage(errorModel.message);
                fails()
        }) {[weak self] (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription);
            fails()
        }
    }
    
    
    ///获取验证码3
    func moneyPayGetSMS(phone:String,type:Int = 3 ,succeeds:@escaping ( _ isSucceeds:Bool) -> Void){
        
        let r = LoginAPI.getSmsCode(phone: phone, type: type);
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            
            let json = JSON.init(responds);
            
            debugLog(json)
            
            succeeds(true);
            
        }, requestError: { (responds, ErrorModel) in
            
            BFunction.shared.showErrorMessage(ErrorModel.message);
            
        }) { (Error) in
            
        }
    }
    
    
    // tableView停止刷新
    private func endRefresh(isNomore: Bool = false) {
        if numberPages == 0 {
            tableView?.mj_header.endRefreshing()
        }else {
            tableView?.mj_footer.endRefreshing()
            if isNomore {
                tableView?.mj_footer.endRefreshingWithNoMoreData()
            }
        }
    }
    
}

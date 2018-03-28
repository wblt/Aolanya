//
//  MMLLuckDrawRecordViewModel.swift
//  Meimeila
//
//  Created by macos on 2017/12/26.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class MMLLuckDrawRecordViewModel {

    var tableView:UITableView?
    var numberPages:Int = 0;
    var modelArr = [MMLLuckDrawModel]()
    var exchangeModelArr = [MMLExchangeModel]()
}

extension MMLLuckDrawRecordViewModel{
    
    ///获奖纪录
    func getLuckDrawRecord(succeeds:@escaping ()->()) {
        
        let r = MMLLuckDrawRecordAPI.luckDrawRecord(numberPages: numberPages);
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            
            let json = JSON.init(responds);
            print(json);
            
            if self?.numberPages == 0{
             
                self?.modelArr.removeAll();
            }
            
            let data = json["data"].arrayValue;
            
            data.forEach({ (json) in
                
                let model = MMLLuckDrawModel.init(from: json);
                self?.modelArr.append(model);
            })
            
            let isNomore = self?.modelArr.count > 0 ? false : true;
            self?.endRefresh(isNomore: isNomore)
            
            succeeds()
            
        }, requestError: { (responds, errorModel) in
            self.endRefresh();
            
        }) { (error) in
            self.endRefresh();
        }
        
        
    }
    
    ///兑换记录
    func exChangeLuckRecord(succeeds:@escaping ()->()) {
        
        let r = MMLLuckDrawRecordAPI.exchangeGiftRecord(numberPages: numberPages);
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            
            let json = JSON.init(responds);
            print(json);
            
            if self?.numberPages == 0{
                
                self?.exchangeModelArr.removeAll();
            }
            
            let data = json["data"].arrayValue;
            
            data.forEach({ (json) in
                
                let model = MMLExchangeModel.init(from: json);
                self?.exchangeModelArr.append(model);
            })
            
            let isNomore = self?.exchangeModelArr.count > 0 ? false : true;
            self?.endRefresh(isNomore: isNomore)
            
            succeeds()
            
            }, requestError: { (responds, errorModel) in
                self.endRefresh();
                
        }) { (error) in
            self.endRefresh();
        }
        
        
    }
    
    ///兑换奖品
    
    func exChangeGift(payment_pwd:String,consignee: String, addresseePhone: String, localArea: String, detailedAddress: String, postcode: String?, postage:String ,id: String,succeeds:@escaping ()->(),fales:@escaping ()->()) {
        
        let r = MMLLuckDrawRecordAPI.exchangeGift(payment_pwd:payment_pwd,consignee: consignee, addresseePhone: addresseePhone, localArea: localArea, detailedAddress: detailedAddress, postcode: postcode, postage: postage, id: id)
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            
            let json = JSON.init(responds);
            print(json);
            
            succeeds()
            
            }, requestError: { (responds, errorModel) in
                fales();
        }) { (error) in
            fales();
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

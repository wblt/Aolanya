//
//  MSXAddressVM.swift
//  Mythsbears
//
//  Created by macos on 2017/10/13.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class MSXAddressVM{

    var tableView:UITableView?
    var numberPage = 0;
    var addreaaArr = [AddressModel]()
    var defaultAddressModel:AddressModel?
    
    //收货地址列表
    func addressList(_ succeeds:@escaping () -> Void) {
        
        let r = AddressAPI.addressList(numberPages: numberPage);
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            let json = JSON.init(responds);
            print(json);
            
            if self.numberPage == 0 {
                self.addreaaArr.removeAll()
            }
            
            let jsonArr = json["data"].arrayValue
            
            for item in jsonArr {
                let model = AddressModel.init(fromJson: item);
                self.addreaaArr.append(model)
            }
            
            
            let isNomore = self.addreaaArr.count > 0 ? false : true
            self.endRefresh(isNomore: isNomore)
            
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            succeeds()
        }, requestError: { (responds, ErrorModel) in
            
            BFunction.shared.showToastMessge(ErrorModel.message)
            self.endRefresh(isNomore: true)
        }) { (error) in
            
            self.endRefresh(isNomore: true)
            
        }
    }
    
    
    //添加收货地址
    func addAddress(consignee: String, localArea: String, detailedAddress: String, defaultAddress: String, addresseePhone: String,postcode:String, succeeds:@escaping () -> Void) {
        let r = AddressAPI.addNewAddress(consignee: consignee, localArea: localArea, detailedAddress: detailedAddress, defaultAddress: defaultAddress, addresseePhone: addresseePhone,postcode: postcode)
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            let json = JSON.init(responds);
            print(json);
            self.defaultAddressModel = AddressModel.init(fromJson: json["data"]);
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            
            succeeds()
        }, requestError: { (responds, ErrorModel) in
            
            self.endRefresh();
            
        }) { (error) in
            
            self.endRefresh();
        }
    }
    
    //修改收货地址
    func modifiedAddress(consignee: String, localArea: String, detailedAddress: String, defaultAddress: String, addresseePhone: String, adressID:String,postcode:String,succeeds:@escaping () -> Void) {
        let r = AddressAPI.modifiedAddress(consignee: consignee, localArea: localArea, detailedAddress: detailedAddress, defaultAddress: defaultAddress, addresseePhone: addresseePhone,adressID: adressID,postcode: postcode);
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            let json = JSON.init(responds);
            print(json);
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            succeeds()
        }, requestError: { (responds, ErrorModel) in
            
            let json = JSON.init(responds);
            print(json);
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            
            self.endRefresh();
            
        }) { (error) in
            
            self.endRefresh();
        }
    }
    
    //删除地址
    func deleteAddress(adressID: String, succeeds:@escaping () -> Void)  {
        let r = AddressAPI.deleteAddress(adressID: adressID)
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            let json = JSON.init(responds);
            print(json);
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            succeeds()
        }, requestError: { (responds, ErrorModel) in
            
            let json = JSON.init(responds);
            print(json);
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            self.endRefresh();
            
        }) { (error) in
            BFunction.shared.showSuccessMessage(error.localizedDescription)
            self.endRefresh();
        }
    }
    
    ///获取默认收货地址
    func getDefaultAddress(succeeds:@escaping () -> Void)  {
        let r = AddressAPI.defaultAddress
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self](responds) in
            let json = JSON.init(responds);
            print(json);
           
            self?.defaultAddressModel = AddressModel.init(fromJson: json["data"]);
            BFunction.shared.showSuccessMessage(json["message"].stringValue)

        }, requestError: { (responds, ErrorModel) in
            
            let json = JSON.init(responds);
            print(json);
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            self.endRefresh();
            
        }) { (error) in
            
            self.endRefresh();
        }
    }
    
    
    
    ///修改订单选择的地址
    func orderAddressSelect(orderID: String, orderState: String, adressID: String,succeeds:@escaping () -> Void)  {
        let r = AddressAPI.orderAddressSelect(orderID: orderID, orderState: orderState, adressID: adressID)
        DDHTTPRequest.request(r: r, requestSuccess: {(responds) in
            let json = JSON.init(responds);
            print(json);
            
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            
            }, requestError: { (responds, ErrorModel) in
                
                let json = JSON.init(responds);
                print(json);
                BFunction.shared.showSuccessMessage(json["message"].stringValue)
                
        }) { (error) in
            
        }
    }
    
    
    
    
    
    
    // tableView停止刷新
    private func endRefresh(isNomore: Bool = false) {
        if numberPage == 0 {
            tableView?.mj_header.endRefreshing()
        }else {
            tableView?.mj_footer.endRefreshing()
            if isNomore {
                tableView?.mj_footer.endRefreshingWithNoMoreData()
            }
        }
    }
}

//
//  MSXMineOrderListVM.swift
//  Mythsbears
//
//  Created by macos on 2017/10/13.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class MSXMineOrderListVM{

    var numberPage = 0;
    var tableView:UITableView?
    var orderListArr = [ShopOrderModel]()
    var logisticsArr = [LogisticsModel]()
	
	
	
    ///全部订单
    func allOrderLister(succeeds:@escaping () -> Void) {
        let r = MineShopOrderAPI.allOrder(numberPage: "\(numberPage)");
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            let json = JSON.init(responds);
            print(json);
            
            if self?.numberPage == 0{
                
                self?.orderListArr.removeAll();
            }
            
            let jsonArr = json["data"].arrayValue;
            
            for items in jsonArr {
//                let json = items.arrayValue;
//                for item in json {
                    let model = ShopOrderModel.init(fromJson: items)
                    self?.orderListArr.append(model);
//                }
            }
            
            let isNomore = (self?.orderListArr.count)! > 0 ? false : true
            self?.endRefresh(isNomore: isNomore)
            
            BFunction.shared.showSuccessMessage(json["message"].stringValue)

            succeeds()
        }, requestError: {[weak self] (responds, ErrorModel) in
            let json = JSON.init(responds);
            let code = json["code"].intValue
            
            if code == 109{
                self?.orderListArr.removeAll();

                succeeds()

            }
            BFunction.shared.showToastMessge(ErrorModel.message)

            self?.endRefresh();

        }) { (error) in
            
            BFunction.shared.showToastMessge(error.localizedDescription)

            self.endRefresh();

        }
    }
    
    ///待付款订单
    func waitPayOrderLister(succeeds:@escaping () -> Void) {
        let r = MineShopOrderAPI.waitPayOrder(numberPage: "\(numberPage)");
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            let json = JSON.init(responds);
            print(json);
            if self?.numberPage == 0{
                
                self?.orderListArr.removeAll();
            }
            
            let jsonArr = json["data"].arrayValue;
            for item in jsonArr {
                let model = ShopOrderModel.init(fromJson: item)
                self?.orderListArr.append(model);
            }
            
            let isNomore = (self?.orderListArr.count)! > 0 ? false : true
            self?.endRefresh(isNomore: isNomore)
            
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            succeeds()
        }, requestError: {[weak self] (responds, ErrorModel) in
            print(responds);
            
            let json = JSON.init(responds);
            let code = json["code"].intValue
            
            if code == 109{
                
                self?.orderListArr.removeAll();

                succeeds();
            }
            
            BFunction.shared.showToastMessge(ErrorModel.message)

            self?.endRefresh();

        }) { (error) in
            self.endRefresh();

        }
    }
    
    ///待发货订单
    func waitSendOrderLister(succeeds:@escaping () -> Void) {
        let r = MineShopOrderAPI.waitSendOrder(numberPage: "\(numberPage)");
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            let json = JSON.init(responds);
            print(json);
            
            if self?.numberPage == 0{
                
                self?.orderListArr.removeAll();
            }
            
            let jsonArr = json["data"].arrayValue;
            for item in jsonArr {
                let model = ShopOrderModel.init(fromJson: item)
                self?.orderListArr.append(model);
            }
            
            let isNomore = (self?.orderListArr.count)! > 0 ? false : true
            self?.endRefresh(isNomore: isNomore)
            
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            succeeds()
        }, requestError: {[weak self] (responds, ErrorModel) in
            let json = JSON.init(responds);
            let code = json["code"].intValue
            
            if code == 109{
                
                succeeds();
            }
            self?.endRefresh();

            
        }) { (error) in
            
            self.endRefresh();

        }
    }
    
    
    ///待收货订单
    func waitGetOrderLister(succeeds:@escaping () -> Void) {
        let r = MineShopOrderAPI.waitGetOrder(numberPage: "\(numberPage)");
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            let json = JSON.init(responds);
            print(json);
            if self?.numberPage == 0{
                
                self?.orderListArr.removeAll();
            }
            
            let jsonArr = json["data"].arrayValue;
            for item in jsonArr {
                let model = ShopOrderModel.init(fromJson: item)
                self?.orderListArr.append(model);
            }
            
            let isNomore = (self?.orderListArr.count)! > 0 ? false : true
            self?.endRefresh(isNomore: isNomore)
            
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            succeeds()
        }, requestError: {[weak self] (responds, ErrorModel) in
            let json = JSON.init(responds);
            let code = json["code"].intValue
            
            if code == 109{
                self?.orderListArr.removeAll();

                succeeds();
            }
            self?.endRefresh();

        }) { (error) in
            
            self.endRefresh();
        }
    }
    
    //待评价订单
    func waitCommentOrderLister(succeeds:@escaping () -> Void) {
        let r = MineShopOrderAPI.waitCommentOrder(numberPage: "\(numberPage)");
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            let json = JSON.init(responds);
            print(json);
            if self?.numberPage == 0{
                
                self?.orderListArr.removeAll();
            }
            
            let jsonArr = json["data"].arrayValue;
            for item in jsonArr {
                let model = ShopOrderModel.init(fromJson: item)
                self?.orderListArr.append(model);
            }
            
            let isNomore = (self?.orderListArr.count)! > 0 ? false : true
            self?.endRefresh(isNomore: isNomore)
            
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            succeeds()
        }, requestError: {[weak self] (responds, ErrorModel) in
            let json = JSON.init(responds);
            let code = json["code"].intValue
            
            if code == 109{
                self?.orderListArr.removeAll();
                succeeds();
            }
            self?.endRefresh();
            
        }) { (error) in
            
            self.endRefresh();
        }
    }
    
    
    ///删除订单
    func deleteOrderLister(ordetID:String,orderState:String,succeeds:@escaping () -> Void) {
        let r = MineShopOrderAPI.deleteOrder(orderID: ordetID, orderState: orderState);
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            let json = JSON.init(responds);
            print(json);
   
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            succeeds()
            }, requestError: { (responds, ErrorModel) in
                BFunction.shared.showToastMessge(ErrorModel.message)
                
                self.endRefresh();
                
        }) { (error) in
            
            self.endRefresh();
        }
    }
    
    
    ///取消订单
    func cancleOrderLister(ordetID:String,succeeds:@escaping () -> Void) {
        let r = MineShopOrderAPI.cancleOrder(orderID: ordetID);
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            let json = JSON.init(responds);
            print(json);
            
            BFunction.shared.showSuccessMessage(json["message"].stringValue)
            succeeds()
            }, requestError: { (responds, ErrorModel) in
                BFunction.shared.showToastMessge(ErrorModel.message)
                
                self.endRefresh();
                
        }) { (error) in
            
            self.endRefresh();
        }
    }
    
    
    
    ///正在申请退款订单
    func reimburseOrderLister(succeeds:@escaping () -> Void) {
        let r = MineShopOrderAPI.reimburseNowOrder(numberPage: "\(numberPage)");
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            let json = JSON.init(responds);
            print(json);
            
            succeeds()
        }, requestError: { (responds, ErrorModel) in
            
            self.endRefresh();
            
        }) { (error) in
            
            self.endRefresh();
        }
    }
    
    //已退款订单
    func reimburseFinishOrderLister(succeeds:@escaping () -> Void) {
        let r = MineShopOrderAPI.reimburseFinishOrder(numberPager: "\(numberPage)");
        
        DDHTTPRequest.request(r: r, requestSuccess: {(responds) in
            let json = JSON.init(responds);
            print(json);
            
            succeeds()
        }, requestError: { (responds, ErrorModel) in
            
            self.endRefresh();
            
        }) { (error) in
            
            self.endRefresh();
        }
    }
    
    //订单详情
    func orderDetailLister(orderID:String, orderState:Int ,succeeds:@escaping () -> Void) {
        let r = MineShopOrderAPI.orderDetail(orderID: orderID, orderState: orderState);
    
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            let json = JSON.init(responds);
            
           
                let model = ShopOrderModel.init(fromJson: json["data"]);
                self?.orderListArr.append(model);
        
            self?.endRefresh();
            succeeds()
        }, requestError: {[weak self] (responds, ErrorModel) in
            
            BFunction.shared.showErrorMessage(ErrorModel.message);
            self?.endRefresh();
            
        }) {[weak self] (error) in
            
            self?.endRefresh();
        }
    }
    
    
    //查看物流
    func logisticsDetail(company:String,no:String, succeeds:@escaping () -> Void) {
        let r = MineShopOrderAPI.logistics(company: company, no: no);
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            let json = JSON.init(responds);
            
            let jsonArray = json["data"].arrayValue
            
            for item in jsonArray {
                let model = LogisticsModel.init(from: item);
                self?.logisticsArr.append(model);
            }
            
            self?.endRefresh();
            succeeds()
        }, requestError: { (responds, ErrorModel) in
            
            BFunction.shared.showErrorMessage(ErrorModel.message);
            self.endRefresh();
            
        }) { (error) in
            
            self.endRefresh();
        }
    }
    
    
    ///售后申请
    func applyAfterSale(orderID:String,return_type:Int,return_reason:String,return_explains:String ,succeeds:@escaping (_ code:Int)->()) {
        let r = AfterSaleAPI.afterSaleApply(orderID: orderID, return_type: return_type, return_reason: return_reason, return_explains: return_explains);
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            let json = JSON.init(responds)
            print(json);
            
            let code = json["code"].intValue
            var message = "申请失败，请稍后再试!"
            if code == 100 {
            message = "申请成功，请耐心等待!"
            }
            
            BFunction.shared.showSuccessMessage(message);

            succeeds(code);
        }, requestError: { (responds, errorModel) in
            
            BFunction.shared.showErrorMessage(errorModel.message);
        }) { (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription);

            
        }
        
    }
    
   ///申请退款_微信
    func applyRefundCash_weChat(orderID:String,succeeds:()->()) {
        let r = RefundAPI.refundCash_weChatPay(orderID: orderID);
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            let json = JSON.init(responds);
            print(json);
            

        }, requestError: { (responds, errorModel) in
            BFunction.shared.showErrorMessage(errorModel.message);
        }) { (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription)

        }
    }
    
   ///申请退款_支付宝
    func applyRefundCash_aliPay(orderID:String,succeeds:()->()) {
        let r = RefundAPI.refundCash_aliPay(orderID: orderID);
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            
            let json = JSON.init(responds);
            print(json);
            
        }, requestError: { (responds, errorModel) in
            BFunction.shared.showErrorMessage(errorModel.message);
        }) { (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription)
        }
    }
    
    
    ///确认收货
    func verifyTakeGoods(orderID:String,succeeds:@escaping ()->()) {
        
        let r = MineShopOrderAPI.varifyTakeGoods(orderID: orderID)
        DDHTTPRequest.requestWithJsonCoding(r: r, requestSuccess: {(responds) in
            let json = JSON.init(responds);
            
            let code = json["code"].intValue;
            
            if code == 0 {
                BFunction.shared.showSuccessMessage("确认成功");
                succeeds()
            }else{
                BFunction.shared.showSuccessMessage("网络异常,请重试！");
            }
          
        }, requestError: { (responds, ErrorModel) in
            
            BFunction.shared.showSuccessMessage(ErrorModel.message);

            self.endRefresh();
            
        }) { (error) in
            
            self.endRefresh();
        }
        
    }
	
	// 上级确认收款
	func submitPaymentState(uid:String,subordinateUid:String,orderId:String,paymentState:String,succeeds:@escaping ()->()) {
		
		let r = MineShopOrderAPI.submitPaymentState(uid: uid, subordinateUid: subordinateUid, orderId: orderId, paymentState: paymentState)
		
		DDHTTPRequest.requestWithJsonCoding(r: r, requestSuccess: {[weak self] (responds) in
			let json = JSON.init(responds);
			print(json);
	    	//BFunction.shared.showSuccessMessage(json["message"].stringValue)
			succeeds()
			}, requestError: { (responds, ErrorModel) in
				BFunction.shared.showToastMessge(ErrorModel.message)
				
		}) { (error) in
			
		
		}
	}
	
	//上级提交发货信息
	func submitDeliverGoods(uid: String, subordinateUid: String, orderId: String, expressNum: String,expressName:String,succeeds:@escaping ()->()){
		
		let r = MineShopOrderAPI.submitDeliverGoods(uid: uid, subordinateUid: subordinateUid, orderId: orderId, expressNum: expressNum, expressName: expressName)
		
		DDHTTPRequest.requestWithJsonCoding(r: r, requestSuccess: {[weak self] (responds) in
			let json = JSON.init(responds);
			print(json);
			//BFunction.shared.showSuccessMessage(json["message"].stringValue)
			succeeds()
			}, requestError: { (responds, ErrorModel) in
				BFunction.shared.showToastMessge(ErrorModel.message)
				
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

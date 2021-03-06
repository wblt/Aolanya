//
//  MineShopOrderAPI.swift
//  Mythsbears
//
//  Created by macos on 2017/10/13.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum MineShopOrderAPI {
    case allOrder(numberPage:String)
    case waitPayOrder(numberPage:String)
    case waitSendOrder(numberPage:String)
    case waitGetOrder(numberPage:String)
    case waitCommentOrder(numberPage:String)
    ///退款
    case reimburseNowOrder(numberPage:String)
    case reimburseFinishOrder(numberPager:String)
    case orderDetail(orderID:String,orderState:Int)
    ///物流
    case logistics(company:String,no:String)
    
    ///删除 0为未付款，1是已付款，2是交易成功，3是待收货4待评价
    case deleteOrder(orderID:String,orderState:String)
    
    ///取消订单
    case cancleOrder(orderID:String)
    
    ///确认收货
    case varifyTakeGoods(orderID:String)
	// 上级确认收款
	case submitPaymentState(uid:String,subordinateUid:String,orderId:String,paymentState:String)
	
	//上级 提交快递信息
	case submitDeliverGoods(uid:String,subordinateUid:String,orderId:String,expressNum:String,expressName:String)
}


extension MineShopOrderAPI:Request{
  
    var path: String {
        switch self {
        case .allOrder(_):
            return API.allOrderAPI
        case .waitPayOrder(_):
            return API.waitPayOrderAPI
        case .waitSendOrder(_):
            return API.waitSendOrderAPI
        case .waitGetOrder(numberPage: _):
            return API.waitGetOrderAPI
        case .waitCommentOrder(numberPage:_):
            return API.waitCommentOrderAPI
        case .reimburseNowOrder(numberPage: _):
            return API.reimburseNowAPI
        case .reimburseFinishOrder(numberPager: _):
            return API.reimburseFinishAPI
        case .orderDetail(orderID: _, orderState:_):
            return API.orderDetailAPI
        
        case .logistics(company: _, no: _):
            return API.logisticsAPI
        case .deleteOrder(orderID: _, orderState: _):
            return API.deleteOrderAPI
        case .varifyTakeGoods(orderID: _):
            return API.verifyTakeGoods
        case .cancleOrder(orderID: _):
            return API.cancleOrderAPI;
	case .submitPaymentState(uid:_,subordinateUid:_,orderId:_,paymentState:_):
			return API.submitPaymentStateAPI;
			
		case .submitDeliverGoods(uid:_, subordinateUid:_, orderId:_,expressNum:_,expressName:_):
			return API.submitDeliverGoodsAPI;
		}
    }
    
    var host: String {
        return API.baseServer
    }
    
    var isCheckNetStatus: Bool {
        return true
    }
    
    var isCheckRequestError: Bool {
        return true
    }
    
    
    var parameters: [String : Any]?{
//        0是待付款 1是已付款 2是交易成功 3是待收货 4是待评价）
        switch self {
        case .allOrder(let numberPage):
            
            var param = postParameters() // 所有订单
            param["numberPages"] = numberPage
            return DDIntegrationOfTheParameter(params: param, isNeedLogin: true)

        case .waitPayOrder(let numberPage):
            var param = postParameters()
            param["numberPages"] = numberPage
            param["orderStates"] = "0"
            return DDIntegrationOfTheParameter(params: param, isNeedLogin: true)
            
        case .waitSendOrder(let numberPage):
            
            var param = postParameters()
            param["numberPages"] = numberPage
            param["orderStates"] = "1"
            return DDIntegrationOfTheParameter(params: param, isNeedLogin: true)
            
        case .waitGetOrder(let numberPage): //  待收货
            var param = postParameters()
            param["numberPages"] = numberPage
            param["orderStates"] = "1,2"
            return DDIntegrationOfTheParameter(params: param, isNeedLogin: true)
            
            
        case .waitCommentOrder(let numberPage): // 已完成
            var param = postParameters()
            param["numberPages"] = numberPage
            param["orderStates"] = "3,4"
            return DDIntegrationOfTheParameter(params: param, isNeedLogin: true)
            
        case .reimburseNowOrder(let numberPage):
            var param = postParameters()
            param["numberPages"] = numberPage
            param["orderType"] = "5"
            return DDIntegrationOfTheParameter(params: param, isNeedLogin: true)
            
        case .reimburseFinishOrder(let numberPage):
            var param = postParameters()
            param["numberPages"] = numberPage
            param["orderType"] = "6"
            return DDIntegrationOfTheParameter(params: param, isNeedLogin: true)
            
            
        case .orderDetail(let orderID,let orderState):
            var param = postParameters()
            param["orderID"] = orderID
            param["orderState"] = orderState
            return DDIntegrationOfTheParameter(params: param, isNeedLogin: true)
         
            
        case .logistics(let company ,let no):
            var param = postParameters()
            param["company"] = company
            param["no"] = no
            return DDIntegrationOfTheParameter(params: param, isNeedLogin: true)
        case .deleteOrder(let orderID,let orderState):
            var param = postParameters()
            param["orderID"] = orderID;
            param["orderState"] = orderState;
            return DDIntegrationOfTheParameter(params: param, isNeedLogin: true);
        
        case .varifyTakeGoods(let orderID):
                var param = postParameters()
                param["orderID"] = orderID;
                return DDIntegrationOfTheParameter(params: param, isNeedLogin: true);
            
        case .cancleOrder(let orderID):
            var param = postParameters()
            param["orderID"] = orderID;
            return DDIntegrationOfTheParameter(params: param, isNeedLogin: true);
            
		case .submitPaymentState(let uid, let subordinateUid, let orderId, let paymentState):
			var param = [String:Any]()
		
			param["uid"] = uid
			param["subordinateUid"] = subordinateUid
			param["orderId"] = orderId
			param["paymentState"] = paymentState
			return param
		case .submitDeliverGoods(let uid, let subordinateUid, let orderId, let expressNum, let expressName):
			var param = [String:Any]()
			
			param["uid"] = uid
			param["subordinateUid"] = subordinateUid
			param["orderId"] = orderId
			param["expressNum"] = expressNum
			param["expressName"] = expressName
			return param
		}
    }
}

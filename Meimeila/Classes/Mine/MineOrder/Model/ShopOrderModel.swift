//
//  ShopOrderModel.swift
//  Mythsbears
//
//  Created by macos on 2017/10/14.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class ShopOrderModel{
    var id:String?
    var orderID:String?
    var uid:String?
    var orderInfo:[ShopOrderInfoModel]?
    var orderPrice:String?
    var orderType:String?
    var orderSource:String?
    var orderState:String?
    var effectiveTime:String?
   // var aeliveryAddress:String?
    var aeliveryAddressModel:AddressModel?
    var postage:String?
    
    var invoice:String?
    var remarks:String?
   
    ///发货时间
    var deliveryTime:String?
    
    var orderTime:String?
    var money:String?
    var expressCompany:String?
    var expressOrderNum:String?
    var payType:String?
    
    ///付款时间
    var pay_time:String?
    ///成交时间
    var closing_time:String?
    
    var orderStateTitle:String?
    var orderInfoNumber:String?
    var leftBtTitle:String?
    var rightBtTitle:String?
    var modifyBtTitle:String?
    
    ///订单总价
    var orderFinalPrice:String? = "0.00"
	//付款截图
	var paymentImg:String?
	// 交易单号
	var paymentNumber:String?
	
    init(fromJson json:JSON) {
		paymentImg = json["paymentImg"].stringValue
		paymentNumber = json["paymentNumber"].stringValue
		
        id = json["id"].stringValue
        orderID = json["orderID"].stringValue
        uid = json["uid"].stringValue
        postage = json["postage"].stringValue;
        
        let  arr = json["orderInfo"].arrayValue
        
        orderInfo = [ShopOrderInfoModel]()
        for item in arr {
            let infoModel = ShopOrderInfoModel.init(fromJson: item)
            orderInfo?.append(infoModel)
        }
        orderState = json["orderState"].stringValue
        orderPrice = json["orderPrice"].stringValue
        orderType = json["orderType"].stringValue
        orderSource = json["orderSource"].stringValue
        effectiveTime = json["effectiveTime"].stringValue
      //  aeliveryAddress = json["aeliveryAddress"].stringValue
        
        let addressJson = JSON.init(json["aeliveryAddress"]);
        aeliveryAddressModel = AddressModel.init(fromJson: addressJson);
        
        invoice = json["invoice"].stringValue
        remarks = json["remarks"].stringValue
		
		if json["deliveryTime"].isEmpty {
			deliveryTime = "时间"
		}else{
			deliveryTime = json["deliveryTime"].stringValue
		}
        orderTime = json["orderTime"].stringValue
        money = json["money"].stringValue
        expressCompany = json["expressCompany"].stringValue
        expressOrderNum = json["expressOrderNum"].stringValue
        payType = json["payType"].stringValue
        
        pay_time = json["pay_time"].stringValue
        closing_time = json["closing_time"].stringValue
        
        if let state = orderState {
            
     //查看全部订单-> 0是待付款 1已付款  2交易成功 3是待收货 4是待评价
     
    //订单详情-删除订单  0为待付款，1是已付款，2是交易成功，3是待收货 4待评价
    
     //独立->     0是待付款 1待发货  2待收货  4待评价 5正在申请退款 6已退款订单

            
            //now 0是待付款1是已付款2是交易成功3是待收货4是待评价
            
            
            let type = Int(state);
            
            
            //以下是全部订单的列表状态
            if type == 0{//待付款    // 待审核
                orderStateTitle = "待审核"
                leftBtTitle = "修改信息"
                rightBtTitle = "立即支付"
                modifyBtTitle = "取消订单"
//                orderStateTitle = "待审核"
//                leftBtTitle = "修改信息"
//                rightBtTitle = "待审核"
//                modifyBtTitle = "取消订单"
            }else if type == 1{ //已付款
                orderStateTitle = "待发货"
//                leftBtTitle = "退换退货"
//                rightBtTitle = "确认收货"
                leftBtTitle = "再次购买"
                rightBtTitle = "修改信息"

            }else if type == 4{//交易成功  2
                orderStateTitle = "交易成功"
               // leftBtTitle = "删除订单"
                rightBtTitle = "再次购买"

            }else if type == 2{//待收货 、、3
                orderStateTitle = "商家已发货"
                leftBtTitle = "查看物流"
                rightBtTitle = "确认收货"
                modifyBtTitle = "再次购买"
            }else if type == 3{//待评价 4
                orderStateTitle = "待评价"
                leftBtTitle = "查看物流"
                rightBtTitle =  "立即评价" //""
                modifyBtTitle = "再次购买"
            }else if type == 5{//申请退款
                orderStateTitle = "申请退款"
                leftBtTitle = "查看物流"
                rightBtTitle = "查看订单"
            }else if type == 6{//退款成功
                orderStateTitle = "退款成功"
                leftBtTitle = "删除订单"
                rightBtTitle = "查看订单"
            }
        }
        
        
        if !(orderInfo?.isEmpty)! {
            
            var number = 0;
            var price:Float = 0.0;
            for item in orderInfo!{
                let num = Int( item.shoppingNumber!) ?? 0
                
                let numTemp =  Float(num)
                let priceTemp = Float(item.price ?? "0") ?? 0.0
                
                price += numTemp * priceTemp;
                
                number += num;
            }
            
            orderFinalPrice = "\(price)";
            orderInfoNumber = "\(number)";
        }
        
        if orderFinalPrice == "0.00"{
            orderFinalPrice = orderPrice ?? "0.00"
        }
        
    }
}

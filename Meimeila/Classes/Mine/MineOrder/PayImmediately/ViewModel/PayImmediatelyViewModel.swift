//
//  PayImmediatelyViewModel.swift
//  Mythsbears
//
//  Created by macos on 2017/11/8.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol PayImmediatelyViewModelDelegate{
    
    func upDateTime(time:[Int])
    
}

class PayImmediatelyViewModel{

    var cellSelectBtState = [false,false,false];
    
    lazy var cellUIArr:[[String:String]] = {
        
        var dic = [
            ["title":"余额支付","icon":"icon_minePocket"],
                    ["title":"微信支付","icon":"wenxin_ico"],
                    ["title":"支付宝支付","icon":"alipay_ico"],
                   ]
       
        return dic;
    }()
    
    
    var timer:Timer?
    var shopModel:ShopOrderModel?
    
    weak var delegate:PayImmediatelyViewModelDelegate?
}


extension PayImmediatelyViewModel{
    
    
    func starTime() {
        
        timer = Timer.init(timeInterval: 1.0, target: self, selector: #selector(waitPayTime), userInfo: nil, repeats: true);
        
        if let _ = timer {
            RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes);

        }
    }
    
    func stopTime() {
        timer?.invalidate();
        timer = nil;
    }
    
    
    ///付款时间计算
    @objc func waitPayTime(){
        
        ///等待时间
        let effectiveTime = Int(shopModel?.effectiveTime ?? "0")!
        ///下单时间
        let orderTime = Int(shopModel?.orderTime ?? "0")!
        ///到期时间
		let overTime = effectiveTime + orderTime;
        
        ///当前时间
        let now = Date()
        //当前时间的时间戳
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let currentTime = Int(timeInterval);
        
        let timeFormate_now = timestampToDate(format: "yy-MM-dd HH:mm:ss", timestamp: "\(currentTime)")
        print("当前时间:",timeFormate_now);
        
        
        let timeFormate = timestampToDate(format: "yy-MM-dd HH:mm:ss", timestamp: "\(overTime)")
        print("超时时间:",timeFormate);
        
        
        let surplusTime = overTime - currentTime;
        print(surplusTime);
        
        var HH = surplusTime/3600;
        
        var MM =  (surplusTime - HH * 3600)/60
        
        var SS = surplusTime - HH * 3600 - MM * 60
                
        
        if HH < 0{
            HH = 0
        }
        
        if MM < 0 {
            MM = 0
        }
        
        if SS < 0 {
            
            SS = 0
        }
        
        let timeArr = [HH,MM,SS];

        delegate?.upDateTime(time: timeArr);
    }
    
}

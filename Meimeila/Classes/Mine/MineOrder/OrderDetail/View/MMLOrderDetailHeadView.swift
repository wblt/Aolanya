//
//  MMLOrderDetailHeadView.swift
//  Meimeila
//
//  Created by macos on 2017/11/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

let APPgreenColor = UIColor.RGB(r: 60, g: 182, b: 74)

class MMLOrderDetailHeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    lazy var titleLabel:UILabel = {
        let view = UILabel.init(frame: CGRect.zero);
        view.textColor = UIColor.white;
        view.font = UIFont.systemFont(ofSize: 16);
        view.text = "等待付款"
        return view;
    }()
    
    lazy var timeLabel:UILabel = {
        let view = UILabel.init(frame: CGRect.zero);
        view.textColor = UIColor.white;
        view.font = UIFont.systemFont(ofSize: 14);
        view.text = "请在00:00之前完成支付，逾期订单将关闭"
        return view;
    }()
    
    var setModel:ShopOrderModel?{
        didSet{
            
        //0是待付款1是已付款2是交易成功3是待收货4是待评价
        
            let orderState = setModel?.orderState!
            
            if orderState == "0" {
                ///等待时间
                let effectiveTime = Int(setModel?.effectiveTime ?? "0")!
                ///下单时间
                let orderTime = Int(setModel?.orderTime ?? "0")!
                ///到期时间
                let overTime = effectiveTime + orderTime;
                
                let time = timestampToDate(format:  "HH:mm", timestamp:"\(overTime)")
                
                timeLabel.text = "请在\(time)之前完成支付，逾期订单将关闭"
                
            }else if orderState == "1"{
                
                titleLabel.text = "已付款"
                timeLabel.text = "等待商家发货"
            }else if orderState == "2"{
                
                titleLabel.text = "交易成功"
                timeLabel.text = ""
            }else if orderState == "3"{
                titleLabel.text = "已发货"
                timeLabel.text = "等待用户收货"
            }else if orderState == "4"{
                
                titleLabel.text = "已收货"
                timeLabel.text = "等待用户评价"
            }
            
            
          
        }
    }
}

extension MMLOrderDetailHeadView{
    
    func setUI() {
        self.backgroundColor = APPgreenColor;
        self.addSubview(titleLabel);
        self.addSubview(timeLabel);
        adjustLayput();
    }
    
    func adjustLayput() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(34);
            make.top.equalToSuperview().offset(10);
            make.width.equalTo(100);
            make.height.equalTo(20);
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(34);
            make.top.equalTo(titleLabel.snp.bottom).offset(5);
            make.right.equalTo(-16);
            make.height.equalTo(20);
        }
    }
    
   
}

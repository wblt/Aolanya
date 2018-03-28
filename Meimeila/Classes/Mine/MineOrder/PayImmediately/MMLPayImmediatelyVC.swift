//
//  MMLPayImmediatelyVC.swift
//  Meimeila
//
//  Created by macos on 2017/11/24.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLPayImmediatelyVC: DDBaseViewController {

    
    @IBOutlet weak var weChatPayBt: UIButton!
    
    @IBOutlet weak var aliPayBt: UIButton!
    
    @IBAction func weChatPayAction(_ sender: Any) {
        
        payType = 1;
        
        weChatPayBt.isSelected = true;
        aliPayBt.isSelected = false;
    }
    
    
    @IBAction func aliPayAction(_ sender: Any) {
        
        payType = 2;
        
        weChatPayBt.isSelected = false;
        aliPayBt.isSelected = true;
        
    }
    
    
    @IBOutlet weak var canclePayBt: UIButton!
    
    
    @IBOutlet weak var payBt: UIButton!
    
    
    @IBAction func canclePayAction(_ sender: Any) {
        
        self.dismiss(animated: false) {
            
        }
    }
    
    @IBAction func payAction(_ sender: Any) {
        
        payAction(type: payType);
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addNotificationMonitor();
        
    }

    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing:String.init(describing: MMLPayImmediatelyVC.self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupUI() {
        setUI();
    }
    
    lazy var order_vm:MSXPocketViewModel = {[weak self] in
        let vm = MSXPocketViewModel();
        return vm;
        }()
    
    var shopOrderModel:ShopOrderModel!
    var productInfoModel:MMLSettlementProductInfoModel!
    private var isHaveToPay: Bool = false // 是否已经支付过了

    var payType = 1;
    
    deinit {
        Barista.remove(observer: self, notification: .aliPayResult)
        Barista.remove(observer: self, notification: .wechatPayResult)
    }
}

extension MMLPayImmediatelyVC{
    
    
    func setUI() {
        weChatPayBt.isSelected = true;
        canclePayBt.layer.borderWidth = 1.0;
        canclePayBt.layer.borderColor = UIColor.lightGray.cgColor;
        canclePayBt.layer.cornerRadius = canclePayBt.bounds.height/2;
        
        payBt.layer.cornerRadius = payBt.bounds.height/2;
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5);
    }
    
}



extension MMLPayImmediatelyVC{
    
    // 添加通知监听微信或者支付支付的结果
    private func addNotificationMonitor() {
        
        Barista.add(observer: self, selector: #selector(wechatPayResultNotification(noti:)), notification: .wechatPayResult)
        Barista.add(observer: self, selector: #selector(aliPayResultNotification(noti:)), notification: .aliPayResult)
    }
    
    // 微信支付的结果
    @objc func wechatPayResultNotification(noti: Notification) {
        debugLog(noti.object)
        let index = noti.object as! Int
        let isPaySuccess: Bool = index == 0 ? true : false
        if !isHaveToPay {
            isHaveToPay = true
            // 跳转到结算页
        
        }
        
    }
    
    // 支付宝支付的结果
    @objc func aliPayResultNotification(noti: Notification) {
        debugLog(noti.object)
        guard let result = noti.object as? [String: String] else {return}
        let index = Int(result["resultStatus"]!)
        let isPaySuccess: Bool = index == 9000 ? true : false
        if !isHaveToPay {
            isHaveToPay = true
            // 跳转到结算页
           
        }
    }
}

//使用充值接口支付
extension MMLPayImmediatelyVC{
    
    ///开始支付
    func payAction(type:Int) {
        
        if type == 0{
            
        }else if type == 1{
            
            if DDWechatPay.shared.isWXAppInstalled(){
                
                weChatPayRequest(orderID:shopOrderModel.orderID ?? "" , price: shopOrderModel.orderFinalPrice ?? "0.00", invoice: nil)
            }else{
                
                BFunction.shared.showMessage("您未安装微信，无法支付!")
            }
            
        }else if type == 2{
            aliPayRequest(orderID: shopOrderModel.orderID ?? "", price: shopOrderModel.orderFinalPrice ?? "0.00", invoice: nil)
        }
        
    }
    
    ///使用微信充值接口支付
    func weChatPayRequest(orderID:String,price:String,type:Int = 1,invoice:String?) {
        
        order_vm.reChargeMoneyWith_weChatPay(price: price, orderID: orderID,type:type,invoice: invoice ,succeeds: {[weak self] in
            
            DDWechatPay.shared.payAction(payModel: (self?.order_vm.WechatPayModel)!);
        })
    }
    
    ///使用支付宝充值接口支付
    func aliPayRequest(orderID:String,price:String,type:Int = 1,invoice:String?) {
        
        order_vm.reChargeMoneyWith_alipay(price: price, orderID: orderID,type:type, invoice: invoice,succeeds: {[weak self] in
            
            DDAliPay.shared.payAction(orderStr: (self?.order_vm.aliPayModel.getAlipay)!, successBlock: { (result) in
                
                Barista.post(notification: .aliPayResult, object: result as AnyObject)
                
            })
        })
    }
    
}

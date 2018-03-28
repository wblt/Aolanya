//
//  MMLPayResultVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MMLPayResultVCDelegate{
    func payAgain(type:Int)

}


class MMLPayResultVC: DDBaseViewController {

    //
    weak var delegate:MMLPayResultVCDelegate?
    
    var isPayImmediately = false;
    var payType = 0;
    
    // 是否支付成功
    var isPaySuccess: Bool = false
    // 来自哪个支付方式 0 是微信 1是支付宝
    var isFormType: Int = 0
    
    // 支付用来重新支付的信息
    var orderStr: String = ""
    
    // 微信用来支付的信息
    var wechatPayModel: DDWechatPayModel!
    
    private let paySuccessStr = "我们将尽快安排发货，请买家保持手机通讯畅通，以便快递小哥哥能第一时间联系到您。"
    private let payFailStr = "该订单会为您保留2小时(从下单时算起)，2小时后如果未付款，系统将自动取消该订单。"
    private let paySuccessMessage = "支付成功"
    private let payFailMessage = "支付失败，请从新支付"
    
    @IBOutlet weak var payResultButton: UIButton!
    @IBOutlet weak var payStatusMessageLabel: UILabel!
    @IBOutlet weak var shoppingButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var viewOrdersButton: UIButton!
    
    init() {
        super.init(nibName: String.init(describing: MMLPayResultVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "支付结果"
        addNotificationMonitor()
        
        
        addNavBarBackButton(imageName: "btn_back_white") { (bt) in
            
            
            if self.isPaySuccess{
                self.navigationController?.popToRootViewController(animated: false);
                
                Barista.post(notification: Barista.Notification.gotoHome);
                
            }else{
                
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    deinit {
        Barista.remove(observer: self, notification: .aliPayResult)
        Barista.remove(observer: self, notification: .wechatPayResult)
    }
    
    override func setupUI() {
        shoppingButton.layer.borderColor = shoppingButton.titleLabel?.textColor.cgColor
        shoppingButton.layer.borderWidth = 1
        viewOrdersButton.layer.borderColor = viewOrdersButton.titleLabel?.textColor.cgColor
        viewOrdersButton.layer.borderWidth = 1
        messageLabel.text = isPaySuccess ? paySuccessStr : payFailStr
        shoppingButton.setTitle(isPaySuccess ? "继续购物" : "继续支付", for: .normal)
        if isPaySuccess {
            payStatusMessageLabel.text = paySuccessMessage
            payStatusMessageLabel.textColor = DDGlobalNavBarColor()
            payResultButton.isSelected = false
        }else {
            payStatusMessageLabel.text = payFailMessage
            payStatusMessageLabel.textColor = UIColor.red
            payResultButton.isSelected = true
        }
    }
    
    // 添加通知监听微信或者支付支付的结果
    private func addNotificationMonitor() {
        
        Barista.add(observer: self, selector: #selector(wechatPayResultNotification(noti:)), notification: .wechatPayResult)
        Barista.add(observer: self, selector: #selector(aliPayResultNotification(noti:)), notification: .aliPayResult)
    }
    
    // 支付宝支付
    func aliPayAction() {
        DDAliPay.shared.payAction(orderStr: orderStr) { (result) in
            debugLog(result)
            Barista.post(notification: .aliPayResult, object: result as AnyObject)
        }
    }
    
    // 微信支付
    func wechatPayAction() {
        DDWechatPay.shared.payAction(payModel: wechatPayModel)
    }


    // MARK: - Event respose
    // 继续购物或者重新支付
    @IBAction func shoppingAction(_ sender: Any) {
        if isPaySuccess {
            navigationController?.popToRootViewController(animated: false)
            Barista.post(notification: .gotoHome)
            
        }else {
            
            if isPayImmediately{
                
                delegate?.payAgain(type: payType);
                
            }else{
                // 重新支付
                if isFormType == 0 {
                    wechatPayAction()
                }else {
                    aliPayAction()
                }
                
            
            }
        }
    }
    
    // 查看订单
    @IBAction func viewOrderListAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: false)
        Barista.post(notification: .gotoOrders)
    }
    
}

// MARK: - Event respose
extension MMLPayResultVC {
    // 微信支付的结果
    @objc func wechatPayResultNotification(noti: Notification) {
        debugLog(noti.object)
        let index = noti.object as! Int
        let isPaySuccess: Bool = index == 0 ? true : false
        self.isPaySuccess = isPaySuccess
        setupUI()
    }
    
    // 支付宝支付的结果
    @objc func aliPayResultNotification(noti: Notification) {
        debugLog(noti.object)
        guard let result = noti.object as? [String: String] else {return}
        let index = Int(result["resultStatus"]!)
        let isPaySuccess: Bool = index == 9000 ? true : false
        self.isPaySuccess = isPaySuccess
        setupUI()
    }
}

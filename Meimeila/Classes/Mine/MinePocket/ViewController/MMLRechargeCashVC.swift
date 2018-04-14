//
//  MMLRechargeCashVC.swift
//  Meimeila
//
//  Created by macos on 2017/11/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@objc protocol MMLRechargeCashVCDelegate{
    
    func payResult(cash:String,isPaySuccess:Bool,isFormType:Int)
}

class MMLRechargeCashVC: DDBaseViewController {

    @IBOutlet weak var weChatPayBt: UIButton!
    
    @IBOutlet weak var aliPayBt: UIButton!
    
    
    @IBOutlet weak var moneyPayBt: UIButton!
    @IBOutlet weak var BGView: UIView!
    
    
    @IBOutlet weak var weChatBGView: UIView!
    
    @IBOutlet weak var aliPayBGView: UIView!
    
    
    @IBOutlet weak var moneyPayBGView: UIView!
    
    @IBOutlet weak var cashTF: UITextField!
    
    
    @IBOutlet weak var cancleBt: UIButton!
    @IBAction func cancleBtAction(_ sender: Any) {
        
        self.dismiss(animated: false) {
            
        }
    }
    

    @IBOutlet weak var rechargeBt: UIButton!
    
    @IBAction func rechargeBtAction(_ sender: Any) {
        
        payNow();
    }
    
    
    @IBAction func weChatPayAction(_ sender: Any) {
       
        
        weChatPayBt.isSelected = true;
        aliPayBt.isSelected = false;
        payType = 1;
    }
    

    @IBAction func TFChange(_ sender: Any) {
        
        cash = cashTF.text;
        
    }
    
    @IBAction func aliPayAction(_ sender: Any) {
        weChatPayBt.isSelected = false;
        aliPayBt.isSelected = true;
        payType = 2;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addNotificationMonitor();
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        IQKeyboardManager.sharedManager().enable = true;
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.sharedManager().enable = false;
    }
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLRechargeCashVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        setUI();
        addTapGuest();
    }
    
    
    deinit {
        Barista.remove(observer: self, notification: .aliPayResult)
        Barista.remove(observer: self, notification: .wechatPayResult)
    }
    
    var payType = 1;
    var cash:String?;
    private var isHaveToPay: Bool = false // 是否已经支付过了

    lazy var vm:MSXPocketViewModel = {[weak self] in
        let vm = MSXPocketViewModel();
        return vm;
        }()
    weak var delegate:MMLRechargeCashVCDelegate?
    
    
    lazy var moneyPay:MMLMoneyPayViewModel = {
        
        let vm = MMLMoneyPayViewModel.shared;
        return vm;
    }()
}

extension MMLRechargeCashVC{
    
    func setUI() {
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5);
        
        BGView.layer.cornerRadius = 8.0;
        BGView.clipsToBounds = true;
        cancleBt.layer.cornerRadius = cancleBt.bounds.height/2;
        rechargeBt.layer.cornerRadius = cancleBt.bounds.height/2;
        cancleBt.layer.borderWidth = 1.0;
        cancleBt.layer.borderColor = UIColor.lightGray.cgColor;
        rechargeBt.layer.borderWidth = 1.0;
        rechargeBt.layer.borderColor = DDGlobalNavBarColor().cgColor;
        weChatPayBt.isSelected = true;
    }
    
    func addTapGuest()  {
        let weChatTap = UITapGestureRecognizer.init(target: self, action: #selector(weChatTapAction));
        weChatBGView.addGestureRecognizer(weChatTap);
        
        let aliTap = UITapGestureRecognizer.init(target: self, action: #selector(aliTapAction));
        aliPayBGView.addGestureRecognizer(aliTap);
        
        let moneyTap = UITapGestureRecognizer.init(target: self, action: #selector(moneyTapAction));
        moneyPayBGView.addGestureRecognizer(moneyTap);
        
        
    }
    
    
    @objc func weChatTapAction(){
        
        weChatPayBt.isSelected = true;
        aliPayBt.isSelected = false;
//        moneyPayBt.isSelected = false;
        payType = 1;
    }
    
    @objc func aliTapAction(){
        weChatPayBt.isSelected = false;
        aliPayBt.isSelected = true;
//        moneyPayBt.isSelected = false;
        payType = 2;
    }
    
    @objc func moneyTapAction(){
        weChatPayBt.isSelected = false;
        aliPayBt.isSelected = false;
//        moneyPayBt.isSelected = true;
        payType = 3;
        
    }
}

//pay
extension MMLRechargeCashVC{

    func payNow() {
        
        if cash == nil {
            BFunction.shared.showErrorMessage("请输入金额")
            return;
        }
        
        switch payType {
            
        case 3:
            print("余额支付");
            
            
            
            
        case 2:
            
            vm.reChargeMoneyWith_alipay(price: cash ?? "1", orderID: nil,type:0, invoice:nil,succeeds: {[weak self] in

                DDAliPay.shared.payAction(orderStr: (self?.vm.aliPayModel.getAlipay)!, successBlock: { (result) in

                    Barista.post(notification: .aliPayResult, object: result as AnyObject)

                })
            })
//
            vm.newReChargeMoneyWith_aliPay(price: cash ?? "1",succeeds: {[weak self] in
                DDAliPay.shared.payAction(orderStr: (self?.vm.aliPayModel.getAlipay)!, successBlock: { (result) in
                    
                    Barista.post(notification: .aliPayResult, object: result as AnyObject)
                    
                })
                //DDWechatPay.shared.payAction(payModel: (self?.vm.WechatPayModel)!);
            })
            
        case 1:
            
            
            if DDWechatPay.shared.isWXAppInstalled(){
                
//                vm.reChargeMoneyWith_weChatPay(price: cash ?? "1", orderID: nil,type:0, invoice: nil,succeeds: {[weak self] in
//
//                    DDWechatPay.shared.payAction(payModel: (self?.vm.WechatPayModel)!);
//                })
				vm.newReChargeMoneyWith_weChatPay(price: cash ?? "1",succeeds: {[weak self] in
					
					DDWechatPay.shared.payAction(payModel: (self?.vm.WechatPayModel)!);
				})
            }else{
                
                BFunction.shared.showErrorMessage("未安装微信，无法支付！")
                
            }
            
        default:
            BFunction.shared.showErrorMessage("请选择支付方式")

        }
    
   
    
    }
    
    
}
extension MMLRechargeCashVC{
    
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
            self.dismiss(animated: false, completion: {
                
            })
            delegate?.payResult(cash: cash ?? "0", isPaySuccess: isPaySuccess, isFormType: 0)

        }
        
    }
    
    // 支付宝支付的结果
    @objc func aliPayResultNotification(noti: Notification) {
        debugLog(noti.object)
        guard let result: [String: Any] = noti.object as! [String : Any] else {return};
        let index :NSString  = (result["resultStatus"] as? NSString)!
        let isPaySuccess: Bool = index == "9000"  ? true : false
        if !isHaveToPay {
            isHaveToPay = true
            // 跳转到结算页
            self.dismiss(animated: false, completion: {
                
            })
            delegate?.payResult(cash: cash ?? "0", isPaySuccess: isPaySuccess, isFormType: 1)
        }
    }
}


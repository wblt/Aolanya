//
//  PocketRechargeStateVC.swift
//  Mythsbears
//
//  Created by macos on 2017/11/16.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class PocketRechargeStateVC: DDBaseViewController {

    @IBOutlet weak var payStatueIconBt: UIButton!
    @IBOutlet weak var payStatueLabel: UILabel!
    @IBOutlet weak var payTypeLabel: UILabel!
    @IBOutlet weak var payTimeLabel: UILabel!
    @IBOutlet weak var payAgainBt: UIButton!
    @IBOutlet weak var StopPayBt: UIButton!
    @IBAction func payAgainBtAction(_ sender: Any) {
    
        payAgain();
    }
    
    @IBAction func stopPayBtAction(_ sender: Any) {
    
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addNotificationMonitor();
        
    }

    deinit {
        Barista.remove(observer: self, notification: .aliPayResult)
        Barista.remove(observer: self, notification: .wechatPayResult)
    }
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing:String.init(describing: PocketRechargeStateVC.self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupUI() {
        self.title = "充值状态"
        setUI();
    }
    
    var isPaySuccess = false;
    var isFormType = 0; //0:微信  1:支付宝
    var payMoney:String?
    private var isHaveToPay: Bool = false // 是否已经支付过了

    lazy var vm:MSXPocketViewModel = {[weak self] in
        let vm = MSXPocketViewModel();
        return vm;
        }()}


extension PocketRechargeStateVC{
    
    func setUI() {
        
        payAgainBt.layer.cornerRadius = 5;
        StopPayBt.layer.cornerRadius = 5;
        
        if isPaySuccess {
            payAgainBt.isHidden = true;
            StopPayBt.isHidden = true;
            payStatueIconBt.isSelected = true;
            payStatueLabel.text = "钱包充值成功!"
            payStatueLabel.textColor = DDGlobalNavBarColor();
            
            DDUtility.delay(1, closure: {[weak self] in
                
               self?.navigationController?.popViewController(animated: true);
            })
            
        }else{
            payAgainBt.isHidden = false;
            StopPayBt.isHidden = false;
            payStatueIconBt.isSelected = false;
            payStatueLabel.text = "钱包充值失败!";
            payStatueLabel.textColor = UIColor.RGB(r: 243, g: 79, b: 141);
        }
        
        
        if isFormType == 0 {
            payTypeLabel.text = "充值方式:微信支付"
        }else{
            payTypeLabel.text = "充值方式:支付宝支付"
        }
        
        ///当前时间
        let now = Date()
        //当前时间的时间戳
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let currentTime = Int(timeInterval);
        
        let timeFormate_now = timestampToDate(format: "yy-MM-dd HH:mm:ss", timestamp: "\(currentTime)")
        print("当前时间:",timeFormate_now);
        
        payTimeLabel.text = "充值日期:\(timeFormate_now)"
        
    }

}

extension PocketRechargeStateVC{
    
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
           // 跳转到结算页
            
        if isPaySuccess{
            
            self.isPaySuccess = true;
            setUI();
        }else{
            
        }
    }
    
    // 支付宝支付的结果
    @objc func aliPayResultNotification(noti: Notification) {
        debugLog(noti.object)
        guard let result = noti.object as? [String: String] else {return}
        let index = Int(result["resultStatus"]!)
        let isPaySuccess: Bool = index == 9000 ? true : false
        
            if isPaySuccess{
                
                self.isPaySuccess = true;
                setUI();
            }else{
                
            }
    }
    
    
    
    func payAgain() {
       
        switch isFormType {
        case 1:
            
            vm.reChargeMoneyWith_alipay(price: payMoney ?? "1", orderID: nil,type:0, invoice: nil,succeeds: {[weak self] in
                
                DDAliPay.shared.payAction(orderStr: (self?.vm.aliPayModel.getAlipay)!, successBlock: { (result) in
                    
                    Barista.post(notification: .aliPayResult, object: result as AnyObject)
                    
                })
            })
            
        case 0:
            vm.reChargeMoneyWith_weChatPay(price: payMoney ?? "1", orderID: nil,type:0,invoice:nil, succeeds: {[weak self] in
                
                DDWechatPay.shared.payAction(payModel: (self?.vm.WechatPayModel)!);
            })

        default:
            print("error");
        }
        

    }
    
    
}

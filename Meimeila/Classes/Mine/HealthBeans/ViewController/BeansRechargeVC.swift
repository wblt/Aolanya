//
//  BeansRechargeVC.swift
//  Meimeila
//
//  Created by macos on 2017/12/11.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


@objc protocol BeansRechargeVCDelegate {
    
    
 func beansRechargeResult(cash: String, isPaySuccess: Bool, isFormType: Int)
}

class BeansRechargeVC: DDBaseViewController {

    weak var delegate:BeansRechargeVCDelegate?
    
    var type = 0;
    
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var cashTF: UITextField!
    
    @IBAction func cancleBtAction(_ sender: Any) {
        
        self.dismiss(animated: false) {
            
        }
    }
    
    @IBAction func rechargeBtAction(_ sender: Any) {
        
        print("充值");
        
        if (cashTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("请输入金额");
        }else{
            
            rechargeNow();
        
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        addNotificationMonitor();
        
    }

    
    deinit {
        Barista.remove(observer: self, notification: .aliPayResult)
        Barista.remove(observer: self, notification: .wechatPayResult)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        IQKeyboardManager.sharedManager().enable = true;

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.sharedManager().enable = false;

        
    }
    
    
    override func setupUI() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5);
        setTableView();
    }
    
    
    lazy var vm:MMLBeansViewModel = {
        let vm = MMLBeansViewModel();
        return vm;
    }()
    
    
    lazy var pocketvm:MSXPocketViewModel = {[weak self] in
        let vm = MSXPocketViewModel();
        return vm;
        }()
    
    
    lazy var moneyPay:MMLMoneyPayViewModel = {
        
        let vm = MMLMoneyPayViewModel.shared;
        return vm;
    }()
    
    private var isHaveToPay: Bool = false // 是否已经支付过了
    var cash:String?;

    
    func setTableView() {
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 55;
        tableView.bounces = false;
        tableView.tableFooterView = UIView.init();
        tableView.backgroundColor = DDGlobalBGColor()
        tableView.showsVerticalScrollIndicator = false;
        
        tableView.register(UINib.init(nibName: String.init(describing: MMHealthBeansCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMHealthBeansCell.self));
        
    }
    
}

extension BeansRechargeVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MMHealthBeansCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMHealthBeansCell.self)) as? MMHealthBeansCell;
        cell?.separatorInset.left = 0;
        cell?.selectionStyle = .none;
        if let _ = cell {
            
        }else{
            
            cell = Bundle.main.loadNibNamed(String.init(describing: MMHealthBeansCell.self), owner: nil, options: nil)?.last as? MMHealthBeansCell;
        }
        cell?.setDic = vm.cellDic[indexPath.row];
        cell?.setBtSelect = vm.selectState[indexPath.row];
        return cell!;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return vm.selectState.count;
    }
    
}

extension BeansRechargeVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row);
        
        let row = indexPath.row;
        
        for index in 0 ..< 3 {
            
            vm.selectState[index] = false;

            if row == index {
                vm.selectState[index] = true;
            }
            
        }
        
        type = row;
        
        tableView.reloadData();
        
    }
}


//豆充值
extension BeansRechargeVC{
    
    func rechargeNow() {
        
        let cash = cashTF.text ?? "0"
        
        self.cash = cash;
        
        if type == 0 {
            
            pocketvm.reChargeMoneyWith_weChatPay(price: cash, orderID: nil, type: 2, invoice: nil, succeeds: {[weak self] in
                
                 DDWechatPay.shared.payAction(payModel: (self?.pocketvm.WechatPayModel)!);
                
            })
        }else if type == 1{
            
            pocketvm.reChargeMoneyWith_alipay(price: cash, orderID:nil,  type: 2,invoice:  nil) {[weak self] in
                
                DDAliPay.shared.payAction(orderStr: (self?.pocketvm.aliPayModel.getAlipay)!, successBlock: { (result) in
                    
                    Barista.post(notification: .aliPayResult, object: result as AnyObject)
                    
                })
            }
            
        }else{
            
           let vc =  MMLMoneyPayKeyBoardVC()
            vc.isHealthBeans = true;
            vc.cash = cash;
            vc.delegate = self;
            vc.modalPresentationStyle = .overFullScreen;
            vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.5);
            self.present(vc, animated: false, completion: {
                
            })
        }
        
       
    }
    
}


extension BeansRechargeVC{
    
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
            delegate?.beansRechargeResult(cash: cash ?? "0", isPaySuccess: isPaySuccess, isFormType: 0)
            
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
            self.dismiss(animated: false, completion: {
                
            })
            delegate?.beansRechargeResult(cash: cash ?? "0", isPaySuccess: isPaySuccess, isFormType: 1)
        }
    }
}


extension BeansRechargeVC:MMLMoneyPayKeyBoardVCDelegate{
    func exchangeGiftPW(pw: String) {
        
    }
    
    func paySucceeds(issucceeds: Bool) {
        
        self.dismiss(animated: false) {
            
            self.delegate?.beansRechargeResult(cash: self.cash ?? "0", isPaySuccess: issucceeds, isFormType: 2)
        }
    }
    
    func forgetPw() {
        
        self.dismiss(animated: false) {
            
            Barista.post(notification: .goSet);

        }
        
    }
    
    
}

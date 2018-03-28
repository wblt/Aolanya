//
//  MMLMoneyPayKeyBoardVC.swift
//  Meimeila
//
//  Created by macos on 2017/12/7.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MMLMoneyPayKeyBoardVCDelegate{
    
    func forgetPw()
    
    func paySucceeds(issucceeds:Bool)
    
    func exchangeGiftPW(pw:String)
    
    
}

class MMLMoneyPayKeyBoardVC: DDBaseViewController {

    weak var delegate:MMLMoneyPayKeyBoardVCDelegate?
    
    @IBOutlet weak var BGView: UIView!
    
    @IBOutlet weak var closedBt: UIButton!
    
    @IBOutlet weak var boarderBGView: UIView!
    
    @IBOutlet weak var TF: UITextField!
    
    
    @IBOutlet weak var num_0: UILabel!
    
    @IBOutlet weak var num_1: UILabel!
    
    
    @IBOutlet weak var num_2: UILabel!
    
    @IBOutlet weak var num_3: UILabel!
    
    
    @IBOutlet weak var num_4: UILabel!
    
    @IBOutlet weak var num_5: UILabel!
    
    var pw:String?
    var isHealthBeans = false;
    var isExchangeGift = false;
    var cash:String?
    
    lazy  var numArr:[UILabel] = {[weak self] in
        
        var  num = [self?.num_0,self?.num_1,self?.num_2,self?.num_3,self?.num_4,self?.num_5];
        return num as! [UILabel];
    }()
    
    lazy var vm:MMLMoneyPayViewModel = {
        let vm = MMLMoneyPayViewModel.shared;
        return vm;
    }()
    
    lazy var giftvm:MMLLuckDrawRecordViewModel = {
        
        let vm = MMLLuckDrawRecordViewModel.init()
        return vm;
    }()
    
    var payModel:MMLMoneyPayModel!;
    
    
    @IBAction func forgetPWBtAction(_ sender: Any) {
        
        print("忘记密码");
        self.dismiss(animated: false) {
            self.delegate?.forgetPw();

        }
    }
   
  
    @IBAction func closedBtAction(_ sender: Any) {
        
        self.dismiss(animated: false) {
            
        }
    }
    
    
    init() {
        super.init(nibName: String.init(describing: MMLMoneyPayKeyBoardVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        TF.becomeFirstResponder();
    }
    
    override func setupUI() {
        
        boarderBGView.layer.borderWidth = 1;
        boarderBGView.layer.borderColor = UIColor.lightGray.cgColor;
        boarderBGView.layer.cornerRadius = 5.0;
        
        
    }
   
    
    @IBAction func TFEndAction(_ sender: Any) {
        
        print("TF--------end-------->",TF.text)

    }
    
    @IBAction func TFChangeAction(_ sender: Any) {
        
        print("TF-------change--------->",TF.text)
        
        let count = TF.text?.count;
        
        if let _ = count {
            
            setPWLabel(count: count);
            
            if count! == 6{
                BFunction.shared.showLoadingMessage("正在提交!");
                
                TF.resignFirstResponder();
                payNow(count: count!);
            }
            
        }
        
    }
    
    ///余额支付
    func payNow(count:Int) {
        
        if isHealthBeans{
            
            vm.moneyPayBeanRecharge(payment_pwd: TF.text!, orderPrice: cash ?? "0", orderType: "2", succeeds: {
                
                BFunction.shared.hideLoadingMessage();
                
                self.dismiss(animated: false, completion: {
                    self.delegate?.paySucceeds(issucceeds: true);
                    
                })
                
            }, fails: {[weak self] in
                
                self?.setPWLabel(count: count,clear: true);
                self?.TF.text = "";
                
                let vc = DDPopupWindowVC.init(message: "支付失败", leftButtonTitle: "放弃支付", rightButtonTitle: "重新支付");
                vc.delegate = self;
                
                self?.addChildViewController(vc);
                vc.view.frame = (self?.view.bounds)!;
                self?.view.addSubview(vc.view);
            })
            
        }else if isExchangeGift{
            
           
            delegate?.exchangeGiftPW(pw: TF.text!)
            
        }else{
            print("---->",TF.text!);
            
            vm.moneyPayOrder(payment_pwd: TF.text!, orderID:payModel.orderID, orders: payModel.orders!, orderType: "1", adressID: payModel.addressID!, invoice: payModel.invoice,succeeds: {[weak self] in
                
                self?.dismiss(animated: false, completion: {
                    
                    self?.delegate?.paySucceeds(issucceeds: true);

                })
                
                
            }, fails: {[weak self] in
                
                self?.setPWLabel(count: count,clear: true);
                self?.TF.text = "";
                
                let vc = DDPopupWindowVC.init(message: "支付失败", leftButtonTitle: "放弃支付", rightButtonTitle: "重新支付");
                vc.delegate = self;
                
                self?.addChildViewController(vc);
                vc.view.frame = (self?.view.bounds)!;
                self?.view.addSubview(vc.view);
            })
            
        }
        
        
    }
    
    
    
}

extension MMLMoneyPayKeyBoardVC:DDPopupWindowVCDelegate{
    func popupWindowVCLeftButtonAction(button: UIButton) {
        
        
    }
    
    func popupWindowRightVCButtonActtion(button: UIButton) {
        
        self.TF.becomeFirstResponder();
        
    }
    
    
    
}

extension MMLMoneyPayKeyBoardVC{
    
    fileprivate  func setPWLabel(count:Int?,clear:Bool = false) {
        
        for index in  0 ..< 6{
            
            let lb = numArr[index];
            
            if index < count! && clear == false{
                lb.text = "•"
            }else{
                
                lb.text = "";
            }
            
        }
    }
    
}

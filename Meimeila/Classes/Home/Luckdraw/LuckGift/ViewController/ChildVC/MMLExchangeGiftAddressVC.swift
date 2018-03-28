//
//  MMLExchangeGiftAddressVC.swift
//  Meimeila
//
//  Created by macos on 2018/1/2.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class MMLExchangeGiftAddressVC: DDBaseViewController {
        
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var addressLabelBGView: UIView!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var addressTF: UITextField!
    
    @IBOutlet weak var postCodeTF: UITextField!
    @IBAction func exchangeBtAction(_ sender: Any) {
        
        if TFverify() {
            
            exchangeNow()
        }else{
            
            
        }
        
    }
    
    
    
    var exchangeModel:MMLLuckDrawModel!
    var popWin:DDPopupWindowVC?
    var addressSelect:String?
    var keyBoardVC:MMLMoneyPayKeyBoardVC?
    
    lazy var vm:MMLLuckDrawRecordViewModel = {
        
        let vm = MMLLuckDrawRecordViewModel.init()
        return vm;
    }()
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLExchangeGiftAddressVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        
        addressLabelBGView.addGestureRecognizer(tap);
    }
    
    lazy var tap:UITapGestureRecognizer = {
        let  tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(tap:)))
        return tap;
    }()

}


extension MMLExchangeGiftAddressVC:MMLMoneyPayKeyBoardVCDelegate{
    func exchangeGiftPW(pw: String) {
        
        
        exchange(payment_pwd: pw);
    }
    
    func forgetPw() {
        
        let vc = MMLMineSet();
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    func paySucceeds(issucceeds: Bool) {
        
        
    }
    
    
}

extension MMLExchangeGiftAddressVC{
    
    func exchangeNow() {
        let vc = MMLMoneyPayKeyBoardVC()
        vc.modalPresentationStyle = .overFullScreen;
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.5);
        vc.delegate = self
        vc.isExchangeGift = true;
        keyBoardVC = vc;
        self.present(vc, animated: false) {
            
            
        }
    }
    
    
    func exchange(payment_pwd:String){
        
        keyBoardVC?.dismiss(animated: false, completion: {
            
            self.vm.exChangeGift(payment_pwd:payment_pwd, consignee: self.nameTF.text ?? "", addresseePhone: self.phoneTF.text ?? "", localArea: self.addressSelect ?? "", detailedAddress: self.addressTF.text ?? "", postcode: self.postCodeTF.text ?? "", postage: self.exchangeModel.postage ?? "0", id: self.exchangeModel.id ?? "", succeeds: {
                
                BFunction.shared.showMessage("兑换成功");
            
                DDUtility.delay(1, closure: {
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil);
                    
                    self.navigationController?.popViewController(animated: true);
                })
                
            }) {
                
                
            }
            
        })
        
    }
    
    
    func TFverify() -> Bool {
        if (nameTF.text?.isEmpty)! {
            
            BFunction.shared.showMessage("收货人姓名不能为空")
            return false;
        }
        
        if (phoneTF.text?.isEmpty)!{
            BFunction.shared.showMessage("收货人手机号不能为空")

            return false;
        }
        
        if let _ = addressSelect{
            
        }else{
            BFunction.shared.showMessage("地址不能为空")

            return false
        }
        
        
        if (addressTF.text?.isEmpty)!{
            BFunction.shared.showMessage("详细地址不能为空")
            return false;
        }
        
        if (postCodeTF.text?.isEmpty)!{
            BFunction.shared.showMessage("邮政编码不能为空")
            
            return false;
        }
        return true;
    }
    
    
    ///地址选择
    @objc func tapAction(tap:UITapGestureRecognizer){
        
        let vc = MMLAddressSelectVC();
        vc.modalPresentationStyle = .overFullScreen;
        vc.delegate = self;
        self.present(vc, animated: false) {
        }
    }
    
    
    func popwinExchangeAlter(model:MMLLuckDrawModel) {
        
        let title = "兑换\(model.prizename ?? "")"
        
        let pop = DDPopupWindowVC.init(message: title, leftButtonTitle: "取消", rightButtonTitle: "确定")
        pop.modalPresentationStyle = .overFullScreen;
        popWin = pop;
        
        pop.delegate = self;
        self.present(pop, animated: false) {
            
        }
    }
    
}

    
extension MMLExchangeGiftAddressVC:MMLAddressSelectVCDelegate{
    func addressSelectFinish(address: String, vc: MMLAddressSelectVC) {
        
        vc.dismiss(animated: false) {[weak self] in
            
            self?.addressLabel.text = address;
            self?.addressSelect = address;
        }
    }
    
}
    
    
extension MMLExchangeGiftAddressVC:DDPopupWindowVCDelegate{
    func popupWindowVCLeftButtonAction(button: UIButton) {
        self.popWin?.dismiss(animated: false, completion: {
            
        })
    }
    
    func popupWindowRightVCButtonActtion(button: UIButton) {
        self.popWin?.dismiss(animated: false, completion: {
            
        })
    }
    
    
}

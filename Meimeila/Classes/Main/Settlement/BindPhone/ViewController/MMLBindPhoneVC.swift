//
//  MMLBindPhoneVC.swift
//  Meimeila
//
//  Created by macos on 2017/12/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLBindPhoneVC: DDBaseViewController {

    
    @IBOutlet weak var codeBt: DDCountDownButton!
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var codeTF: UITextField!
    
    
    @IBOutlet weak var finishBt: UIButton!
    
    
    @IBAction func codeBtAction(_ sender: Any) {
        smsGet();
    }
    
    
    @IBAction func finishBtAction(_ sender: Any) {
        
        bindPhone();
        
    }
    
    var isBindPhone:Bool = true;
    
    init() {
        super.init(nibName: String.init(describing: MMLBindPhoneVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !isBindPhone {
            finishBt.setTitle("解除绑定", for: UIControlState.normal);
        }
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        if let _ = codeBt.validcodeTimer {
            codeBt.stopEclipse();
        }
    }
    
    override func setupUI() {
        
    }
    
    lazy var vm: MMLMoneyPayViewModel = {
        
        let vm = MMLMoneyPayViewModel.shared;
        return vm;
    }()

}

extension MMLBindPhoneVC{
    
    func bindPhone()  {
        
        if verify(){
            var type = 1;
            
            if !isBindPhone{
            
                type = 2;
            }
            
            
            vm.moneyPayBindPhone(code: codeTF.text ?? "", type: "\(type)", phone: phoneTF.text ?? "", succeeds: {[weak self] in
                
                var message = "绑定成功!";
                
                if !(self?.isBindPhone)!{
                    message = "解绑成功";
                }
                
                self?.navigationController?.popViewController(animated: true);
                BFunction.shared.showSuccessMessage(message);
                
            }, fails: {
                
                
            })
            
        }
    }
    
    func verify() -> Bool{
        
        if (phoneTF.text?.isEmpty)!{
            
            BFunction.shared.showErrorMessage("请输入手机号");
            return false;
        }
        
        if (codeTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("请输入验证码");
            return false;
        }
        return true;
    }
    
    
    func smsGet() {
        
        if (phoneTF.text?.isEmpty)!{
            BFunction.shared.showErrorMessage("请输入手机号码");
            return ;
        }
        
        vm.moneyPayGetSMS(phone: phoneTF.text ?? "") {[weak self] (succeeds) in
            self?.codeBt.startEclipse();
            BFunction.shared.showSuccessMessage("发送成功!");
        }
       
    }
    
    
}

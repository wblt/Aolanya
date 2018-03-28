//
//  MMLForgetPasswordVC.swift
//  Meimeila
//
//  Created by macos on 2017/10/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLForgetPasswordVC: DDBaseViewController {

    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var smsTF: UITextField!
    
    @IBOutlet weak var smsBt: DDCountDownButton!
    
    @IBOutlet weak var resetBt: UIButton!
    
    //验证码
    @IBAction func smsBtAction(_ sender: Any) {
     
        if JQValidate.phoneNum(phoneTF.text!).isRight {
            
            BFunction.shared.showLoading();
            
            MMLLoginViewModel.shared.getSMSAction(phone: phoneTF.text!, type: 2, succeeds: { (isSucceed) in
                
                self.smsBt.startEclipse();
                BFunction.shared.showSuccessMessage("发送成功")
                
                
            })
            
        }else{
            
            BFunction.shared.showErrorMessage("请输入手机号")
        }
    }
    
    //重置密码
    @IBAction func resetBtAction(_ sender: Any) {
        if TFverifyInpute() {
            
            MMLLoginViewModel.shared.forgetPasswordAction(phone: phoneTF.text!, newPassword: passwordTF.text!, sms: smsTF.text!)
        }
        
    }
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLForgetPasswordVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        if let _ = smsBt.validcodeTimer {
            smsBt.stopEclipse();
        }
    }
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        smsBt.layer.cornerRadius = 15;
        resetBt.layer.cornerRadius = 22;
        self.title = "忘记密码";
    }

}

extension MMLForgetPasswordVC{
    
    func TFverifyInpute() -> Bool {
        
        if (phoneTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("请输入手机号");
            return false;
        }
        
        
        if (passwordTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("请输入密码");
            return false;
        }
        
        if(smsTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("请输入验证密码");
            return false;
        }
        
        
        
        return true;
    }
    
    func TFoutFistResponds() {
        phoneTF.resignFirstResponder();
        passwordTF.resignFirstResponder();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        TFoutFistResponds();
    }
}

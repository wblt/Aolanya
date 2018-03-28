//
//  MMLRegisterVC.swift
//  Meimeila
//
//  Created by macos on 2017/10/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLRegisterVC: DDBaseViewController {

    
    @IBOutlet weak var phoneTF: UITextField!
   
    @IBOutlet weak var paasswordTF: UITextField!
    @IBOutlet weak var inviateTF: UITextField!
   
    @IBOutlet weak var smsTF: UITextField!
    
    @IBOutlet weak var smsBt: DDCountDownButton!
    
    @IBOutlet weak var registerBt: UIButton!
    
    
    //发送验证码
    @IBAction func smsBtAction(_ sender: Any) {
        
        if JQValidate.phoneNum(phoneTF.text!).isRight {
            
            BFunction.shared.showLoading()

            MMLLoginViewModel.shared.getSMSAction(phone: phoneTF.text!, type: 1) { (isSucceeds) in
                self.smsBt.startEclipse()
                BFunction.shared.showSuccessMessage("发送成功")
            }
            
        }else {
            
            BFunction.shared.showErrorMessage("请输入正确手机号")

        }
    }
    
    //注册
    @IBAction func registerBtAction(_ sender: Any) {
        
        if TFverifyInpute() {
            
            MMLLoginViewModel.shared.registerAction(phone: phoneTF.text!, password: paasswordTF.text!, sms: smsTF.text!, inviter: inviateTF.text,succeeds: {
                
                DDUtility.delay(1, closure: {
                    
                    self.navigationController?.popViewController(animated: true);
                })
                
            });
        }
        
    }
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLRegisterVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        if let _ = smsBt.validcodeTimer {
            smsBt.stopEclipse();
        }
    }
    
    override func setupUI() {
        smsBt.layer.cornerRadius = 15;
        registerBt.layer.cornerRadius = 22;
        self.title = "注册";

    }

}


extension MMLRegisterVC{
    
    func TFverifyInpute() -> Bool {
        
        if (phoneTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("请输入手机号");
            return false;
        }
        
       
        if (paasswordTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("请输入密码");
            return false;
        }
        
        if (smsTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("请输入验证码密码");
            return false;
        }
        
        return true;
    }
    
    func TFoutFistResponds() {
        phoneTF.resignFirstResponder();
        paasswordTF.resignFirstResponder();
        inviateTF.resignFirstResponder();
        smsTF.resignFirstResponder();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        TFoutFistResponds();
    }
}


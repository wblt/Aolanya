//
//  MMLMoneyPaySetPWVC.swift
//  Meimeila
//
//  Created by macos on 2017/12/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMoneyPaySetPWVC: DDBaseViewController {

    
    @IBOutlet weak var codeBt: DDCountDownButton!
    
    @IBOutlet weak var pwTF: UITextField!
    
    
    @IBOutlet weak var codeTF: UITextField!
    
    @IBOutlet weak var finishBt: UIButton!
    
    
    @IBOutlet weak var phoneTF: UITextField!
    @IBAction func codeBtAction(_ sender: Any) {
        
        smsGet();
    }
    
    @IBAction func finishBtAction(_ sender: Any) {
        
        setOrChangePw();
    }
    
    
    
    
    init() {
        super.init(nibName: String.init(describing: MMLMoneyPaySetPWVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

extension MMLMoneyPaySetPWVC{
    
    func setOrChangePw() {
        
        if verify() {
            vm.moneyPaySetPwd(payment_pwd: pwTF.text ?? "", code: codeTF.text ?? "", succeeds: {[weak self] in
                
                BFunction.shared.showSuccessMessage("密码设置成功!");
                self?.navigationController?.popViewController(animated: true);
            }, fails: {
                
                BFunction.shared.showSuccessMessage("密码设置失败!");

            })

        }
        
    }
    
    
    func smsGet() {
        
        if !(phoneTF.text?.isEmpty)! {
            vm.moneyPayGetSMS(phone: phoneTF.text ?? "", succeeds: {[weak self] (succeeds) in
                
                BFunction.shared.showSuccessMessage("发送成功!")
                self?.codeBt.startEclipse();
            })

        }else{
            BFunction.shared.showErrorMessage("请输入手机号");

        }
        
    }
    
    
    func verify()->Bool {
        
        if  !(pwTF.text?.isEmpty)! {
            
        }else{
            
            BFunction.shared.showErrorMessage("请输入密码")
            return false;
        }
        
        if  !(codeTF.text?.isEmpty)! {}else{
            BFunction.shared.showErrorMessage("请输入验证码")
            return false;
        }
        
        return true;
    }
    
}

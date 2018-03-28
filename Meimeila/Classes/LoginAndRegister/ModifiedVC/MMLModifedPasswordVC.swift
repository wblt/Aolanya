//
//  MMLModifedPasswordVC.swift
//  Meimeila
//
//  Created by macos on 2017/11/29.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLModifedPasswordVC: DDBaseViewController {

    
    @IBOutlet weak var oldpwTF: UITextField!
    
    @IBOutlet weak var newpwTF: UITextField!
    
    @IBOutlet weak var newpwAgainTF: UITextField!
    
    @IBOutlet weak var enterBt: UIButton!
    
    @IBAction func enterBtAction(_ sender: Any) {
        
        changePw();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        enterBt.layer.cornerRadius = 22;
        
    }

    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLModifedPasswordVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var vm: MMLLoginViewModel = {
        let vm = MMLLoginViewModel.shared;
        return vm;
    }()
}


extension MMLModifedPasswordVC{
    
    func changePw() {
       
        if verify(){
        vm.changePasswordAction(original: oldpwTF.text ?? "", newPassword: newpwTF.text ?? "", verifyPassword: newpwAgainTF.text ?? "")
        }
    }
    
    
    func verify() -> Bool {
        
        if (oldpwTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("请输入旧密码")
            return false;
        }
        
        if (newpwTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("请输入新密码")

            return false;

        }
        
        if (newpwAgainTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("请再输入旧密码")

            return false;

        }
        
        return true;
    }
    
}

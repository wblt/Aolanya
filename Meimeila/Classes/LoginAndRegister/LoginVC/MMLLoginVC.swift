//
//  MMLLoginVC.swift
//  Meimeila
//
//  Created by macos on 2017/10/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

@objc protocol MMLLoginVCDeleagate {
    // 登录成功
    func loginVCFinish()
}

class MMLLoginVC: DDBaseViewController {

    weak var delegate: MMLLoginVCDeleagate?
    
    
    @IBOutlet weak var line: UIView!
    
    @IBOutlet weak var or: UILabel!
    
    
    @IBOutlet weak var weChatBtLabel: UILabel!
    @IBOutlet weak var weChatBt: UIButton!
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginBt: UIButton!
    
    //注册
    @IBAction func registerBtAction(_ sender: Any) {
        
        navigationController?.pushViewController(MMLRegisterVC(), animated: true);
    }
    
    //忘记密码
    @IBAction func forgetPasswordBtAction(_ sender: Any) {
        navigationController?.pushViewController(MMLForgetPasswordVC(), animated: true);
    }
    
    //微信登录
    @IBAction func weChatBtAction(_ sender: Any) {
		
        let installed = DDWechatLogin.shared.isWXAppInstalled()

        if installed{

            DDWechatLogin.shared.loginAction(callBack: {[weak self] (openid, access_token, result) in

                let json = JSON.init(result )
                let model = DDWechatLoginResultModel.init(from: json)
                MMLLoginViewModel.shared.loginWeChatAction(openid: openid, name: model.nickname!, gender: model.sex!, iconurl: model.headimgurl!, succeed: {

                    self?.perform(#selector(self?.succeedLogin), with: nil, afterDelay: 1.0);

                })

            })
        }else{

            BFunction.shared.showErrorMessage("未安装微信,无法登录!")
        }
		
    }
    
	@IBAction func qqBtLogin(_ sender: Any) {
	}
	
	@IBAction func weiboBtLogin(_ sender: Any) {
	}
	
	//登录
    @IBAction func loginBtAction(_ sender: Any) {
   
        TFoutFistResponds()
        
        if TFverifyInpute() {
            
            MMLLoginViewModel.shared.loginAction(phone: phoneTF.text!, password: passwordTF.text!, succeed: {[weak self] in
                self?.perform(#selector(self?.succeedLogin), with: nil, afterDelay: 1.0);
            })
            
        }
    }
    
    @objc  func succeedLogin() {
        if let _ = delegate {
            delegate?.loginVCFinish()
        }
      //  jPsuhViewModel.upLoadJPushRegistID()
        self.navigationController?.popViewController(animated: true);
        
    }
    
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLLoginVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        DDWechatLogin.shared.wxchat_addObserver();
        
        hiddenWeChatBt();
    }

    override func setupUI() {
        loginBt.layer.cornerRadius = 22;
        self.title = "登录";
    }

    // MARK: - Lazy load
    private var jPsuhViewModel: DDJPushViewModel = DDJPushViewModel()
    
    
    func hiddenWeChatBt() {
        let installed = DDWechatLogin.shared.isWXAppInstalled()
        
        if installed{}else{
            
            line.isHidden = true;
            weChatBt.isHidden = true;
            weChatBtLabel.isHidden = true;
            or.isHidden = true;
        }
    }
    
    
}

extension MMLLoginVC{
    
    func TFverifyInpute() -> Bool {
        
        if (phoneTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("请输入手机号");
            return false;
        }
        
        
        if (passwordTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("请输入密码");
            return false;
        }
        
        if !JQValidate.phoneNum(phoneTF.text!).isRight {
            
            BFunction.shared.showErrorMessage("请输入正确的手机号码");
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

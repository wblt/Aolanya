//
//  MMLMineOpinionVC.swift
//  Meimeila
//
//  Created by macos on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMineOpinionVC: DDBaseViewController {

	 var titleMsg: String!
	
	@IBOutlet weak var titleBtn: UIButton!
	@IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var sendBt: UIButton!
    
    
    @IBAction func sendBtAction(_ sender: Any) {
        
        if verifyInPut() {
            
            
            vm.submit(feedbackMessage: textView.text , feedbackPhone: phoneTF.text, feedbackAdress: nil, feedbackType: "0", succeeds: {
                
            }) {
                
                
            }
            
        }
        print("提交");
    }
    
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLMineOpinionVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
       // self.title = "意见反馈";
		titleBtn.setTitle(titleMsg, for: UIControlState.normal)
        sendBt.layer.cornerRadius = 15;
    }

    lazy var vm:OpinionFeedbackViewModel = {
        
        let vm = OpinionFeedbackViewModel.shared;
        return vm;
    }()
}


extension MMLMineOpinionVC {
    
    func verifyInPut() -> Bool {
        
        if textView.text.isEmpty {
            
            BFunction.shared.showErrorMessage("描述不能为空");
            
            return false;
        }
        
        if phoneTF.text!.isEmpty {
            BFunction.shared.showErrorMessage("手机号不能为空");
            return false;
        }
        
       
        return true;
    }
    
    
    func outFistRespond() {
        
        phoneTF.resignFirstResponder();
        textView.resignFirstResponder();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        outFistRespond();
    }
    
    
}

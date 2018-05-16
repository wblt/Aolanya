//
//  ALYAgentApplyVC.swift
//  Meimeila
//
//  Created by wy on 2018/4/11.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAgentApplyVC: DDBaseViewController {

	lazy var uservm:MMLUserInfoViewModel = {[weak self] in
		let vm = MMLUserInfoViewModel.init();
		return vm;
		}()
	
    init() {
        super.init(nibName: String.init(describing: ALYAgentApplyVC.self), bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		uservm.getUserInfo {[weak self] in
			
			// 保存用户等级
			DDUDManager.share.saveUserLevel((self?.uservm.infoModel?.level)!)
			//保存管理员信息
			DDUDManager.share.saveUseraoLanYaAdmin((self?.uservm.infoModel?.aoLanYaAdmin)!)
			DDUDManager.share.saveInviter((self?.uservm.infoModel?.inviter)!)
		}
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我要赚钱"
        // Do any additional setup after loading the view.
		
		
		
    }

    @IBAction func firstBtnClick(_ sender: Any) {
		
		// 判断是否填写了邀请人， 如果有邀请人 就进入审核页面
		let inviter = DDUDManager.share.getInviter() as String
		if inviter == "0" || inviter == "" {
			let vc = ALYAgentMsgInputVC()
			vc.areaType = "1"
			navigationController?.pushViewController(vc, animated: true)
		}else {
			// 审核中
			let vc = ALYAgentCheckVC()
			self.navigationController?.pushViewController(vc, animated: true)
		}
    }
    @IBAction func secondBtnClick(_ sender: Any) {
		
		
		// 判断是否填写了邀请人， 如果有邀请人 就进入审核页面
		let inviter = DDUDManager.share.getInviter() as String
		if inviter == "0" || inviter == "" {
			let vc = ALYAgentMsgInputVC()
			vc.areaType = "2"
			navigationController?.pushViewController(vc, animated: true)
		}else {
			// 审核中
			let vc = ALYAgentCheckVC()
			self.navigationController?.pushViewController(vc, animated: true)
		}
		
    }
    
    @IBAction func thridBtnClick(_ sender: Any) {
		// 判断是否填写了邀请人， 如果有邀请人 就进入审核页面
		let inviter = DDUDManager.share.getInviter() as String
		if inviter == "0" || inviter == "" {
			let vc = ALYAgentViewController()
			navigationController?.pushViewController(vc, animated: true)
		}else {
			// 审核中
			let vc = ALYAgentCheckVC()
			self.navigationController?.pushViewController(vc, animated: true)
		}
		
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ALYAgentViewController.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/8.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAgentViewController: DDBaseViewController {
	@IBOutlet weak var invitTextField: UITextField!
	
	private lazy var cardDataViewModel: LevelCardDataViewModel = {[weak self] in
		let viewModel = LevelCardDataViewModel.init()
		return viewModel
		}()
	
	init() {
		super.init(nibName: String.init(describing: ALYAgentViewController.self), bundle: nil)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.barStyle = .black
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.title = "我要赚钱"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	@IBAction func applyWithInvitationCodeClick(_ sender: Any) {
		
		let loginStatue = DDDeviceManager.shared.loginStatue();
		if !loginStatue {
			let vc = MMLLoginVC()
			self.navigationController?.pushViewController(vc, animated: true);
			return;
		}
		
		if invitTextField.text == "" {
			BFunction.shared.showToastMessge("请输入邀请码")
			return
		}
		
//		let vc = ALYAgentlevelVC();
//		self.navigationController?.pushViewController(vc, animated: true);
		self.cardDataViewModel.checkInvitationCode(Code: invitTextField.text!) {
			
			if !self.cardDataViewModel.invitationCodeIsRight {
				BFunction.shared.showMessage("邀请码不存在")
			}else {
				let vc = ALYAgentlevelVC();
				
				self.navigationController?.pushViewController(vc, animated: true);
			}
			
		}
	}
	
	@IBAction func applyClick(_ sender: Any) {
		
		let loginStatue = DDDeviceManager.shared.loginStatue();
		if !loginStatue {
			let vc = MMLLoginVC()
			self.navigationController?.pushViewController(vc, animated: true);
			
			return;
		}
		
		let vc = ALYAgentlevelVC();
		self.navigationController?.pushViewController(vc, animated: true);
		
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

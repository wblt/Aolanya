//
//  ALYAgentManagerVC.swift
//  Meimeila
//
//  Created by wy on 2018/4/13.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAgentManagerVC: DDBaseViewController {

	@IBOutlet weak var headImgView: UIImageView!
	
	@IBOutlet weak var nameLab: UILabel!
	
	@IBOutlet weak var agentLab: UILabel!
	
	@IBOutlet weak var numLab: UILabel!
	
	@IBOutlet weak var buyBgView: UIView!
	
	@IBOutlet weak var saleBgView: UIView!
	
	@IBOutlet weak var profitBgView: UIView!
	
	@IBOutlet weak var agentCheckBgView: UIView!
	
	@IBOutlet weak var agentManagerbgView: UIView!
	
	@IBOutlet weak var lastAgentBgView: UIView!
	
	@IBOutlet weak var OrderManagerBgView: UIView!
	
	@IBOutlet weak var ArebgView: UIView!
	
	@IBOutlet weak var AreaBgCheckView: UIView!
	
	//iOS8用到XIB必须写这两个方法
	init() {
		super.init(nibName: String.init(describing: ALYAgentManagerVC.self), bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    lazy var uservm:MMLUserInfoViewModel = {[weak self] in
        let vm = MMLUserInfoViewModel.init();
        return vm;
        }()
    
    lazy var agentVm:AgentManagerViewModel  = {
        let vm = AgentManagerViewModel.init();
        return vm;
    }()
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
        requestUserInfo()
    }
	
	override func setupUI() {
		// 如果不是管理员
		let tap1  = UITapGestureRecognizer.init(target: self, action: #selector(lastAgentTap))
		lastAgentBgView.addGestureRecognizer(tap1)
		
		let tap2  = UITapGestureRecognizer.init(target: self, action: #selector(agentManagerTap))
		agentManagerbgView.addGestureRecognizer(tap2)
		let tap3  = UITapGestureRecognizer.init(target: self, action: #selector(agentCheckTap))
		agentCheckBgView.addGestureRecognizer(tap3)
		let tap4  = UITapGestureRecognizer.init(target: self, action: #selector(orderManagerTap))
		OrderManagerBgView.addGestureRecognizer(tap4)
		
		// 这两个 有时候需要隐藏
		let tap5  = UITapGestureRecognizer.init(target: self, action: #selector(areaTap))
		ArebgView.addGestureRecognizer(tap5)
		let tap6  = UITapGestureRecognizer.init(target: self, action: #selector(areaCheckTap))
		AreaBgCheckView.addGestureRecognizer(tap6)
	}
    //获取代理人信息
    func requestAgentData() {
		
		let uid = DDUDManager.share.getUserID()
		agentVm.getAgentManagerData(uid: uid) {[weak self] in
			
			self?.nameLab.text = self?.agentVm.superiorAgentModel?.realName ?? self?.uservm.infoModel?.name
			let num = self?.agentVm.lowerAgentArray.count as! Int
			self?.numLab.text = "下级代理\(num)人"
		};
		
    }
    
	// 获取用户信息
    func requestUserInfo() {
        uservm.getUserInfo {[weak self] in
            
            self?.headImgView.jq_setImage(imageUrl: self?.uservm.infoModel?.picture ?? "", placeholder: "icon_defaultHeadIcon", isShowIndicator: false, isNeedForceRefresh: false)
            
            //self?.nameLab.text = self?.uservm.infoModel?.name ?? DDUDManager.share.getUserID()
			self?.requestAgentData()
        }
    }
	
	@objc func lastAgentTap(){
		let vc = ALYLastAgentVC()
		vc.superiorAgentModel = self.agentVm.superiorAgentModel
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	@objc func agentManagerTap() {
		let vc = ALYNextAgentManagerVC()
		vc.lowerAgentArray = self.agentVm.lowerAgentArray
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	@objc func agentCheckTap() {
		let vc = ALYAgentCheckManagerVC()
		self.navigationController?.pushViewController(vc, animated: true)
	}
	@objc func orderManagerTap() {
		let vc = ALYOrderManagerVC()
		self.navigationController?.pushViewController(vc, animated: true)
	}
	@objc func areaTap() {
		let vc = ALYAreaVC()
		self.navigationController?.pushViewController(vc, animated: true)
	}
	@objc func areaCheckTap() {
		let vc = ALYAreaCheckViewController()
		vc.toBeAuditedArray = self.agentVm.toBeAuditedArray
		self.navigationController?.pushViewController(vc, animated: true)
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

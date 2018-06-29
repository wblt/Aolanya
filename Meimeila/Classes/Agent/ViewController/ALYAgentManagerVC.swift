//
//  ALYAgentManagerVC.swift
//  Meimeila
//
//  Created by wy on 2018/4/13.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class ALYAgentManagerVC: DDBaseViewController {
	
	@IBOutlet weak var profitLab: UILabel!
	
	@IBOutlet weak var sellMoneyLab: UILabel!
	
	
	@IBOutlet weak var buyMoneyLab: UILabel!
	
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
	
	
	var agentVC = ALYAgentApplyVC()
	
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
	
	//获取所有订单
	lazy var ordervm:MSXMineOrderListVM = {[weak self] in
		let vm = MSXMineOrderListVM()
		return vm;
		}()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let level = DDUDManager.share.getUserLevel() as String
		// 判断是 无等级还是在审核中 还是已经不是审核中了 ,并且还要判断、是否需要切换
		if level != "0"  && level != ""{
			requestUserInfo()
			getAllOrder()
			getAgentOrder()
			agentVC.view.removeFromSuperview()
			agentVC.removeFromParentViewController()
		}else {
			if self.childViewControllers.count  == 0  {
				self.addChildViewController(agentVC)
				agentVC.view.frame = (self.view.bounds);
				self.view.addSubview(agentVC.view);
			}
		}
		
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
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
		
		// 区域审核只有 管理员可以审核
		let admin = DDUDManager.share.getUseraoLanYaAdmin()
		if admin != "1" {
			AreaBgCheckView.isHidden = true
		}else {
			AreaBgCheckView.isHidden = false
		}
	}
    //获取代理人信息
    func requestAgentData() {
		
		let uid = DDUDManager.share.getUserID()
		agentVm.getAgentManagerData(uid: uid) {[weak self] in
			
			self?.nameLab.text = self?.agentVm.superiorAgentModel?.realName ?? self?.uservm.infoModel?.name
			let num = self?.agentVm.lowerAgentArray.count as! Int
			self?.numLab.text = "下级代理\(num)人"
			let level = DDUDManager.share.getUserLevel() as String
			let admin = DDUDManager.share.getUseraoLanYaAdmin()
			if level == "1" {
				self?.agentLab.text = "零售"
			}else if level == "2"{
				self?.agentLab.text = "金牌会员"
			}else if level == "3"{
				self?.agentLab.text = "大区"
			}else if level == "4"{
				self?.agentLab.text = "联合股东"
			}else if level == "5"{
				self?.agentLab.text = "联合创始人"
			}
			
			if admin == "1" {
				self?.agentLab.text = "管理员"
			}
		};
		
    }
    
	// 获取用户信息
    func requestUserInfo() {
		self.headImgView.layer.cornerRadius = 45.0
		self.headImgView.layer.masksToBounds = true;
		
        uservm.getUserInfo {[weak self] in
            
            self?.headImgView.jq_setImage(imageUrl: self?.uservm.infoModel?.picture ?? "", placeholder: "icon_defaultHeadIcon", isShowIndicator: false, isNeedForceRefresh: false)
            
            if self?.uservm.infoModel?.aoLanYaAdmin == "1" {
                self?.AreaBgCheckView.isHidden = false
            }else {
                 self?.AreaBgCheckView.isHidden = true
            }
            //self?.nameLab.text = self?.uservm.infoModel?.name ?? DDUDManager.share.getUserID()
			self?.requestAgentData()
        }
    }
	
	// 获取所有订单信息
	func getAllOrder() {
		
		ordervm.allOrderLister {[weak self] in
			
			 //ordervm.orderListArr
			var buyMoney = 0.0 as Float
			self?.ordervm.orderListArr.forEach({ (model) in
				
				if model.orderState != "0" {
					buyMoney += Float(model.orderPrice!)!
//					model.orderInfo?.forEach({ (orderInfoModel) in
//
//						buyMoney = Float(orderInfoModel.price!)! * Float(orderInfoModel.shoppingNumber!)! + buyMoney
//
//					})
					
				}
				
			})
			self?.buyMoneyLab.text = "\(buyMoney)"
		}
	}
	
	func getAgentOrder() {
		let uid = DDUDManager.share.getUserID()
		agentVm.getSubordinateShoppingData(uid: uid) {[weak self] in
			var sellMoney = 0.0 as Float
			self?.agentVm.subordinateShoppingArray.forEach({ (model) in
				
				model.shoppingHistoryData.forEach({ (item) in
					// 循环遍历 这里面的字段  价格*数量 === 等有数据了一起加上来
					let dic = JSON.init(item)
					let money = dic["paymentMoney"].floatValue
					sellMoney += money
				})
				
			})
			self?.sellMoneyLab.text = "\(sellMoney)"
			self?.profitLab.text = String(format: "%.2f",sellMoney * 0.05)
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
		
		var ary = [AgentInfoDataModel]()
		self.agentVm.toBeAuditedArray.forEach { (model) in
			if model.toExamineone == "1" {
				ary.append(model)
			}
		}
		vc.toBeAuditedArray = ary
		
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
		var ary = [AgentInfoDataModel]()
		self.agentVm.toBeAuditedArray.forEach { (model) in
			if model.toExamineone != "1" {
				ary.append(model)
			}
		}
		vc.toBeAuditedArray = ary    //self.agentVm.toBeAuditedArray
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

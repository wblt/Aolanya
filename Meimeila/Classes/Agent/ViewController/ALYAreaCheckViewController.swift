//
//  ALYAreaCheckViewController.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAreaCheckViewController: DDBaseViewController {
	
	var toBeAuditedArray = [AgentInfoDataModel]()
	
	@IBOutlet weak var tableView: UITableView!
	
	lazy var agentVm:AgentManagerViewModel  = {
		let vm = AgentManagerViewModel.init();
		return vm;
	}()
	
	//iOS8用到XIB必须写这两个方法
	init() {
		super.init(nibName: String.init(describing: ALYAreaCheckViewController.self), bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.navigationItem.title = "区域审核"
		bindMJRefresh()
    }

	override func setupUI() {
		self.tableView.delegate = self;
		self.tableView.dataSource = self;
		self.tableView.rowHeight = 105;
		self.tableView.tableFooterView = UIView.init();
		self.tableView.backgroundColor = DDGlobalBGColor();
		self.tableView.showsVerticalScrollIndicator = false;
		self.tableView.separatorColor = UIColor.clear;
		self.tableView.register(UINib.init(nibName: String.init(describing: ALYAgentCardTabCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: ALYAgentCardTabCell.self));
	}
	
	func requestData()  {
		let uid = DDUDManager.share.getUserID()
		agentVm.getAgentManagerData(uid: uid) {[weak self] in
			self?.tableView.mj_header.endRefreshing()
//			self?.tableView.mj_footer.endRefreshing()
			var ary = [AgentInfoDataModel]()
			self?.agentVm.toBeAuditedArray.forEach { (model) in
				if model.toExamineone != "1" {
					ary.append(model)
				}
			}
			
			self?.toBeAuditedArray = ary
			self?.tableView.reloadData()
		};
	}
	
	///MJ
	func bindMJRefresh() {
		setupRefresh(tableView, isNeedFooterRefresh: false, headerCallback: {[weak self] in
			 self?.requestData()
		}) {[weak self] in
			
			
		}
	}
	
	
	
	@objc func confuseBtnAction(btn:UIButton)  {
		
		let index = btn.tag-10000;
		let model:AgentInfoDataModel = self.toBeAuditedArray[index]
		let uid = DDUDManager.share.getUserID()
		
		agentVm.confuseAgent(uid: uid, targetUid: model.uid, remarks: "", apply: "false", toExamineoneUid: uid) {
			self.toBeAuditedArray.removeAll();
			self.tableView.reloadData()
			self.requestData();
		}
		
	}
	
	@objc func agreenBtnAction(btn:UIButton)  {
		
		let index = btn.tag-20000;
		
		let model:AgentInfoDataModel = self.toBeAuditedArray[index]
		let uid = DDUDManager.share.getUserID()
		
		BFunction.shared.showAlert(title: "温馨提示", subTitle: "您确定此用户的资料是否填写正确吗?", ontherBtnTitle: "是,选择代理等级") {
			// 弹框选择 等级
			let pc = HCBottomPopupViewController()
			let act1 =  HCBottomPopupAction.init(title: "零售", withSelectedBlock: {
				
				self.dismiss(animated: true, completion: {
				
					self.agentVm.agreenRegion(uid: uid, targetUid: model.uid, apply: "true", agentLevel: "1", level: "1", inviter: uid, regionLevel: model.temporaryRegionLevel) {
						self.toBeAuditedArray.removeAll();
						self.tableView.reloadData()
						self.requestData();
					}
				})
				
			}, with: HCBottomPopupActionSelectItemType.default)
			
			let act2 =  HCBottomPopupAction.init(title: "金牌会员", withSelectedBlock: {
				
				self.dismiss(animated: true, completion: {
					
					self.agentVm.agreenRegion(uid: uid, targetUid: model.uid, apply: "true", agentLevel: "2", level: "2", inviter: uid, regionLevel: model.temporaryRegionLevel) {
						self.toBeAuditedArray.removeAll();
						self.tableView.reloadData()
						self.requestData();
					}
					
				})
				
				
			}, with: HCBottomPopupActionSelectItemType.default)
			let act3 =  HCBottomPopupAction.init(title: "大区", withSelectedBlock: {
				self.dismiss(animated: true, completion: {
					
					self.agentVm.agreenRegion(uid: uid, targetUid: model.uid, apply: "true", agentLevel: "3", level: "3", inviter: uid, regionLevel: model.temporaryRegionLevel) {
						self.toBeAuditedArray.removeAll();
						self.tableView.reloadData()
						self.requestData();
					}
					
				})
				
			}, with: HCBottomPopupActionSelectItemType.default)
			let act4 =  HCBottomPopupAction.init(title: "联合股东", withSelectedBlock: {
				self.dismiss(animated: true, completion: {
					self.agentVm.agreenRegion(uid: uid, targetUid: model.uid, apply: "true", agentLevel: "4", level: "4", inviter: uid, regionLevel: model.temporaryRegionLevel) {
						self.toBeAuditedArray.removeAll();
						self.tableView.reloadData()
						self.requestData();
					}
				})
				
			}, with: HCBottomPopupActionSelectItemType.default)
			let act5 =  HCBottomPopupAction.init(title: "联合创始人", withSelectedBlock: {
				self.dismiss(animated: true, completion: {
					self.agentVm.agreenRegion(uid: uid, targetUid: model.uid, apply: "true", agentLevel: "5", level: "5", inviter: uid, regionLevel: model.temporaryRegionLevel) {
						self.toBeAuditedArray.removeAll();
						self.tableView.reloadData()
						self.requestData();
					}
				})
				
			}, with: HCBottomPopupActionSelectItemType.default)
			
			let act6 = HCBottomPopupAction.init(title: "取消", withSelectedBlock: {
				self.dismiss(animated: true, completion: {
					
				})
				
			}, with: HCBottomPopupActionSelectItemType.cancel)
			
			pc.add(act1)
			pc.add(act2)
			pc.add(act3)
			pc.add(act4)
			pc.add(act5)
			pc.add(act6)
			
			self.present(pc, animated: true, completion: nil);
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

extension ALYAreaCheckViewController:UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
	}
	
}

extension ALYAreaCheckViewController:UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return self.toBeAuditedArray.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 195
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var cell:ALYAgentCardTabCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ALYAgentCardTabCell.self)) as? ALYAgentCardTabCell;
		cell?.separatorInset.left = 0;
		cell?.selectionStyle = .none;
		cell?.backgroundColor =  UIColor.RGB(r: 245, g: 245, b: 245)
		if let _ = cell {
			
		}else{
			
			cell = Bundle.main.loadNibNamed(String.init(describing: ALYAgentCardTabCell.self), owner: nil, options: nil)?.last as? ALYAgentCardTabCell;
		}
		cell?.data1 = self.toBeAuditedArray[indexPath.section]
		
		return cell!;
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let bgView = UIView()
		bgView.frame = CGRect.init(x: 0, y: 0, width: self.view.width, height: 50)
		bgView.backgroundColor = UIColor.clear
		
		let confuseBtn = UIButton()
		confuseBtn.frame = CGRect.init(x: 20, y: 5, width: (self.view.width-60)/2, height: 40)
		confuseBtn.setTitle("拒绝", for: UIControlState.normal)
		confuseBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
		confuseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		confuseBtn.backgroundColor = DDGlobalNavBarColor();
		confuseBtn.setCornerBorderWithCornerRadii(20, width: 0.1, color: UIColor.clear)
		confuseBtn.tag = 10000 + section
		confuseBtn.addTarget(self, action: #selector(confuseBtnAction(btn:)) , for: UIControlEvents.touchUpInside)
		
		let agreenBtn = UIButton()
		agreenBtn.frame = CGRect.init(x: self.view.width/2+10, y: 5, width: (self.view.width-60)/2, height: 40)
		agreenBtn.setTitle("同意", for: UIControlState.normal)
		agreenBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
		agreenBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		agreenBtn.backgroundColor = DDGlobalNavBarColor();
		agreenBtn.tag = 20000 + section
		agreenBtn.setCornerBorderWithCornerRadii(20, width: 0.1, color: UIColor.clear)
		agreenBtn.addTarget(self, action: #selector(agreenBtnAction(btn:)) , for: UIControlEvents.touchUpInside)
		
		bgView.addSubview(confuseBtn)
		bgView.addSubview(agreenBtn)
		
		
		return bgView
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 50
	}
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
	
}

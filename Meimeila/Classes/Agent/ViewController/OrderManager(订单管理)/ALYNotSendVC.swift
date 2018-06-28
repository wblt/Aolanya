//
//  ALYNotSendVC.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/17.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class ALYNotSendVC: DDBaseViewController {
	@IBOutlet weak var tableView: UITableView!
	var lowerId:String!
	
	var subShoopingModel:SubordinateShoopingModel!
	
	var shoppingDataAry = [[ShopOrderInfoModel]]()
	
	lazy var agentVm:AgentManagerViewModel  = {
		let vm = AgentManagerViewModel.init();
		return vm;
	}()
	
	init() {
		super.init(nibName: String.init(describing:String.init(describing: ALYNotSendVC.self)), bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setTableView()
		requestOrderData()
    }

	func requestOrderData()  {
		
		let uid = DDUDManager.share.getUserID()
		self.shoppingDataAry.removeAll()
		agentVm.getSubordinateShoppingData(uid: uid) {
			
			self.agentVm.subordinateShoppingArray.forEach({ (model) in
				if model.uid == self.lowerId {
					self.subShoopingModel = model
					
					let shopinfo = JSON.init(self.subShoopingModel.shoppingHistoryData).arrayValue
					
					//var sub = subShoopingModel
					for (item) in shopinfo {
						if item["orderState"].stringValue == "1" {
							let shoppingData = JSON.init(item["shoppingData"]).arrayValue
							var ary = [ShopOrderInfoModel]()
							shoppingData.forEach({ (json) in
								let shopInfoModel = ShopOrderInfoModel.init(fromJson: json)
								shopInfoModel.shoppingTime = item["shoppingTime"].stringValue
								shopInfoModel.orderNumber = item["orderNumber"].stringValue
								shopInfoModel.uid = model.uid
								ary.append(shopInfoModel)
							})
							self.shoppingDataAry.append(ary)
						}
					}
					
					self.tableView.reloadData()
				}
			})
		}
		
		
		
	}
	func setTableView(){
		tableView.delegate = self ;
		tableView.dataSource = self;
		tableView.rowHeight = 105;
		tableView.tableFooterView = UIView.init();
		tableView.backgroundColor = DDGlobalBGColor()
		tableView.showsVerticalScrollIndicator = false;
		tableView.register(UINib.init(nibName: String.init(describing: MineCollectCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MineCollectCell.self));
		
	}
	
	//立即付款
	@objc func rightBtAction(_ bt:UIButton) {
		
		let model = shoppingDataAry[bt.tag - 1000][0];
		
		let vc = MMLOrderDetailVC()
		
		vc.shopModel = ShopOrderModel.init(fromJson: "");
		vc.shopModel.orderID = model.orderNumber;
		vc.shopModel.orderState = "0"
		vc.lowerId = model.uid
		self.navigationController?.pushViewController(vc, animated: true);
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


extension ALYNotSendVC:UITableViewDelegate{
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let model = self.shoppingDataAry[indexPath.section][0];
		
		let vc = MMLOrderDetailVC()
		
		vc.shopModel = ShopOrderModel.init(fromJson: "");
		vc.shopModel.orderID = model.orderNumber;
		vc.shopModel.orderState = "0"
		vc.lowerId = model.uid
		self.navigationController?.pushViewController(vc, animated: true);
	}
}

extension ALYNotSendVC:UITableViewDataSource{
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var cell:MineCollectCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MineCollectCell.self)) as? MineCollectCell;
		cell?.separatorInset.left = 0;
		cell?.selectionStyle = .none;
		if let _ = cell {
			
		}else{
			
			cell = Bundle.main.loadNibNamed(String.init(describing: MineCollectCell.self), owner: nil, options: nil)?.last as? MineCollectCell;
		}
		
		cell?.setOrderInfoData2 =  shoppingDataAry[indexPath.section][indexPath.row];
		
		return cell!;
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return shoppingDataAry[section].count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		tableView.displayprompts(message: "暂无订单", image: "icon_orderEmpty", cellCount: subShoopingModel.shoppingHistoryData.count);
		
		if let _ = tableView.mj_footer {
			
			tableView.mj_footer.isHidden = subShoopingModel.shoppingHistoryData.isEmpty;
		}
		return shoppingDataAry.count;
	}
	
	
	
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let model = self.shoppingDataAry[section][0]
		
		let view = SectionHeadView.init(frame: CGRect.zero);
		
		view.titleLabel.text = "未发货"
		view.timeLabel.text = model.shoppingTime?.replacingOccurrences(of: ".0", with: "")
		return view
	}
	
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		return 44 + 10;
	}
	
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		
		let shopping = JSON.init(subShoopingModel.shoppingHistoryData[section])
		
		let view:SecctionFootView = SecctionFootView.init(frame: CGRect.zero);
		
		view.btLeft.isHidden = true
		view.modifyMessageBt.isHidden = true
		
		view.btRight.setTitle("立即发货", for: .normal)
		view.btRight.setTitleColor(DDGlobalNavBarColor(), for: .normal);
		view.btRight.layer.borderColor = DDGlobalNavBarColor().cgColor;
		
		view.btRight.tag = section + 1000;
		view.btRight.addTarget(self, action: #selector(rightBtAction(_:)), for: .touchUpInside);
		
		
		let price = shopping["paymentMoney"].stringValue;
		//        let num = model.orderInfoNumber ?? "1";
		//        let post = model.postage ?? "0"
		//        let text = "共\(num)件商品 合计:￥\(price!)(含运费￥:\(post))"
		let num = shopping["shoppingData"].arrayValue.count
		
		let text = "共\(num)件商品 合计:￥\(price)"
		
		view.titleLabel.text = text;
		
		return view;
		
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		
		return 44 + 50;
	}
	
}


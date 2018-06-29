//
//  MMLOrderDetailVC.swift
//  Meimeila
//
//  Created by macos on 2017/11/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLOrderDetailVC: DDBaseViewController {

	// 下级的id ,如果存在这个id  就代表是在订单管理里面
	var lowerId:String!
	
	// 交易单号
	var numTextField:UITextField!
	
	//快递单号
	var kuaiDiTextField:UITextField!
	//
	var kuaiDiNameTextField:UITextField!
	
	
    @IBOutlet weak var tableView: UITableView!
    lazy var vm:MSXMineOrderListVM = {[weak self] in
        let vm = MSXMineOrderListVM()
       // vm.tableView = self?.tableView;
        return vm;
        }()
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLOrderDetailVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "订单详情"
        // Do any additional setup after loading the view.
		
		refreshData()
    }
	
	func refreshData()  {
		// 为了避免切换uid 代码不好动  这里先设置一下 本地uid 为下级id ，请求后立马切换回来
		let uid = DDUDManager.share.getUserID()
		
		if self.lowerId != nil {
			DDUDManager.share.saveUserID(uid: self.lowerId);
		}
		
		vm.orderDetailLister(orderID: shopModel.orderID!, orderState: Int(shopModel.orderState!)!, succeeds: {
			self.shopModel =  self.vm.orderListArr[0]
			
			if self.lowerId != nil {
				if self.shopModel.orderState == "0" {
					self.headView.titleLabel.text = "未确认收款";
					
				}else if self.shopModel.orderState == "1" {
					self.headView.titleLabel.text = "未发货";
				}else if self.shopModel.orderState == "2" {
					self.headView.titleLabel.text = "下级未收货";
				}else if self.shopModel.orderState == "3" {
					self.headView.titleLabel.text = "待评价";
				}else if self.shopModel.orderState == "4" {
					self.headView.titleLabel.text = "交易完成";
				}
				
				self.headView.timeLabel.text = ""
			}else {
				self.headView.setModel = self.shopModel;
			}
			
			
			self.tableView.reloadData()
		})
		
		DDUDManager.share.saveUserID(uid: uid);
	}
    
    override func setupUI() {
     
        setTableView();
    }
    
    lazy var headView:MMLOrderDetailHeadView = {[weak self] in
        
        let view = MMLOrderDetailHeadView.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: 64));
       // view.setModel = self?.shopModel;
        return view;
    }()
    
    var shopModel:ShopOrderModel!
}

extension MMLOrderDetailVC{
    
    ///唤起QQ聊天qq:1360135069
    func didClickQQButton() {
        let webView = UIWebView(frame: self.view.bounds)
        let url1 = URL(string: "mqq://im/chat?chat_type=wpa&uin=1360135069&version=1&src_type=web")
        let request = NSURLRequest(url: url1!)
        webView.loadRequest(request as URLRequest)
        view.addSubview(webView)
    }

    func setTableView(){
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableHeaderView = headView;
        tableView.tableFooterView = UIView.init();
        tableView.backgroundColor = DDGlobalBGColor();
        tableView.showsVerticalScrollIndicator = false;
       
        tableView.register(UINib.init(nibName: String.init(describing: MineCollectCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MineCollectCell.self));
    
        tableView.register(UINib.init(nibName: String.init(describing: MMLOrderDetailSectionZeroCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLOrderDetailSectionZeroCell.self));
        
        tableView.register(UINib.init(nibName: String.init(describing: MMLOrderDetailSectionTwoCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLOrderDetailSectionTwoCell.self));
        
        tableView.register(UINib.init(nibName: String.init(describing: MMLOrderDetailSectionThreeCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLOrderDetailSectionThreeCell.self));
        
		tableView.register(UINib.init(nibName: String.init(describing: ALYSureMoneyCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: ALYSureMoneyCell.self));
		
		tableView.register(UINib.init(nibName: String.init(describing: ALYExpressCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: ALYExpressCell.self));
		
    
    }
	
	// 查看付款截图
	@objc func lookImgAction() {
		
		if self.shopModel.paymentImg?.count > 0  {
			 MMLPhotoViewer.shared.viewImages(vc: self, images: [self.shopModel.paymentImg!], currentIndex: 0)
		}
		
	}
	// 确认已付款
	@objc func sureMoneyAction() {
		if numTextField.text?.count == 0 {
			BFunction.shared.showToastMessge("请输入交易单号")
			return
		}
		
		
		BFunction.shared.showAlert(title: "温馨提示", subTitle: "您确定您的微信/支付宝已收到此款项？", ontherBtnTitle: "确定") {
			//确认已付款
			if self.shopModel.paymentNumber != self.numTextField.text{
				BFunction.shared.showToastMessge("交易流水号不正确")
				return
			}
			
			let uid = DDUDManager.share.getUserID()
			let subordinateUid = self.lowerId
			self.vm.submitPaymentState(uid: uid, subordinateUid: subordinateUid!, orderId: self.shopModel.orderID!, paymentState: "true", succeeds: {
				self.shopModel.orderState = "1"
				self.refreshData()
			})
			
		}
	}
	
	// 扫描快递单号
	@objc func saoyisaoAction() {
		AVCaptureSessionManager.checkAuthorizationStatusForCamera(grant: {
			// 调用二维码扫描
			let vc = ALYScanViewController()
			vc.getBlock(block: { (r) in
				self.kuaiDiTextField.text = r;
			})
			
			self.navigationController?.pushViewController(vc, animated: true)
			
		}){
			let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
				let url = URL(string: UIApplicationOpenSettingsURLString)
				UIApplication.shared.openURL(url!)
			})
			let con = UIAlertController(title: "权限未开启", message: "您未开启相机权限，点击确定跳转至系统设置开启", preferredStyle: UIAlertControllerStyle.alert)
			con.addAction(action)
			self.present(con, animated: true, completion: nil)
		}
		
		
	}
	
	// 确认已发货
	@objc func sureSendAction() {
		if kuaiDiTextField.text?.count == 0 || kuaiDiNameTextField.text?.count ==  0 {
			BFunction.shared.showToastMessge("请输入快递信息")
			return
		}
		
		// 确认发货
		let uid = DDUDManager.share.getUserID()
		let subordinateUid = self.lowerId
		
		self.vm.submitDeliverGoods(uid: uid, subordinateUid: subordinateUid!, orderId: self.shopModel.orderID!, expressNum: kuaiDiTextField.text!, expressName: kuaiDiNameTextField.text!) {
			
			BFunction.shared.showToastMessge("提交成功")
			self.navigationController?.popViewController(animated: true)
		}
		
	}
	
}

extension MMLOrderDetailVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
}

extension MMLOrderDetailVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
        
            var cell:MMLOrderDetailSectionZeroCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLOrderDetailSectionZeroCell.self)) as? MMLOrderDetailSectionZeroCell;
            cell?.separatorInset.left = 0;
            cell?.selectionStyle = .none;
            if let _ = cell {
                
            }else{
                
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLOrderDetailSectionZeroCell.self), owner: nil, options: nil)?.last as? MMLOrderDetailSectionZeroCell;
            }
            cell?.setModel = shopModel;
            return cell!;
       
        }else if indexPath.section == 1 {
            
            var cell:MineCollectCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MineCollectCell.self)) as? MineCollectCell;
			
            if let _ = cell {
                
            }else{
                
                cell = Bundle.main.loadNibNamed(String.init(describing: MineCollectCell.self), owner: nil, options: nil)?.last as? MineCollectCell;
            }
			cell?.separatorInset.left = 0;
			cell?.selectionStyle = .none;
            if shopModel.orderInfo?.count > 0{
                cell?.setOrderInfoData = shopModel.orderInfo![indexPath.row];
            }
            return cell!;
            
        }else if indexPath.section == 2 {
            
            var cell:MMLOrderDetailSectionTwoCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MineCollectCell.self)) as? MMLOrderDetailSectionTwoCell;
            cell?.separatorInset.left = 0;
            cell?.selectionStyle = .none;
            if let _ = cell {
                
            }else{
                
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLOrderDetailSectionTwoCell.self), owner: nil, options: nil)?.last as? MMLOrderDetailSectionTwoCell;
            }
            cell?.setModel = shopModel;
            return cell!;
            
		}else if indexPath.section == 4 {
			
			if self.shopModel.orderState == "0" {
				var cell:ALYSureMoneyCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MineCollectCell.self)) as? ALYSureMoneyCell;
				
				if let _ = cell {
					
				}else{
					
					cell = Bundle.main.loadNibNamed(String.init(describing: ALYSureMoneyCell.self), owner: nil, options: nil)?.last as? ALYSureMoneyCell;
				}
				cell?.separatorInset.left = 0;
				cell?.selectionStyle = .none;
				
				cell?.lookImgBtn.layer.cornerRadius = 10;
				cell?.lookImgBtn.layer.masksToBounds = true
				
				cell?.sureMoneyBtn.layer.cornerRadius = 10;
				cell?.sureMoneyBtn.layer.masksToBounds = true
				
				cell?.lookImgBtn.addTarget(self, action: #selector(lookImgAction), for: .touchUpInside); // 查看付款截图
				cell?.sureMoneyBtn.addTarget(self, action: #selector(sureMoneyAction), for: .touchUpInside); // 确认已收款
				self.numTextField = cell?.numTextField
				return cell!;
			}else  {
				var cell:ALYExpressCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MineCollectCell.self)) as? ALYExpressCell;
				
				if let _ = cell {
					
				}else{
					
					cell = Bundle.main.loadNibNamed(String.init(describing: ALYExpressCell.self), owner: nil, options: nil)?.last as? ALYExpressCell;
				}
				cell?.separatorInset.left = 0;
				cell?.selectionStyle = .none;
				cell?.sendBtn.addTarget(self, action: #selector(sureSendAction), for: .touchUpInside);
				cell?.saoyisaoBtn.addTarget(self, action: #selector(saoyisaoAction), for: .touchUpInside);
				
				self.kuaiDiTextField = cell?.kuaidiNumTextField
				self.kuaiDiNameTextField = cell?.kuaidiNameTextField
				
				cell?.saoyisaoBtn.layer.cornerRadius = 10;
				cell?.saoyisaoBtn.layer.masksToBounds = true
				
				cell?.sendBtn.layer.cornerRadius = 10;
				cell?.sendBtn.layer.masksToBounds = true
				
				return cell!;
			}
			
		}else{
            var cell:MMLOrderDetailSectionThreeCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLOrderDetailSectionThreeCell.self)) as? MMLOrderDetailSectionThreeCell;
            cell?.separatorInset.left = 0;
            cell?.selectionStyle = .none;
            if let _ = cell {
                
            }else{
                
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLOrderDetailSectionThreeCell.self), owner: nil, options: nil)?.last as? MMLOrderDetailSectionThreeCell;
            }
            cell?.delegate = self;
            cell?.setModel = shopModel;
            return cell!;
            
        }
		
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            
            return shopModel.orderInfo?.count ?? 0;
        }
        
        return 1;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
		
		if self.lowerId != nil && (self.shopModel.orderState == "0" || self.shopModel.orderState == "1") {
			return 5;
		}
		
        return 4;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 105;
        }else if indexPath.section == 1{
            return 105;
        }else if indexPath.section == 2{
            return 125;
        }else if indexPath.section == 3{
            return 215;
        }else if indexPath.section == 4{
			return 150;
		}else{
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 4 {
            
            return 0.01;
        }
        
        return 14.99;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray;
        return view;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = DDGlobalBGColor();
        return view;
    }
}

extension MMLOrderDetailVC:MMLOrderDetailSectionThreeCellDelegate{
    func contactService() {
//        didClickQQButton();
        
        let vc = MMLContactServiceVC();
        vc.title = "联系客服";
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    
    
}

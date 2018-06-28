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
		
		// 为了避免切换uid 代码不好动  这里先设置一下 本地uid 为下级id ，请求后立马切换回来
		let uid = DDUDManager.share.getUserID()
		
		if self.lowerId.count > 0 {
			DDUDManager.share.saveUserID(uid: self.lowerId);
		}
		
        vm.orderDetailLister(orderID: shopModel.orderID!, orderState: Int(shopModel.orderState!)!, succeeds: {
            self.shopModel =  self.vm.orderListArr[0]

			if self.shopModel.orderState == "0" {
				self.headView.titleLabel.text = "未确认收款";
				
			}else if self.shopModel.orderState == "1" {
				self.headView.titleLabel.text = "未发货";
			}
			self.headView.timeLabel.text = ""
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
            cell?.separatorInset.left = 0;
            cell?.selectionStyle = .none;
            if let _ = cell {
                
            }else{
                
                cell = Bundle.main.loadNibNamed(String.init(describing: MineCollectCell.self), owner: nil, options: nil)?.last as? MineCollectCell;
            }
            
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
        }else{
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 3 {
            
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

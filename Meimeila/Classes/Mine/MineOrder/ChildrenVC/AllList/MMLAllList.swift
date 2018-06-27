//
//  MMLAllList.swift
//  Meimeila
//
//  Created by macos on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLAllList: DDBaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLAllList.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    
    lazy var vm:MSXMineOrderListVM = {[weak self] in
        let vm = MSXMineOrderListVM()
        return vm;
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI();
        bindMJRefresh();
        vm.tableView = self.tableView;
        requestDataList();
    }
    
    ///MJ
    func bindMJRefresh() {
        setupRefresh(tableView, isNeedFooterRefresh: false, headerCallback: {[weak self] in
            
            self?.vm.numberPage = 0;
            self?.requestDataList();
        }) {[weak self] in
            
            self?.vm.numberPage += 15;
            self?.requestDataList();
        }
    }
    
    
    //
    func requestDataList(){
        
        vm.allOrderLister {[weak self] in
            self?.tableView.reloadData();
        }
        
    }
    
    func setUI() {
        
        setTableView();
    }
    
    
   func setTableView(){
    
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 105;
        self.tableView.tableFooterView = UIView.init();
        self.tableView.backgroundColor = DDGlobalBGColor();
        self.tableView.showsVerticalScrollIndicator = false;
        self.tableView.register(UINib.init(nibName: String.init(describing: MineCollectCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MineCollectCell.self));
    }
    /*
	public final static String WAITING_PAYMENT="0";//等待付款
	public final static String PAID="1";//已付款
	public final static String GOODS_RECEIVED="2";//已付款,待收货
	public final static String PENDING_EVALUATION="3";//确认收货,待评价customer_service
	public final static String SUCCESSFUL_TRADE="4";//已评价,交易成功
	*/
	
    //查看全部订单-> 0是待付款 1已付款  2是待收货 3  4是待评价
    
    //订单详情-删除订单  0为待付款，1是已付款，2是交易成功，3是待收货 4待评价
    
    //全部订单左
    @objc func leftBtAction(_ bt:UIButton) {
        let nav = self.parent?.navigationController;
        
        let model = vm.orderListArr[bt.tag - 1000];
        if let state = model.orderState {
            let type = Int(state);
            print(type ?? 999)
            if type == 0{       //待付款-   修改收货地址
                
//                vm.deleteOrderLister(ordetID: model.orderID!, orderState: "0", succeeds: {[weak self] in
//
//                    self?.requestDataList();
//                })

                let vc = MMLMineAddressVC();
                vc.shopModel = model;
                nav?.pushViewController(vc, animated: true);
                
            }else if type == 1{ // 已付款
                
//                let vc = ApplyForAfterSellVC();
//                vc.model = model;
//                navigationController?.pushViewController(vc, animated: true);
				let vc = MMLProductDetailsVC()
                let mod = model.orderInfo![0] as! ShopOrderInfoModel
                vc.shoppingID = mod.shopingID;
				nav?.pushViewController(vc, animated: true)
				
            }else if type == 2{ //交易成功-删除订单
                
//                vm.deleteOrderLister(ordetID: model.orderID!, orderState: "2", succeeds: {[weak self] in
//
//                    self?.requestDataList();
//                })
                // 查看物流
                let vc = CheckLogisticsVC()
                vc.model = model;
                nav?.pushViewController(vc, animated: true);
                
            }else if type == 3{ //待收货-查看物流
                
                let vc = CheckLogisticsVC()
                vc.model = model;
                nav?.pushViewController(vc, animated: true);
                
            }else if type == 4{ //待评价-查看物流
                
//                let vc = CheckLogisticsVC()
//                vc.model = model;
//                nav?.pushViewController(vc, animated: true);
				let vc = DDBaseWebViewVC()
				vc.loadUrlString("https://m.kuaidi100.com:443", title: "查询物流")
				nav?.pushViewController(vc, animated: true);
            }else if type == 5{ //退款申请
                
                //MARK:修改
                let vc = CheckLogisticsVC()
                vc.model = model;
                nav?.pushViewController(vc, animated: true);
                
            }else if type == 6{ //退款成功-查看订单
                
                let vc = CheckLogisticsVC()
                vc.model = model;
                nav?.pushViewController(vc, animated: true);
                
            }
			
        }
        
    }
    
    //全部订单右  //0是待付款 1是已付款 2待收货 3是待评价 4是交易成功
    @objc func rightBtAction(_ bt:UIButton) {
        
        let nav = self.parent?.navigationController;
        
        let orderModel = vm.orderListArr[bt.tag - 1000];
        //        let infoModel = orderModel.orderInfo;
        
        if let state = orderModel.orderState {
            let type = Int(state);
            print(type ?? 999)
            if type == 0{       //待付款-立即付款
				
				if orderModel.orderType == "3" || orderModel.orderType == "4" {
					// 等待审核
					
				}else {
					let nav = self.parent?.navigationController;
					let orderModel = vm.orderListArr[bt.tag - 1000];
					let vc = PayImmediatelyVC()
					vc.shopOrderModel = orderModel;
					nav?.pushViewController(vc, animated: true);
				}
				
            }else if type == 1{ //待发货-修改信息 （地址）wy
                // http://yg.welcare-tech.com.cn/tpiot/app/updateOrder
//				uid	55
//				orderID	041815415256909
//				sign	B57AC53F5FDFDB266E3DFE084ACC586E
//				adressID	1
//				token	0
//				orderState	1
//				timestamp	1524038313
				
				
//                vm.verifyTakeGoods(orderID: orderModel.orderID ?? "0", succeeds: {[weak self] in
//
//                    self?.requestDataList();
//                })
				
				let vc = MMLMineAddressVC();
				vc.shopModel = orderModel;
				nav?.pushViewController(vc, animated: true);
				
            }else if type == 2{ //交易成功-查看订单
                
//                let model = orderModel;
//
//                let vc = MMLOrderDetailVC()
//                vc.shopModel = model;
//                self.navigationController?.pushViewController(vc, animated: true);
                BFunction.shared.showAlert(title: "温馨提示", subTitle: "确认收货?", ontherBtnTitle: "确认", ontherBtnAction: {
                    self.vm.verifyTakeGoods(orderID: orderModel.orderID ?? "0", succeeds: {[weak self] in
                        
                        self?.requestDataList();
                    })
                })
            }else if type == 3{ // 去评价
                let vc = MakeCommentVC()
                vc.shopModel = orderModel;
                nav?.pushViewController(vc, animated: true);
                
//                vm.verifyTakeGoods(orderID: orderModel.orderID ?? "0", succeeds: {[weak self] in
//
//                    self?.requestDataList();
//                })
                
            }else if type == 4{ //再次购买
                print("4")
                let vc = MMLProductDetailsVC()
                let mod = orderModel.orderInfo![0]
                vc.shoppingID = mod.shopingID;
                nav?.pushViewController(vc, animated: true)
              
            }else if type == 5{ //退款申请
                //MARK:修改

                let vc = MMLOrderDetailVC()
                vc.shopModel = orderModel;
                self.navigationController?.pushViewController(vc, animated: true);
                
                
            }else if type == 6{ //退款成功-查看订单
                
//                let vc = MSXOrderDetailVC();
//                vc.model = orderModel;
//                nav?.pushViewController(vc, animated: true);
                
            }
            
            
        }
        
    }
    
    
    @objc func modifyBtAction(bt:UIButton){
        
        let nav = self.parent?.navigationController;

        let tab = self.parent?.tabBarController;
        
        let orderModel = vm.orderListArr[bt.tag - 1000];
        //        let infoModel = orderModel.orderInfo;
        
        if let state = orderModel.orderState {
            let type = Int(state);
            
            if type == 0{//待付款-修改信息
                
                 print("0")
                 BFunction.shared.showAlert(title: "温馨提示", subTitle: "确认取消订单？", ontherBtnTitle: "确定") {
                    self.vm.deleteOrderLister(ordetID: orderModel.orderID!, orderState: "0", succeeds: {[weak self] in
                        
                        self?.requestDataList();
                    })
                }
                
            }else if type == 1{//待付款-修改信息
                print("1")

            }else if type == 2{ // 再次购买
                print("2")
                
                let vc = MMLProductDetailsVC()
                let mod = orderModel.orderInfo![0]
                vc.shoppingID = mod.shopingID;
                nav?.pushViewController(vc, animated: true)
                
            }else if type == 3{//待评价-再次购买
                print("3")
                let vc = MMLProductDetailsVC()
                let mod = orderModel.orderInfo![0]
                vc.shoppingID = mod.shopingID;
                nav?.pushViewController(vc, animated: true)
            }else if type == 4{//交易成功-再次购买
               print("4")
                let vc = MMLProductDetailsVC()
                let mod = orderModel.orderInfo![0]
                vc.shoppingID = mod.shopingID;
                nav?.pushViewController(vc, animated: true)
            }else if type == 5{
                
                print("5")

                
            }else if type == 6{
                print("6")
            }
        }
    }
    
    
 
    
}



extension MMLAllList:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row);
        
        let model = vm.orderListArr[indexPath.section];
        
        let vc = MMLOrderDetailVC()
        vc.shopModel = model;
    self.navigationController?.pushViewController(vc, animated: true);
    }
}

extension MMLAllList:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MineCollectCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MineCollectCell.self)) as? MineCollectCell;
        cell?.separatorInset.left = 0;
        cell?.selectionStyle = .none;
        if let _ = cell {
            
        }else{
            
            cell = Bundle.main.loadNibNamed(String.init(describing: MineCollectCell.self), owner: nil, options: nil)?.last as? MineCollectCell;
        }
        
        let sectionModel = vm.orderListArr[indexPath.section];
        
        cell?.setOrderInfoData = sectionModel.orderInfo![indexPath.row];
        
        return cell!;
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let model = vm.orderListArr[section]
        
        return (model.orderInfo?.count)!;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        tableView.displayprompts(message: "暂无订单", image: "icon_orderEmpty", cellCount: vm.orderListArr.count);
        
        if let _ = tableView.mj_footer {
            
            tableView.mj_footer.isHidden = vm.orderListArr.isEmpty;
        }
        
        return vm.orderListArr.count;
    }
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let model = vm.orderListArr[section];
        
        let view = SectionHeadView.init(frame: CGRect.zero);
        view.titleLabel.text = model.orderStateTitle;
        
        if !(model.orderTime?.isEmpty)!{
            view.timeLabel.text = model.orderTime!
				//timestampToDate(format: "yyyy-MM-dd HH:mm:ss", timestamp: model.orderTime!);
        }
        return view;
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44 + 10;
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let model = vm.orderListArr[section];
        
        
        let view:SecctionFootView = SecctionFootView.init(frame: CGRect.zero);
        view.btLeft.setTitle(model.leftBtTitle, for: .normal)
        view.btRight.setTitle(model.rightBtTitle, for: .normal)
        if let _ = model.modifyBtTitle {
            
            view.modifyMessageBt.setTitle(model.modifyBtTitle, for: UIControlState.normal);
            view.modifyMessageBt.tag = section + 1000;
            view.modifyMessageBt.isHidden = false;

        }else{
            
            view.modifyMessageBt.isHidden = true;
        }
        
        if let _ = model.leftBtTitle {
            
            view.btLeft.setTitle(model.leftBtTitle, for: UIControlState.normal);
            view.btLeft.tag = section + 1000;
            view.btLeft.isHidden = false;
            
        }else{
            
            view.btLeft.isHidden = true;
        }
		
		
		if model.orderType == "3" || model.orderType == "4" {
			view.btRight.setTitle("待审核", for: UIControlState.normal);
			view.btRight.setTitleColor(DDGlobalNavBarColor(), for: .normal);
			view.btRight.layer.borderColor = DDGlobalNavBarColor().cgColor;
		}else if model.orderType == "5"{
			view.btRight.setTitleColor(UIColor.lightGray, for: .normal);
			view.btRight.layer.borderColor =  UIColor.lightGray.cgColor;
		} else {
			view.btRight.setTitle(model.rightBtTitle, for: UIControlState.normal);
			view.btRight.setTitleColor(UIColor.lightGray, for: .normal);
			view.btRight.layer.borderColor =  UIColor.lightGray.cgColor;
		}

        view.btLeft.tag = section + 1000;
        view.btRight.tag = section + 1000;
        
        view.btLeft.addTarget(self, action: #selector(leftBtAction(_:)), for: .touchUpInside);
        
        view.btRight.addTarget(self, action: #selector(rightBtAction(_:)), for: .touchUpInside);
        
        view.modifyMessageBt.addTarget(self, action: #selector(modifyBtAction(bt:)), for: UIControlEvents.touchUpInside);
        
        let price = model.orderPrice ?? "0";
//        let num = model.orderInfoNumber ?? "0";
//        let post = model.postage ?? "0"
//        let text = "共\(num)件商品 合计:￥\(price)(含运费￥:\(post))"
		var totalNum = 0
		for infoModel:ShopOrderInfoModel in model.orderInfo! {
			totalNum = totalNum + Int(infoModel.shoppingNumber!)!
		}
		if totalNum == 0 {
			totalNum = 1
		}
		
		let text = "共\(totalNum)件商品 合计:￥\(price)"
        view.titleLabel.text = text;
        
        return view;
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 44 + 50;
    }
    
}


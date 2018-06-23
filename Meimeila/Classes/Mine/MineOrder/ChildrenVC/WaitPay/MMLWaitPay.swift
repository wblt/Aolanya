//
//  MMLWaitPay.swift
//  Meimeila
//
//  Created by macos on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLWaitPay: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
   
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLWaitPay.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var vm:MSXMineOrderListVM = {[weak self] in
        let vm = MSXMineOrderListVM()
        vm.tableView = self?.tableView;
        return vm;
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI();
        
        bindMJRefresh();
        requestDataList();
    }
    
    func setUI() {
        
        setTableView();
        
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
        
        vm.waitPayOrderLister {[weak self] in
            self?.tableView.reloadData();
        }
    }
    
    func setTableView(){
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 105;
        tableView.tableFooterView = UIView.init();
        tableView.backgroundColor = DDGlobalBGColor()
        tableView.showsVerticalScrollIndicator = false;
        tableView.register(UINib.init(nibName: String.init(describing: MineCollectCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MineCollectCell.self));
        
    }
    
    
    //查看全部订单-> 0是待付款 1已付款  2交易成功 3是待收货 4是待评价
    
    //订单详情-删除订单  0为待付款，1是已付款，2是交易成功，3是待收货 4待评价
    
    //独立->     0是待付款 1待发货  2待收货  4待评价 5正在申请退款 6已退款订单
    
    
    //修改信息
    @objc func leftBtAction(_ bt:UIButton) {
        print(bt.tag)

        let nav = self.parent?.navigationController;
        let orderModel = vm.orderListArr[bt.tag - 1000];
        let vc = MMLMineAddressVC();
        vc.shopModel = orderModel;
        nav?.pushViewController(vc, animated: true);
    }
    
    //立即付款
    @objc func rightBtAction(_ bt:UIButton) {
        print(bt.tag)
        
        let nav = self.parent?.navigationController;
        let orderModel = vm.orderListArr[bt.tag - 1000];
        let vc = PayImmediatelyVC()
        vc.shopOrderModel = orderModel;
        nav?.pushViewController(vc, animated: true);
        
        
    }
    
    
    // 取消订单
    @objc func modifyBtAction(bt:UIButton){
        
        BFunction.shared.showAlert(title: "温馨提示", subTitle: "确认取消订单？", ontherBtnTitle: "确定") {
            
            let model = self.vm.orderListArr[bt.tag - 1000];
            self.vm.deleteOrderLister(ordetID: model.orderID!, orderState: "0", succeeds: {[weak self] in
                
                self?.requestDataList();
            })
        }
        
        
        
    }
    
}



extension MMLWaitPay:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row);
        let model = vm.orderListArr[indexPath.section];
        
        let vc = MMLOrderDetailVC()
        vc.shopModel = model;
        self.navigationController?.pushViewController(vc, animated: true);
        
    }
}

extension MMLWaitPay:UITableViewDataSource{
    
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
        view.titleLabel.text = "待付款";
        view.timeLabel.text = model.orderTime!
            //timestampToDate(format: "yyyy-MM-dd HH:mm:ss", timestamp: model.orderTime!);
        return view;
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44 + 10;
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let model = vm.orderListArr[section];
        
        let view:SecctionFootView = SecctionFootView.init(frame: CGRect.zero);
//        view.btLeft.setTitle("取消订单", for: .normal)
//        view.btRight.setTitle("立即付款", for: .normal)
//        view.modifyMessageBt.setTitle("修改信息", for: UIControlState.normal);
        
        view.btLeft.setTitle("修改信息", for: .normal)
        view.btRight.setTitle("立即支付", for: .normal)
        view.modifyMessageBt.setTitle("取消订单", for: UIControlState.normal);
        
        
        view.btLeft.tag = section + 1000;
        view.btRight.tag = section + 1000;
        view.modifyMessageBt.tag = section + 1000;
        view.btLeft.addTarget(self, action: #selector(leftBtAction(_:)), for: .touchUpInside);
        
        view.btRight.addTarget(self, action: #selector(rightBtAction(_:)), for: .touchUpInside);
        
        view.modifyMessageBt.addTarget(self, action: #selector(modifyBtAction(bt:)), for: UIControlEvents.touchUpInside);

        
        let price = model.orderPrice;
//        let num = model.orderInfoNumber ?? "1";
//        let post = model.postage ?? "0"
//        let text = "共\(num)件商品 合计:￥\(price!)(含运费￥:\(post))"
		var totalNum = 0
		for infoModel:ShopOrderInfoModel in model.orderInfo! {
			totalNum = totalNum + Int(infoModel.shoppingNumber!)!
		}
		if totalNum == 0 {
			totalNum = 1
		}
		
		let text = "共\(totalNum)件商品 合计:￥\(price!)"
		
        view.titleLabel.text = text;
        
        return view;
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 44 + 50;
    }
    
}


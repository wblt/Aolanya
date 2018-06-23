//
//  MMLFinish.swift
//  Meimeila
//
//  Created by macos on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLFinish: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLFinish.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    
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
        
        vm.waitCommentOrderLister {[weak self] in
            self?.tableView.reloadData();
            
        }
    }
    
    func setTableView() {
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 105;
        tableView.tableFooterView = UIView.init();
        tableView.backgroundColor = UIColor.RGB(r: 241, g: 241, b: 241);
        tableView.showsVerticalScrollIndicator = false;
        tableView.register(UINib.init(nibName: String.init(describing: MineCollectCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MineCollectCell.self));
        
    }
    
    //  3就是 查看物流
    @objc func leftBtAction(_ bt:UIButton) {
        print(bt.tag)
        let model = vm.orderListArr[bt.tag - 1000];
        
        if model.orderState == "3" {
            let vc = CheckLogisticsVC();
            vc.model = model;
            let nav = parent?.navigationController;
            nav?.pushViewController(vc, animated: true);
        }else {
            
        }
        
    }
    
    // 3状态立即评价  4 交易完成
    @objc func rightBtAction(_ bt:UIButton) {
        print(bt.tag)
        let model = vm.orderListArr[bt.tag - 1000];
        
        if model.orderState == "3" {
            let vc = MakeCommentVC();
            vc.shopModel =  model
            navigationController?.pushViewController(vc, animated: true);
        }else if model.orderState == "4" {
            let vc = MMLProductDetailsVC()
            let mod = model.orderInfo![0]
            vc.shoppingID = mod.shopingID;
            let nav = self.parent?.navigationController;
            nav?.pushViewController(vc, animated: true)
        }
        
    }
    
    // 再次购买
    @objc func modifyBtAction(bt:UIButton){
        
        let model = self.vm.orderListArr[bt.tag - 1000];
        let vc = MMLProductDetailsVC()
        let mod = model.orderInfo![0]
        vc.shoppingID = mod.shopingID;
        let nav = self.parent?.navigationController;
        nav?.pushViewController(vc, animated: true)
    }
    
}



extension MMLFinish:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row);
        let model = vm.orderListArr[indexPath.section];
        
        let vc = MMLOrderDetailVC()
        vc.shopModel = model;
        self.navigationController?.pushViewController(vc, animated: true);
    }
}

extension MMLFinish:UITableViewDataSource{
    
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
        if model.orderState == "3" {
          view.titleLabel.text = "待评价"
        }else if  model.orderState == "4" {
            view.titleLabel.text = "交易完成"
        }
        
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
            view.btLeft.isHidden = false;
            
        }else{
            
            view.btLeft.isHidden = true;
        }
        
        
        
        view.btLeft.tag = section + 1000;
        view.btRight.tag = section + 1000;
        
        view.btLeft.addTarget(self, action: #selector(leftBtAction(_:)), for: .touchUpInside);
        
        view.btRight.addTarget(self, action: #selector(rightBtAction(_:)), for: .touchUpInside);
       
        view.modifyMessageBt.addTarget(self, action: #selector(modifyBtAction(bt:)), for: UIControlEvents.touchUpInside);

        
        let price = model.orderPrice;
//        let num = model.orderInfoNumber;
//
		var totalNum = 0
		for infoModel:ShopOrderInfoModel in model.orderInfo! {
			totalNum = totalNum + Int(infoModel.shoppingNumber!)!
		}
		if totalNum == 0 {
			totalNum = 1
		}
		let text = "共\(totalNum)件商品 合计:￥\(price!)"
//
//        let post = model.postage ?? "0"
//        let text = "共\(num!)件商品 合计:￥\(price!)(含运费￥:\(post))"
//
        view.titleLabel.text = text;
        return view;
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 44 + 50;
    }
    
}




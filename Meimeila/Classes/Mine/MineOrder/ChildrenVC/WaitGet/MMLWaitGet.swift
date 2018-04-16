//
//  MMLWaitGet.swift
//  Meimeila
//
//  Created by macos on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLWaitGet: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
   
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLWaitGet.self), bundle: nil)
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
        
        vm.waitGetOrderLister {[weak self] in
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
    
    //查看物流
    @objc func leftBtAction(_ bt:UIButton) {
        print(bt.tag)
        let model = vm.orderListArr[bt.tag - 1000];
        
        let vc = CheckLogisticsVC();
        vc.model = model;
        let nav = parent?.navigationController;
        nav?.pushViewController(vc, animated: true);
    }
    
    //确认收货
    @objc func rightBtAction(_ bt:UIButton) {
        print(bt.tag)
        
        let model = vm.orderListArr[bt.tag - 1000];
        
        vm.verifyTakeGoods(orderID:model.orderID ?? "0", succeeds: {[weak self] in
            
            self?.requestDataList();
        })
    }
}



extension MMLWaitGet:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row);
    }
}

extension MMLWaitGet:UITableViewDataSource{
    
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
        
        var stateText = "商家未发货";
        
        if let _ = model.orderState {
            
            let state = model.orderState!
            
            if state == "3"{
                stateText = "商家已发货";
            }
        }
        
        
        let view = SectionHeadView.init(frame: CGRect.zero);
        view.titleLabel.text = stateText;
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
        view.btLeft.setTitle("查看物流", for: .normal)
        view.btRight.setTitle("确认收货", for: .normal)
        view.modifyMessageBt.isHidden = true;
        
        view.btLeft.tag = section + 1000;
        view.btRight.tag = section + 1000;
        
        view.btLeft.addTarget(self, action: #selector(leftBtAction(_:)), for: .touchUpInside);
        
        view.btRight.addTarget(self, action: #selector(rightBtAction(_:)), for: .touchUpInside);
        let price = model.orderPrice;
       // let num = model.orderInfoNumber;
       // let post = model.postage ?? "0"
		
		var totalNum = 0
		for infoModel:ShopOrderInfoModel in model.orderInfo! {
			totalNum = totalNum + Int(infoModel.shoppingNumber!)!
		}
		if totalNum == 0 {
			totalNum = 1
		}
		
		let text = "共\(totalNum)件商品 合计:￥\(price!)"
		// (含运费￥:\(post))
        view.titleLabel.text = text;
        return view;
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 44 + 50;
    }
    
}



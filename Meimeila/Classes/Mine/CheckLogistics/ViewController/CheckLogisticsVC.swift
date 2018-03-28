//
//  CheckLogisticsVC.swift
//  Mythsbears
//
//  Created by macos on 2017/9/29.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit


class CheckLogisticsVC: DDBaseViewController {

    @IBOutlet weak var companyAndOrderNumLabel: UILabel!
   
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var model:ShopOrderModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "物流"
        setUI();
    
        requestData()
        
        bindMJRefresh();
    }

    ///MJ
    func bindMJRefresh() {
        
        setupRefresh(tableView, isNeedFooterRefresh: false, headerCallback: {[weak self] in
            
            self?.requestData();
            
        }, footerCallBack: nil);
    }
    
    func requestData(){
        
        var company = "0"
        var no = "0"
        
        if let _ = model?.expressCompany {
            company = (model?.expressCompany!)!;
        }
        
        if let _ = model?.expressOrderNum {
            no = (model?.expressOrderNum!)!;
        }
        
        orderListVM.logisticsDetail(company: company, no: no) {[weak self] in
            
            self?.companyAndOrderNumLabel.text = "物流公司:\(company)  物流单号:\(no)";
            self?.tableView.reloadData();
        }
        
    }
    
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing:String.init(describing: CheckLogisticsVC.self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
     func setUI() {
     
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 44;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = .none;
        tableView.register(UINib.init(nibName: String.init(describing: CheckLogisticsCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: CheckLogisticsCell.self));
    }


    
    lazy var orderListVM :MSXMineOrderListVM = {[weak self] in
        let vm = MSXMineOrderListVM()
        vm.tableView = self?.tableView;
        return vm;
        
    }()
}


extension CheckLogisticsVC:UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true);
        
        print(indexPath.row);
    }
}


extension CheckLogisticsVC:UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:CheckLogisticsCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: CheckLogisticsCell.self)) as? CheckLogisticsCell;
        if let _ = cell {
        }else{
        
            cell = Bundle.main.loadNibNamed(String.init(describing: CheckLogisticsCell.self), owner: nil, options: nil)?.last as? CheckLogisticsCell;
        }
        
        
        if indexPath.row == 0 {
            
            cell?.iconBt.snp.makeConstraints({ (make) in
                
                make.top.equalToSuperview().offset(0);
            })
            
            cell?.iconBt.backgroundColor = DDGlobalNavBarColor();
        }else{
            cell?.iconBt.backgroundColor = UIColor.lightGray;
        }
        
        let count = orderListVM.logisticsArr.count;
        
        let model = orderListVM.logisticsArr[count - indexPath.row - 1];
        cell?.setLoginsticsModel = model;
        return cell!;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderListVM.logisticsArr.count;
    }
    
    
}

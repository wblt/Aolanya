//
//  MMLRightVC.swift
//  Meimeila
//
//  Created by macos on 2017/12/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLRightVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLRightVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    override func setupUI() {
        
        setTableView();
        bindMJRefresh();
        httpRequest();
    }
    
  lazy var headView:UIView = {[weak self] in
        
        let v = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: 48))
//        v.backgroundColor = UIColor.red;
        v.addSubview((self?.headl0)!);
        v.addSubview((self?.headl1)!);
        v.addSubview((self?.headl2)!);

        return v;
    }()
    
    
   lazy  var headl0:UILabel = {
        
        let v = UILabel.init(frame: CGRect.init(x: 16, y: 0, width: 50, height: 48))
//        v.backgroundColor = UIColor.white;
        v.text = "礼品";
        v.textAlignment = .left;
        v.textColor = UIColor.black;
        return v;
    }()
    
   lazy  var headl1:UILabel = {
        
        let v = UILabel.init(frame: CGRect.init(x: Screen.width/2+5, y: 0, width: 100, height: 48))
//        v.backgroundColor = UIColor.white;
        v.text = "兑换渠道";
        v.textAlignment = .left;
        v.textColor = UIColor.black;
        return v;
    }()
   
   lazy  var headl2:UILabel = {
        
        let v = UILabel.init(frame: CGRect.init(x: Screen.width - 16 - 50, y: 0, width: 50, height: 48))
//        v.backgroundColor = UIColor.white;
        v.text = "状态";
        v.textAlignment = .left;
        v.textColor = UIColor.black;
        return v;
    }()
    
    lazy var vm:MMLLuckDrawRecordViewModel = {
        let vm = MMLLuckDrawRecordViewModel();
        vm.tableView = self.tableView;
        return vm;
    }()
}

extension MMLRightVC{
    
    func bindMJRefresh() {
        setupRefresh(tableView, isNeedFooterRefresh: true, headerCallback: {[weak self] in
            self?.vm.numberPages = 0;
            self?.httpRequest();
        }) {[weak self] in
            
            self?.vm.numberPages += 1;
            
            self?.httpRequest();
        }
    }
    
    func httpRequest() {
        
        vm.exChangeLuckRecord {
            
            self.tableView.reloadData();
        }
    }
    
    func setTableView() {
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 64;
//        tableView.bounces = false;
        tableView.showsVerticalScrollIndicator = false;
        tableView.tableHeaderView = headView;
        tableView.tableFooterView = UIView.init();
        tableView.register(UINib.init(nibName: String.init(describing: MMLGiftRecordCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLGiftRecordCell.self));
        
    }
}

extension MMLRightVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        
        
        var cell:MMLGiftRecordCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLGiftRecordCell.self)) as? MMLGiftRecordCell;
        
        if let _ = cell{}else{
            
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLGiftRecordCell.self), owner: nil, options: nil)?.last as? MMLGiftRecordCell;
        }
        cell?.selectionStyle = .none;
        cell?.setModel = vm.exchangeModelArr[indexPath.row];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        tableView.displayprompts(message: "暂无数据", image: "icon_orderEmpty", cellCount: vm.exchangeModelArr.count);
        if let _ = tableView.mj_footer {
            
            tableView.mj_footer.isHidden = vm.exchangeModelArr.isEmpty;
        }
        return  vm.exchangeModelArr.count;
    }
    

}

extension MMLRightVC:UITableViewDelegate{
    
    
}


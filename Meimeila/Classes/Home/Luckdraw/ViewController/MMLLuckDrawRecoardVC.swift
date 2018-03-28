//
//  MMLLuckDrawRecoardVC.swift
//  Meimeila
//
//  Created by macos on 2017/12/26.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLLuckDrawRecoardVC: DDBaseViewController {

    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLLuckDrawRecoardVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        
        setTableView();
        bindRefresh();
        htttpRequest();
    }

    lazy var vm:MMLLuckDrawRecordViewModel = {
        let vm = MMLLuckDrawRecordViewModel.init()
        vm.tableView = self.tableView;
        return vm;
    }()
   
    
}


extension MMLLuckDrawRecoardVC{
    
    
    func htttpRequest() {
        
        vm.getLuckDrawRecord {
            
            self.tableView.reloadData();
        }
    }
    
    
    
    func bindRefresh() {
        
        setupRefresh(tableView, isNeedFooterRefresh: true, headerCallback: {[weak self] in
            self?.vm.numberPages = 0;
            self?.htttpRequest();
        }) {[weak self] in
            self?.vm.numberPages += 1;
            self?.htttpRequest();
        }
    }
    
    
    func setTableView() {
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 85;
        tableView.tableFooterView = UIView.init();
        tableView.backgroundColor = DDGlobalBGColor()
        tableView.showsVerticalScrollIndicator = false;
        
        tableView.register(UINib.init(nibName: String.init(describing: MMLDetailCellTableViewCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLDetailCellTableViewCell.self));
    }
  
}

extension MMLLuckDrawRecoardVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MMLDetailCellTableViewCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLDetailCellTableViewCell.self)) as? MMLDetailCellTableViewCell;
        cell?.separatorInset.left = 0;
        cell?.selectionStyle = .none;
        if let _ = cell {
            
        }else{
            
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLDetailCellTableViewCell.self), owner: nil, options: nil)?.last as? MMLDetailCellTableViewCell;
        }
        cell?.luckDrawModel = vm.modelArr[indexPath.row];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.displayprompts(message: "暂无数据", image: "icon_orderEmpty", cellCount: vm.modelArr.count);
        if let _ = tableView.mj_footer {
            
            tableView.mj_footer.isHidden = vm.modelArr.isEmpty;
        }
        
        return vm.modelArr.count;
    }
}

extension MMLLuckDrawRecoardVC:UITableViewDelegate{
    
    
}

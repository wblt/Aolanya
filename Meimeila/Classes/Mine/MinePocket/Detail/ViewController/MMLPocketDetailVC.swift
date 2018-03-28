//
//  MMLPocketDetailVC.swift
//  Meimeila
//
//  Created by macos on 2017/11/25.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLPocketDetailVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLPocketDetailVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        self.title = "明细"
        setTableView();
        bindMJ();
        httpRquest();
    }
    
    lazy var vm:MMLDetailViewModel = {
        
        let vm = MMLDetailViewModel();
        vm.tableView = tableView;
        return vm;
        
    }()
    
    
    
    var isHealBeans = false;
}
extension MMLPocketDetailVC{
    
    func httpRquest() {
        
        if isHealBeans {
            

            vm.beansRecord {
                self.tableView.reloadData();

            }
            
        }else{
        
            vm.requestData {
                
                self.tableView.reloadData();
            }
        }
    }
    
    func bindMJ() {
        
        setupRefresh(tableView, isNeedFooterRefresh: true, headerCallback: {[weak self] in
            self?.httpRquest()
            self?.vm.numberPager = 0;
        }) {[weak self] in
            self?.httpRquest();
            self?.vm.numberPager += 15;
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

extension MMLPocketDetailVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MMLDetailCellTableViewCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLDetailCellTableViewCell.self)) as? MMLDetailCellTableViewCell;
        cell?.separatorInset.left = 0;
        cell?.selectionStyle = .none;
        if let _ = cell {
            
        }else{
            
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLDetailCellTableViewCell.self), owner: nil, options: nil)?.last as? MMLDetailCellTableViewCell;
        }
        
        if isHealBeans{
            
            cell?.beasnModel = vm.beansArr[indexPath.row];

        }else{
            cell?.detailModel = vm.moderArr[indexPath.row];

        }
        
        return cell!;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isHealBeans{
            
            tableView.displayprompts(message: "暂无数据", image: "icon_orderEmpty", cellCount: vm.beansArr.count);
            
            if let _ = tableView.mj_footer {
                
                tableView.mj_footer.isHidden = vm.beansArr.isEmpty;
            }
            return vm.beansArr.count;
            
        }else{
            tableView.displayprompts(message: "暂无数据", image: "icon_orderEmpty", cellCount: vm.moderArr.count);
        
            if let _ = tableView.mj_footer {
            
                tableView.mj_footer.isHidden = vm.moderArr.isEmpty;
            }
            return vm.moderArr.count;
        }
    }
}

extension MMLPocketDetailVC:UITableViewDelegate{
    
    
}


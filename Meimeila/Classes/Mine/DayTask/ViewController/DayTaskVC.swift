//
//  DayTaskVC.swift
//  Mythsbears
//
//  Created by macos on 2017/10/10.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class DayTaskVC: DDBaseViewController {

    
    @IBOutlet weak var countDouLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "每日任务";
        setUI();
        bindMJ();
        requestData();
    }

    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing:String.init(describing: DayTaskVC.self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        tableView.tableFooterView = UIView.init();
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 44;
        tableView.register(UINib.init(nibName: String.init(describing: DayTaskCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: DayTaskCell.self));
    }

    lazy var vm:DayTaskViewModel = {[weak self] in
        let vm = DayTaskViewModel.shared;
        vm.tableView = self?.tableView;
        return vm;
    }()
    
}

extension DayTaskVC {
    
    func requestData() {
        
        vm.getDayTaskRequest(succeeds: {[weak self] in
            
            self?.countDouLabel.text = self?.vm.beans;
            
            self?.tableView.mj_header.endRefreshing();

            self?.tableView.reloadData();
        }) {[weak self] in
            self?.tableView.mj_header.endRefreshing();

        }
    }
    
    
    func bindMJ() {
        
        setupRefresh(tableView, isNeedFooterRefresh: false, headerCallback: {[weak self] in
            
            self?.requestData();
            
        }) {
            
        }
    }
}


extension DayTaskVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        print(indexPath.row);
		let dayTaskModel = vm.modelArr[indexPath.row]
		if dayTaskModel.type == "1" {
			let vc = MMLProductDetailsVC()
			vc.shoppingID = dayTaskModel.shopingID
			navigationController?.pushViewController(vc, animated: true)
		}else if dayTaskModel.type == "2" {
			let VC = DDSmartmaskVC()
			navigationController?.pushViewController(VC, animated: true)
			//navigationController?.pushViewController(MMLSmartHardwareVC(), animated: true)
		}else if dayTaskModel.type == "3" {
			navigationController?.popToRootViewController(animated: true)
			UIApplication.sharedDelegate().window?.rootViewController = DDTabBarViewController();

		}
		
    }
}

extension DayTaskVC:UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:DayTaskCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: DayTaskCell.self)) as? DayTaskCell;
        
        if let _ = cell {
            
            cell?.separatorInset.left = 0;
            cell?.selectionStyle = .none;
        }else{
            
            cell = Bundle.main.loadNibNamed(String.init(describing: DayTaskCell.self), owner: nil, options: nil)?.last as? DayTaskCell;
        }
        cell?.setDayTaskModel = vm.modelArr[indexPath.row];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return vm.modelArr.count;
    }

    
   
}




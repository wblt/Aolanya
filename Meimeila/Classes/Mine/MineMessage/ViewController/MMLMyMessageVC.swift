//
//  MMLMyMessageVC.swift
//  Meimeila
//
//  Created by macos on 2017/11/25.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMyMessageVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLMyMessageVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        self.title = "我的消息"
        setTableView();
        bindMJ();
        httpRquest();
    }
    
    lazy var vm:MSXMessageVM = {
        let vm = MSXMessageVM.init();
        vm.tableView = self.tableView;
        return vm;
    }()
}


extension MMLMyMessageVC{

        func httpRquest() {
            vm.userMessage {
         
                self.tableView.reloadData();
            }
        }
        
        func bindMJ() {
            
            setupRefresh(tableView, isNeedFooterRefresh: true, headerCallback: {[weak self] in
                self?.httpRquest()
                self?.vm.numberPage = 0;
            }) {[weak self] in
                self?.httpRquest();
                self?.vm.numberPage += 15;
            }
        }
        
        func setTableView() {
            
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.rowHeight = UITableViewAutomaticDimension;
            tableView.estimatedRowHeight = 85;
            tableView.tableFooterView = UIView.init();
            tableView.backgroundColor = DDGlobalBGColor()
            tableView.showsVerticalScrollIndicator = false;
            
            tableView.register(UINib.init(nibName: String.init(describing: MMLMessageCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLMessageCell.self));
        }
        
    }
    
extension MMLMyMessageVC:UITableViewDataSource{
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            var cell:MMLMessageCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLMessageCell.self)) as? MMLMessageCell;
            cell?.separatorInset.left = 0;
            cell?.selectionStyle = .none;
            if let _ = cell {
                
            }else{
                
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLMessageCell.self), owner: nil, options: nil)?.last as? MMLMessageCell;
            }
            cell?.messageModel = vm.userMessageArr[indexPath.row];
            return cell!;
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            tableView.displayprompts(message: "暂无数据", image: "icon_orderEmpty", cellCount: vm.userMessageArr.count);
            
            if let _ = tableView.mj_footer {
                
                tableView.mj_footer.isHidden = vm.userMessageArr.isEmpty;
            }
            return vm.userMessageArr.count;
        }
        
}
    
extension MMLMyMessageVC:UITableViewDelegate{
        
        
}



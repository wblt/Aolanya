//
//  MMLPocketVC.swift
//  Meimeila
//
//  Created by macos on 2017/10/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLPocketVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var isHealthBean = false;
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLPocketVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        requestData();
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotiFication();
    }

    override func setupUI() {
        setTableView();
    }
    
    func requestData() {
        
        if isHealthBean {
            
            vms.beansCount {[weak self] in
            
                self?.tableHeadView.money.text = self?.vms.beansModel?.beans ?? "0"

            }
            
        }else{
        
            vms.getMoneyBalance {[weak self] in
                self?.tableHeadView.money.text = self?.vms.moneyModel?.money ?? "0.00";
            }
        }
    }
    
    
    func addNotiFication() {
        
        Barista.add(observer: self, selector: #selector(goSet), notification: .goSet);
    }
    
    
    deinit {
        
        Barista.remove(observer: self, notification: .goSet);
    }
    
    @objc func goSet(){
        
        self.navigationController?.pushViewController(MMLMineSet(), animated: true);
    }
    
    
    
    func setTableView() {
        tableView.tableHeaderView = tableHeadView;
        tableView.rowHeight = 54;
        tableView.backgroundColor = RGB_somkeWhite;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorInset.left = 0;
        tableView.tableFooterView = UIView.init();
        tableView.register(UINib.init(nibName: String.init(describing: MMLMineCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLMineCell.self));
    }
    
    
    lazy var tableHeadView:MMLPocketHeadView = {[weak self] in
        let view = MMLPocketHeadView.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: 220));
        if (self?.isHealthBean)!{
            view.label.text = "健康豆剩余(颗)";
        }
        return view;
    }()
    
    lazy var vm:MMLPocketViewModel = {
        let vm = MMLPocketViewModel();
        return vm;
    }()
    
    lazy var vms:MSXPocketViewModel = {[weak self] in
        let vm = MSXPocketViewModel();
        vm.tableView = self?.tableView;
        return vm;
        }()
    
}

extension MMLPocketVC:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true);
        
        if indexPath.row == 0{
            
            
            if isHealthBean{
                
                let vc = BeansRechargeVC();
                vc.delegate = self;
                vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen;
                self.present(vc, animated: false, completion: {
                    
                })
                
            }else{
            
                let vc = MMLRechargeCashVC();
                vc.delegate = self;
                vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen;
                self.present(vc, animated: false, completion: {
                    
                })
          
            }
        }else if indexPath.row == 1 {
            
            let vc = MMLPocketDetailVC();
            vc.isHealBeans = self.isHealthBean;
            navigationController?.pushViewController(vc, animated: true);
        
        }else if indexPath.row == 2 {
			
			let vc = MMLWithdrawVC()
			 self.navigationController?.pushViewController(vc, animated: true);
//            let vc = MMLBeansToMonayVC()
//            vc.title = "健康豆兑换";
//            self.navigationController?.pushViewController(vc, animated: true);
			
        }
        
        
    }
    
}

extension MMLPocketVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MMLMineCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLMineCell.self)) as? MMLMineCell;
        
        if let _ = cell {}else{
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLMineCell.self), owner: nil, options: nil)?.last as? MMLMineCell;
        }
        
        if isHealthBean {
            cell?.setDic = vm.pocketBeansCellTitleDic[indexPath.row];

        }else{
            cell?.setDic = vm.pocketCellTitleDic[indexPath.row];

        }
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isHealthBean {
            
            return vm.pocketBeansCellTitleDic.count;
        }
        
        return vm.pocketCellTitleDic.count;
    }
}

extension MMLPocketVC:MMLRechargeCashVCDelegate{
    func payResult(cash: String, isPaySuccess: Bool, isFormType: Int) {
        
        let vc = PocketRechargeStateVC()
        vc.isPaySuccess = isPaySuccess
        vc.isFormType = 1
        vc.payMoney = cash;
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

extension MMLPocketVC:BeansRechargeVCDelegate{
    func beansRechargeResult(cash: String, isPaySuccess: Bool, isFormType: Int) {
        let vc = PocketRechargeStateVC()
        vc.isPaySuccess = isPaySuccess
        vc.isFormType = 1
        vc.payMoney = cash;
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}

//
//  MMLMineVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/16.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMineVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLMineVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        
        let loginStatue = DDDeviceManager.shared.loginStatue();
        tableHeadView.loginStatue(loginStatue);
        
        if loginStatue {
            requestUsrInfoData();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        setTableView();
        
        addNavBarBackButton(imageName: "icon_set") {[weak self] (bt) in
            
            let vc = MMLMineSet();
            self?.navigationController?.pushViewController(vc, animated: true);
        }
        
        
        addNavBarRightButton(imageName: "icon_message") {[weak self] (bt) in
            
            let vc = MMLMyMessageVC();
            self?.navigationController?.pushViewController(vc, animated: true);
        }
        
    }
    func setTableView() {
        
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 54;
        tableView.showsVerticalScrollIndicator = false;
        tableView.tableFooterView = UIView.init();
        tableView.separatorInset.left = 0;
        tableView.backgroundColor = RGB_somkeWhite;
        tableView.tableHeaderView = tableHeadView;
        tableView.bounces = false;
        tableView.register(UINib.init(nibName: String.init(describing: MMLMineCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLMineCell.self));
    }

    
    lazy var vm:MMLMineViewModel = {
        let vm = MMLMineViewModel.init();
        return vm;
    }()
    
    
    lazy var uservm:MMLUserInfoViewModel = {[weak self] in
        let vm = MMLUserInfoViewModel.init();
        vm.tableView = self?.tableView;
        return vm;
        }()
    
    
    lazy var tableHeadView:MMLMineHeadView = {[weak self] in
        
        let view = MMLMineHeadView.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: 64 + 100 + 20 + 5 + 20 + 20));
        view.currentVC = self;
        view.headIconBt.addTarget(self, action: #selector(selectHeadIcon), for: UIControlEvents.touchUpInside);
        return view;
    }()
    
    
    deinit {
        
        Barista.remove(observer: self, notification: Barista.Notification.gotoHome);
    }
    
}


extension MMLMineVC{
    
    ///获取用户信息
    func requestUsrInfoData() {
        uservm.getUserInfo {[weak self] in
			
            self?.tableHeadView.headIconBt.jq_setButtonImage(url: URL.init(string: self?.uservm.infoModel?.picture ?? ""), placeholder: "icon_defaultHeadIcon", state: UIControlState.normal);
			
          //  self?.tableHeadView.nickNameLabel.text = self?.uservm.infoModel?.name ?? self?.uservm.infoModel?.uid!
        }
    }
    
    
    func addNoti() {
        
        Barista.add(observer: self, selector: #selector(goHome), notification: Barista.Notification.gotoHome)
    }
    
    
    @objc func goHome(){
        
        tabBarController?.selectedIndex = 0;
    }
    
    
    
    @objc func selectHeadIcon(){
        
        let vc = MMLSetHeadIconVC();
        vc.model = uservm.infoModel;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    
    func goLogin(loginStatue:Bool) {
        
            let vc = MMLLoginVC()
            self.navigationController?.pushViewController(vc, animated: true);
    }
}



extension MMLMineVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true);
        
        print("我的cell->",indexPath.row);
        
        let loginStatue = DDDeviceManager.shared.loginStatue();
        
        
        if indexPath.section == 0 {
           
            if !loginStatue{
                goLogin(loginStatue: loginStatue)
                return;
            }
			
            
            if indexPath.row == 0{
                
                let vc = MMLPocketVC();
                vc.title = "我的钱包"
                vc.isHealthBean = false;
                navigationController?.pushViewController(vc, animated: true);
                
            }else if indexPath.row == 1 {
                
                let vc = MMLEditeUserInfoVC();
                navigationController?.pushViewController(vc, animated: true);
                
            }else if indexPath.row == 2 {
                
//                let vc = MMLPocketVC()
//                vc.title = "我的健康豆"
//                vc.isHealthBean = true;
//                navigationController?.pushViewController(vc, animated: true);

				let vc = MMLBeansToMonayVC()
				vc.title = "健康豆兑换";
				self.navigationController?.pushViewController(vc, animated: true);
				
                
            }
        
        }else if indexPath.section == 1 {
           
            if indexPath.row == 0{
                if !loginStatue{
                    goLogin(loginStatue: loginStatue)
                    return;
                }
				
				let vc = DayTaskVC();
				navigationController?.pushViewController(vc, animated: true)
// 				  //地址
//                let vc = MMLMineAddressVC()
//                vc.isEdit = true;
//                navigationController?.pushViewController(vc, animated: true);
//
            }else if indexPath.row == 1 {
				
				let vc = MMLContactServiceVC();
				vc.title = "联系客服";
				self.navigationController?.pushViewController(vc, animated: true);
				
//                let vc  = APPVersionVC();
//                navigationController?.pushViewController(vc, animated: true);
            }
        }else if indexPath.section == 2 {
            
            if indexPath.row == 0{
                let vc = MMLMineOpinionVC();
				vc.title = "商家入驻洽谈"
				vc.titleMsg = "* 请输入入驻平台的商品名，联系人"
                navigationController?.pushViewController(vc, animated: true);
                
            }else if indexPath.row == 1 {
                let vc = MMLAboutUsVC();
                navigationController?.pushViewController(vc, animated: true);
            }else if indexPath.row == 2 {
                let vc = MMLMineOpinionVC();
                navigationController?.pushViewController(vc, animated: true);
            }else if indexPath.row == 3 {
				let vc = MMLMineOpinionVC();
				navigationController?.pushViewController(vc, animated: true);
            }
        }
        
        
    }
    
}

extension MMLMineVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MMLMineCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLMineCell.self)) as? MMLMineCell;
        if let _ = cell {}else{
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLMineCell.self), owner: nil, options: nil)?.last as? MMLMineCell;
            
        }
        
        let arr = vm.mineCellTitleDic[indexPath.section];
        let dic = arr[indexPath.row];
        cell?.setDic = dic;
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let num = vm.mineCellTitleDic[section];
        return num.count;
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.mineCellTitleDic.count;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init();
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init();
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 9.99;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    
}



//
//  MMLMineSet.swift
//  Meimeila
//
//  Created by macos on 2017/12/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMineSet: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLMineSet.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        self.title = "设置"
        setTableView();
    }
    
 
    func setTableView() {
        tableView.rowHeight = 54;
        tableView.backgroundColor = RGB_somkeWhite;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorInset.left = 0;
        tableView.tableFooterView = footBt;
        tableView.register(UINib.init(nibName: String.init(describing: MMLMineCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLMineCell.self));
    }
    
   
    lazy var vm:MMLMineSetViewModel = {
        
        let vm = MMLMineSetViewModel.shared;
        return vm;
    }()
    
    
    lazy var footBt:UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: 64));
        view.backgroundColor = UIColor.white;
        
        let bt = UIButton.init(type: UIButtonType.custom);
        bt.backgroundColor = RGB_tomatoRed;
        bt.addTarget(self, action: #selector(outOfLogin), for: UIControlEvents.touchUpInside);
        bt.frame = CGRect.init(x: 16, y: 10, width: Screen.width - 32, height: 44);
        bt.setTitle("安全退出", for: UIControlState.normal);
        bt.layer.cornerRadius = 5.0;
        view.addSubview(bt);
        return view;
    }()
    
    lazy var loginOut:MMLLoginViewModel = {
        
        let vm = MMLLoginViewModel.shared;
        return vm;
    }()
    
    ///退出登录
    @objc func outOfLogin() {
        
        loginOut.outLoginAction {
			DispatchQueue.main.asyncAfter(deadline:DispatchTime.now()+1.0, execute: {
				
				   self.navigationController?.popViewController(animated: true);
			})
        }
        
        
    }
    
}

extension MMLMineSet:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true);
        
		if indexPath.row == 0{
			let vc = MMLMoneyPaySetPWVC()
			vc.title = "设置支付密码"
			navigationController?.pushViewController(vc, animated: true);
		}else if indexPath.row == 1{
			
			let vc = MMLBindPhoneVC()
			vc.title = "绑定手机号"
			navigationController?.pushViewController(vc, animated: true);
		
			
        }else if indexPath.row == 2 {
			
			let vc = MMLBindPhoneVC()
			vc.title = "解除绑定"
			vc.isBindPhone = false;
			navigationController?.pushViewController(vc, animated: true);
        }else if indexPath.row == 3{
			//地址
			let vc = MMLMineAddressVC()
			vc.isEdit = true;
			navigationController?.pushViewController(vc, animated: true);
			
		}else if indexPath.row == 4{
			let vc = MMLMineOpinionVC();
			vc.title = "意见反馈"
			//* 问题描述(5~200字)
			vc.titleMsg = "* 问题描述(5~200字)"
			navigationController?.pushViewController(vc, animated: true);
        }else {
            let vc = ALYAboutUsVC()
            vc.title = "关于"
            navigationController?.pushViewController(vc, animated: true);
        }
    }
}

extension MMLMineSet:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MMLMineCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLMineCell.self)) as? MMLMineCell;
        
        if let _ = cell {}else{
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLMineCell.self), owner: nil, options: nil)?.last as? MMLMineCell;
        }
        cell?.setDic = vm.cellDic[indexPath.row];
        cell?.accessoryType = .disclosureIndicator;
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.cellDic.count;
    }
}


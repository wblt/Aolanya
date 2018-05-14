//
//  MMLEditeUserInfoVC.swift
//  Meimeila
//
//  Created by macos on 2017/10/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLEditeUserInfoVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLEditeUserInfoVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestUsrInfoData();
        bindMJRefresh();
        
    }

    override func setupUI() {
        self.title = "编辑资料";
        addNavBarRightButton(imageName: "icon_complete") { [weak self](bt) in
            print("保存");
            
            let sectionTwo = self?.vm.userInfoCellDetailArr[2];
            let sectionThree = self?.vm.userInfoCellDetailArr[3];
            
            self?.vm.userInfoUp(name: sectionTwo?[0], sex: sectionTwo?[1], age: sectionThree?[1], email: sectionThree?[2], qq: nil, address: sectionTwo?[2], personalizedSignature: sectionTwo?[3], occupation: sectionThree?[0]);
            
        }
        setTableView();
    }
        
    func setTableView() {
        
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 54;
        tableView.showsVerticalScrollIndicator = false;
        tableView.tableFooterView = UIView.init();
        tableView.separatorInset.left = 0;
        tableView.backgroundColor = RGB_somkeWhite;
//        tableView.tableFooterView = footBt;
       
        tableView.register(UINib.init(nibName: String.init(describing: MMLUserHeadIconCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLUserHeadIconCell.self));
        
         tableView.register(UINib.init(nibName: String.init(describing: MMLEditeUserCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLEditeUserCell.self));
    }
    
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
    
    lazy var vm:MMLUserInfoViewModel = {[weak self] in
        let vm = MMLUserInfoViewModel.init();
        vm.tableView = self?.tableView;
        return vm;
    }()
    
    
    lazy var loginOut:MMLLoginViewModel = {
        
        let vm = MMLLoginViewModel.shared;
        return vm;
    }()
}

extension MMLEditeUserInfoVC{
    
    
    func bindMJRefresh() {
        
        setupRefresh(tableView, isNeedFooterRefresh: false, headerCallback: {[weak self] in
            
            self?.requestUsrInfoData();
            
        }) {
            
            
        }
    }
    
    func requestUsrInfoData() {
        
        vm.getUserInfo {
            self.tableView.reloadData();
        }
    }
    
    
    
    ///退出登录
  @objc func outOfLogin() {
        
    loginOut.outLoginAction {
        
        
    }
            
    
    }
    
}



extension MMLEditeUserInfoVC:MMLEditeInfoVCDelegate{
    func editiFinish(indexPath: IndexPath, message: String) {
    
        var arr = vm.userInfoCellDetailArr[indexPath.section];
        arr[indexPath.row] = message;
        
        vm.userInfoCellDetailArr[indexPath.section] = arr;
        
        let cell = tableView.cellForRow(at: indexPath) as! MMLEditeUserCell
        cell.setInfo = message;
    }
    
}


extension MMLEditeUserInfoVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true);
        
        print("我的cell->",indexPath.row);
        
        let cell = tableView.cellForRow(at: indexPath) as? MMLEditeUserCell;
        if let label = cell?.cellTitleLabel{
            vm.cellCurrentDetail = label;
        }
        
        if indexPath.section == 0 {
            let vc = MMLSetHeadIconVC();
            navigationController?.pushViewController(vc, animated: true);
        }else if indexPath.section == 1 {
            
           
            
        }else if indexPath.section == 2 {
            

            let vc = MMLEditeInfoVC();
            vc.delegate = self;
            vc.indexPath = indexPath;
            if indexPath.row == 0{
                vc.title = "昵称";
                
            }else if indexPath.row == 1 {
                vc.title = "性别";

            }else if indexPath.row == 2 {
                vc.title = "所在地";

            }else if indexPath.row == 3 {
                vc.title = "个性签名";
            }
            navigationController?.pushViewController(vc, animated: true);
            
        }else if indexPath.section == 3 {
            
            if indexPath.row != 3 {
                
                let vc = MMLEditeInfoVC();
                vc.indexPath = indexPath;
                vc.delegate = self;
                if indexPath.row == 0 {
                    vc.title = "职业";

                }else if indexPath.row == 1 {
                    vc.title = "年龄";

                }else if indexPath.row == 2 {
                    vc.title = "邮箱";

				}else if indexPath.row == 3 {
					vc.title = "手机号";
					
				}
                navigationController?.pushViewController(vc, animated: true);
            }else{
                
                let vc = MMLModifedPasswordVC();
                navigationController?.pushViewController(vc, animated: true);

            }
        }
    }
    
}

extension MMLEditeUserInfoVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var cell:MMLUserHeadIconCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLUserHeadIconCell.self)) as? MMLUserHeadIconCell;
            if let _ = cell {}else{
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLUserHeadIconCell.self), owner: nil, options: nil)?.last as? MMLUserHeadIconCell;
            
            }
            if vm.userInfoCellDetailArr.count > 0{

                let arr = vm.userInfoCellDetailArr[indexPath.section];
                let url = arr[indexPath.row];
                cell?.setIcon = url;
            }
            cell?.accessoryType = .disclosureIndicator;
            return cell!
        }else {
            var cell:MMLEditeUserCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLEditeUserCell.self)) as? MMLEditeUserCell;
            if let _ = cell {}else{
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLEditeUserCell.self), owner: nil, options: nil)?.last as? MMLEditeUserCell;
                
            }
            
            let arr = vm.userInfoCellTitleArr[indexPath.section];
            let titles = arr[indexPath.row];
            cell?.cellTitleLabel.text = titles;
            
            
            if indexPath.section == 2 && indexPath.row == 1{
				
				
                cell?.accessoryType = .disclosureIndicator;
            }else if indexPath.section == 3 {
                cell?.accessoryType = .disclosureIndicator;
            }
            
            if vm.userInfoCellDetailArr.count > 0{
                let section = indexPath.section;
                let row = indexPath.row;
                
                var title = vm.userInfoCellDetailArr[section];
				
				if section == 2 && row == 1 {
					if title[row]  == "0"{
						title[row] = "女"
					}else {
						title[row] = "男"
					}
				}
				
                cell?.setInfo = title[row];
            }
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let arr = vm.userInfoCellTitleArr[section];
        return arr.count;
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = vm.userInfoCellTitleArr.count;
        return count;
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


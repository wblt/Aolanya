//
//  MMLAboutUsVC.swift
//  Meimeila
//
//  Created by macos on 2017/11/25.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLAboutUsVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLAboutUsVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupUI() {
        
        self.title = "关于我们"
        
        setTableView();
    }
    
    lazy var headView:MMLAboutUsHeadView = {
        
        let view = MMLAboutUsHeadView.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: 250));
        return view;
    }()
    
    lazy var vm:MMLAboutUsViewModel = {
        let vm = MMLAboutUsViewModel.shared
        return vm
    }()
    
}

extension MMLAboutUsVC {
    
    func setTableView() {
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 54;
        
        tableView.tableHeaderView = headView;
        tableView.bounces = false;
        tableView.tableFooterView = UIView.init();
    }
    
}

extension MMLAboutUsVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.row == 0 {//官网
            
            let vc = MMLAboutUsWkwebVC()
            vc.loadUrlString("http://nnddkj.com/index.php", title: "嘀哒科技");
            self.navigationController?.pushViewController(vc, animated: true);
            
        }else if indexPath.row == 1 {//微博
            let vc = MMLAboutUsWkwebVC()
            vc.loadUrlString("https://weibo.com/u/5546893910?refer_flag=1001030101_&is_all=1", title: "嘀哒科技");
            self.navigationController?.pushViewController(vc, animated: true);
            
        }else if indexPath.row == 2 {//公众号
            
        }else if indexPath.row == 3 {//版权
            
        }else if indexPath.row == 4 {//服务条款
            let vc = MMLAboutUsWkwebVC()
            vc.loadUrlString("http://ml.nnddkj.com/meimeila/API/user/userAgreement.html", title: "嘀哒科技");
            self.navigationController?.pushViewController(vc, animated: true);
            
        }
    }
}

extension MMLAboutUsVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:MMLAboutUsCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLAboutUsCell.self)) as? MMLAboutUsCell
        
        if let _ = cell {
            
        }else{
            
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLAboutUsCell.self), owner: nil, options: nil)?.last as? MMLAboutUsCell
        }
        
        cell?.cellTitle.text = vm.titleArr[indexPath.row];
        cell?.selectionStyle = .none;
        
        if indexPath.row == 2 || indexPath.row == 3 {
            cell?.ddkj.isHidden = false;
            cell?.accessoryType = .none;
        }else{
            
            cell?.ddkj.isHidden = true;
            cell?.accessoryType = .disclosureIndicator;
        }
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    
}

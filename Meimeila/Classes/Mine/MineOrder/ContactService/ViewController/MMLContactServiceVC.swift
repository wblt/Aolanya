//
//  MMLContactServiceVC.swift
//  Meimeila
//
//  Created by macos on 2017/12/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLContactServiceVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        httpRequest();
    }

    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLContactServiceVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //

    lazy var vm:MMLServiceViewModel = {
        let vm = MMLServiceViewModel();
        return vm;
    }()
    
    var pop:DDPopupWindowVC?
    var type = 0;
    
    override func setupUI() {
        setTableView();
    }
}
extension MMLContactServiceVC{
    
    func setTableView() {
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 64;
        tableView.bounces = false;
        tableView.showsVerticalScrollIndicator = false;
        tableView.tableFooterView = UIView.init();
        tableView.register(UINib.init(nibName: String.init(describing: MMLserviceCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLserviceCell.self));
        
    }
    
    func httpRequest() {
        vm.request {
            
            self.tableView.reloadData();
        }
    }
    
}

extension MMLContactServiceVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MMLserviceCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLserviceCell.self)) as? MMLserviceCell;
        
        if let _ = cell{}else{
            
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLserviceCell.self), owner: nil, options: nil)?.last as? MMLserviceCell;
        }
        cell?.setModel = vm.modelArr[indexPath.row];
        
        if indexPath.row == 0 {
            cell?.label2.textColor = UIColor.lightGray;
        }else{
            cell?.label2.textColor = APPgreenColor;
        }
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return  vm.modelArr.count
    }
    
    
}

extension MMLContactServiceVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true);
        
        let model = vm.modelArr[indexPath.row];
        
        var titleMessage = "将微信福利粉丝群二维码保存至相册,微信扫码加群";
        
        if indexPath.row == 0 {
            type = 0;
        }else if indexPath.row == 1{
            type = 1;
            titleMessage = "是否复制微信客服微信号\(model.contact ?? "")";
        }else{
            type = 2;
            titleMessage = "是否拨打客服电话\(model.contact ?? "")";
        }
        
        let popwin = DDPopupWindowVC.init(message: titleMessage, leftButtonTitle: "取消", rightButtonTitle: "确定")
        popwin.delegate = self;
        popwin.modalPresentationStyle = .overFullScreen;
        pop = popwin;
        
        self.present(popwin, animated: false) {
            
        }
    }
}

extension MMLContactServiceVC:DDPopupWindowVCDelegate{
    func popupWindowVCLeftButtonAction(button: UIButton) {
        
        self.pop?.dismiss(animated: false, completion: {
            
        })
    }
    
    func popupWindowRightVCButtonActtion(button: UIButton) {
        
        let model = vm.modelArr[type]
        
        if type == 0 {
            
            vm.saveImageToPhoneLibrary(codeString: "\(model.contact ?? "")");
            
        }else if type == 1{
            
            vm.copyText(copyString: "\(model.contact ?? "")")
            
        }else if type == 2{
            
            vm.callPhone(tel: "\(model.contact ?? "")");
        }
        
        
        self.pop?.dismiss(animated: false, completion: {
            
        })
    }
    
    
    
}

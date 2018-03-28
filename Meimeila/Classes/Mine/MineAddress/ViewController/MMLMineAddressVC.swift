//
//  MMLMineAddressVC.swift
//  Meimeila
//
//  Created by macos on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MMLMineAddressVCDeleagte {
    func mineAddressListVCSlectedAddress(model: AddressModel)
}

class MMLMineAddressVC: DDBaseViewController {

    weak var delegate: MMLMineAddressVCDeleagte?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLMineAddressVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        bindMJRefresh()
        requestData()
    }

    
    override func setupUI() {
        self.title = "收获地址";
        
        addNavBarRightButton(imageName: "mall_icon_increase") {[weak self] (bt) in
            
            let vc = MMLAddNewAddressVC()
            self?.navigationController?.pushViewController(vc, animated: true);
        }
        
        setTableView();
    }
    
    func setTableView(){
        
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.estimatedRowHeight = 44;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.tableFooterView = UIView.init();
        
        tableView.register(UINib.init(nibName: String.init(describing: MMLAddressCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLAddressCell.self));
    }
    
    func bindMJRefresh() {
        
        setupRefresh(tableView, isNeedFooterRefresh: true, headerCallback: {[weak self] in
            
            self?.vm.numberPage = 0;
            self?.requestData();
        }) {[weak self] in
            
            self?.vm.numberPage += 15;
            self?.requestData();
        }
    }
    
    //获取数据
    func requestData() {
        
        vm.addressList {[weak self] in
            
            self?.tableView.reloadData();
        }
    }
    
    lazy var vm:MSXAddressVM = {[weak self] in
        let vm = MSXAddressVM.init();
        vm.tableView = self?.tableView;
        return vm;
        }()
    
    var isEdit = false;
    
    var shopModel:ShopOrderModel?
    
    var popWin:DDPopupWindowVC?
    
    var selectRow:Int?
}


extension MMLMineAddressVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        if let _ = delegate {
            delegate?.mineAddressListVCSlectedAddress(model: vm.addreaaArr[indexPath.row])
            navigationController?.popViewController(animated: true)
        }else{
            
           
                if isEdit{
                    
                    let vc = MMLAddNewAddressVC()
                    vc.isEditi = true;
                    vc.model = vm.addreaaArr[indexPath.row];
                    navigationController?.pushViewController(vc, animated: true);
                    
                }else{
                    
                    vm.orderAddressSelect(orderID: shopModel?.orderID ?? "", orderState: shopModel?.orderState ?? "", adressID: shopModel?.aeliveryAddressModel?.addressID ?? "", succeeds: {
                        
                        
                        self.navigationController?.popViewController(animated: true);
                    })
                    
                }
                
        }
    }
}

extension MMLMineAddressVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MMLAddressCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLAddressCell.self)) as? MMLAddressCell;
        
        if let _ = cell {}else{
            
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLAddressCell.self), owner: nil, options: nil)?.last as? MMLAddressCell;
        }
        cell?.accessoryType = .disclosureIndicator;
        let model = vm.addreaaArr[indexPath.row];
        cell?.addDataSource = model;
        cell?.delegate = self;
        cell?.row = indexPath.row;
        return cell!;
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let _ = tableView.mj_footer {
            tableView.mj_footer.isHidden = vm.addreaaArr.isEmpty
        }
        
        return vm.addreaaArr.count;
    }
}

extension MMLMineAddressVC:MMLAddressCellDelegate,DDPopupWindowVCDelegate{
    func popupWindowVCLeftButtonAction(button: UIButton) {
        
        self.popWin = nil;
    }
    
    func popupWindowRightVCButtonActtion(button: UIButton) {
        
        
        self.popWin = nil
        
        if let _ = selectRow {
            
            let  model = vm.addreaaArr[selectRow!];
        
            vm.deleteAddress(adressID: model.addressID!, succeeds: {
                
                self.requestData();
                
            })
        }
        
        
    }
    
    func longPressDeleteAddress(selectRow: Int) {
        
        self.selectRow = selectRow;
        
        if let _ = popWin {
            
            
        }else{
        
            let vc = DDPopupWindowVC.init(message: "删除地址", leftButtonTitle: "放弃", rightButtonTitle: "删除");
            popWin = vc;
            vc.delegate = self;
            self.addChildViewController(vc);
            vc.view.frame = self.view.bounds;
            
            self.view.addSubview(vc.view);
        }
    }

}

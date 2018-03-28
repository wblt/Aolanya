//
//  ApplyForAfterSellVC.swift
//  Mythsbears
//
//  Created by macos on 2017/9/29.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ApplyForAfterSellVC: DDBaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func submitBtAction(_ sender: Any) {
        print("提交");
    
        applyRefundCashRequest(orderID: model.orderID ?? "0", return_type: reasonIndex, return_reason: refundCashReasonIndex, return_explains: return_explains);
    }
    
    
    ///售后申请
    func applyRefundCashRequest(orderID: String, return_type: Int, return_reason: Int, return_explains: String) {
        
        if return_type == 1111{
            BFunction.shared.showErrorMessage("请选择退款原因")
            return;
        }
    
        if return_reason == 1111 {
            BFunction.shared.showErrorMessage("请选择退款类型")
            return;
        }
        
        BFunction.shared.showLoading();
        
        vm.applyAfterSale(orderID: orderID, return_type: return_type, return_reason: "\(return_reason)", return_explains: return_explains) {[weak self] code in
            
            if code == 100 {
                if self?.reasonIndex == 2{
                    BFunction.shared.showErrorMessage("申请成功!")
                }else{
                    self?.refundCash(type: 0);
                }
            }
            
            
            
           
        }
        
    }
    
    ///退款
    func refundCash(type:Int){
        
        if type == 0 {
            vm.applyRefundCash_weChat(orderID: model.orderID!, succeeds: {[weak self] in
                
                BFunction.shared.showErrorMessage("申请成功!")

                
                DDUtility.delay(1, closure: {
                    self?.navigationController?.popViewController(animated: true);
                })
            })
        }else{
            vm.applyRefundCash_aliPay(orderID: model.orderID!, succeeds: {[weak self] in
                
                BFunction.shared.showErrorMessage("申请成功!")

                DDUtility.delay(1, closure: {
                    self?.navigationController?.popViewController(animated: true);
                })
            })
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
//        IQKeyboardManager.sharedManager().enable = true;

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
//        IQKeyboardManager.sharedManager().enable = false

    }
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing:String.init(describing: ApplyForAfterSellVC.self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "售后申请";
        setUI();
        
    }

    func  setUI() {
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.RGB(r: 245, g: 245, b: 245);
        
        tableView.register(UINib.init(nibName: String.init(describing: MineCollectCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MineCollectCell.self));
        
        tableView.register(UINib.init(nibName: String.init(describing: SectionOneCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: SectionOneCell.self));
        
        tableView.register(UINib.init(nibName: String.init(describing: ReasonTFCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: ReasonTFCell.self));
        
        
        tableView.register(UINib.init(nibName: String.init(describing: SectionTwoCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: SectionTwoCell.self));

    }
    
    
    @objc func btAction(bt:UIButton){
        
        let selectIndex = bt.tag - 2220;
        
        for index in 0 ..< btState.count {
            
            if selectIndex == index{
                
                btState[index] = true
                
                reason = reasonArr[selectIndex];
                reasonIndex = selectIndex;
            }else {
                
                btState[index] = false
                
            }
            
        }
        
        tableView.reloadData();
    }
    
    
    lazy var noteLabel:UILabel = {
    
        let  lb = UILabel.init(frame: CGRect.init(x: 16, y: 0, width: Screen.width, height: 25));
        lb.text = "最多￥168.00 含发货邮费￥0.00";
        lb.textColor = UIColor.darkGray;
        lb.backgroundColor = UIColor.clear;
        lb.font = UIFont.systemFont(ofSize: 13);
        
        return lb;
    }()
    
    
    lazy var sectionthreeHeadView:UIView = {
    
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: 25));
        view.backgroundColor = UIColor.clear;

        return view;
    
    }()
    
    
    
    lazy var reasonSelectView:ReasonSelectView = {[weak self] in
        
        let view = ReasonSelectView.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: Screen.height - 64));
        view.setUI();
        view.delegate = self;
        return view;
    }()
    
    
    lazy var reasonSelectBGView:UIView = {
        
        let view = UIView.init(frame:CGRect.init(x: 0, y: 0, width: Screen.width, height: Screen.height - 64));
        view.backgroundColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.8);
        return view;
    }()
    
    var model:ShopOrderModel!

    lazy var vm:MSXMineOrderListVM = {
        
        let vm = MSXMineOrderListVM();
        return vm;
    }()
    
    var reasonArr = ["仅退款(不退货)",
                     "退款退货",
                     "换货"]
    var btState = [false,false,false];
    
    ///退款原因
    var refundCashReason:String?
    var refundCashReasonIndex:Int = 1111
    
    var reason:String?
    var reasonIndex:Int = 1111
    var return_explains:String = ""
}



extension ApplyForAfterSellVC:UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row);
        
        
        if indexPath.section == 2 && indexPath.row == 0 {
        
            
            
            self.view.addSubview(reasonSelectView);
        
        }
        
        
        if indexPath.section == 1 {
            
            
            let selectIndex = indexPath.row;
            
            for index in 0 ..< btState.count {
                
                if selectIndex == index{
                    
                    btState[index] = true
                    
                    reason = reasonArr[selectIndex]
                    reasonIndex = selectIndex
                }else {
                    
                    btState[index] = false
                    
                }
                
            }
            
            tableView.reloadData();
        }
        
        
        
        
    }
    
}


extension ApplyForAfterSellVC:UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            var cell:MineCollectCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MineCollectCell.self), for: indexPath) as? MineCollectCell;
            
            if let _ = cell {
            }else{
            
            cell = Bundle.main.loadNibNamed(String.init(describing: MineCollectCell.self), owner: nil, options: nil)?.last as? MineCollectCell;
            }
            cell?.selectionStyle = .none;
            cell?.separatorInset.left = 0.0;
            cell?.setOrderInfoData = model.orderInfo![indexPath.row];
            return cell!
            
        }else if indexPath.section == 1{
        
            var cell:SectionOneCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: SectionOneCell.self)) as? SectionOneCell;
            
            if let _ = cell {
            }else{
            
             cell = Bundle.main.loadNibNamed(String.init(describing: SectionOneCell.self), owner: nil, options: nil)?.last as? SectionOneCell;
            }
            
          
            
            cell?.celltitleLB.text = reasonArr[indexPath.row];
            
            cell?.selectBt.tag = 2220 + indexPath.row;
            cell?.selectBt.addTarget(self, action: #selector(btAction(bt:)), for: UIControlEvents.touchUpInside);
            cell?.selectBt.isSelected = btState[indexPath.row];
            
            
            cell?.selectionStyle = .none;
            cell?.separatorInset.left = 0.0;
            
            return cell!

            
        }else if indexPath.section == 2{
        
            
            if indexPath.row == 0 {
                
                
                var cell = tableView.dequeueReusableCell(withIdentifier: "one");
                
                if cell == nil {
                
                    cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "one");
                }
                
                cell?.separatorInset.left = 0;
                cell?.accessoryType = .disclosureIndicator;
                cell?.textLabel?.text = "退款原因";
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 16);
                cell?.detailTextLabel?.text = refundCashReason ?? "请选择";
                cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13);
                cell?.textLabel?.textColor = UIColor.darkGray;
               
                cell?.selectionStyle = .none;
                return cell!;

            }else{
            
                
                var cell:SectionTwoCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: SectionTwoCell.self)) as? SectionTwoCell;
                
                if let _ = cell {
                }else{
                    
                    cell = Bundle.main.loadNibNamed(String.init(describing: SectionTwoCell.self), owner: nil, options: nil)?.last as? SectionTwoCell;
                }
                cell?.separatorInset.left = 0.0;
                cell?.selectionStyle = .none;
                cell?.setPrice = model.orderFinalPrice ?? "0.00";
                return cell!
            }
            
        }else {
        
            var cell:ReasonTFCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ReasonTFCell.self)) as? ReasonTFCell;
            
            if let _ = cell {
                
               
            }else{
             cell = Bundle.main.loadNibNamed(String.init(describing: ReasonTFCell.self), owner: nil, options: nil)?.last as? ReasonTFCell;
            }
            cell?.separatorInset.left = 0.0;
            cell?.delegate = self;
            cell?.selectionStyle = .none;
            return cell!

            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return model.orderInfo?.count ?? 0 ;
            
        }else if section == 1{
            
            return 3;
            
        }else if section == 2{
            
            return 2;
            
        }else {
            
            return 1;
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return (model.orderInfo?.count ?? 0) > 0 ? 4 : 0 ;        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0 {
            
            return 106;
        }else{
        
            return 44;
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let  view = UIView.init();
        view.backgroundColor = UIColor.clear;
        return view;
    
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 2 {
            
             sectionthreeHeadView.addSubview(noteLabel);
            noteLabel.text = "最多￥\(model.orderFinalPrice ?? "0.00"),含发货邮费￥0.00";
            return sectionthreeHeadView;
            
        }else{
            
            return UIView.init();
            
        }

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.01;
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 2 {
            
            return 25;
        }
        
        return 10;

    }
    
}


extension ApplyForAfterSellVC:ReasonSelectViewDelegate,ReasonTFCellDelegate{
    func TFText(text: String) {
        return_explains = text;
        print("---->",return_explains );
    }
    
    func selectReason(reason: String, and index: Int) {
        print(reason);
        refundCashReason = reason
        refundCashReasonIndex = index;
        
        tableView.reloadData();
    }
    
    
    
}


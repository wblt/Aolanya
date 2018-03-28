//
//  MMLLeftVC.swift
//  Meimeila
//
//  Created by macos on 2017/12/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MMLLeftVCDelegate  {
    
    func pushToEditAddress(model:MMLLuckDrawModel)
    
}

class MMLLeftVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate:MMLLeftVCDelegate?
    
    var exchangeModel:MMLLuckDrawModel!
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLLeftVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name(rawValue: "refresh"), object: nil);
    }

    
    deinit {
        NotificationCenter.default.removeObserver(self);

    }
    
    
    @objc func refresh(){
        
        htttpRequest();
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        htttpRequest();

    }
    
    override func setupUI() {
     
        setTableView();
        bindRefresh();
    }
    
    lazy var headView:UILabel = {
        
        let v = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: 48))
        v.backgroundColor = UIColor.white;
        v.text = "亲,您的产品库空空如也噢~";
        v.textAlignment = .center;
        v.textColor = UIColor.black;
        return v;
    }()
    
    lazy var vm:MMLLuckDrawRecordViewModel = {
        let vm = MMLLuckDrawRecordViewModel();
        vm.tableView = self.tableView;
        return vm;
    }()
    
    var popWin:DDPopupWindowVC?
}

extension MMLLeftVC{
    
    
    func htttpRequest() {
        
        vm.getLuckDrawRecord {
            
            self.tableView.reloadData();
            
            if self.vm.modelArr.count == 0{
                self.tableView.tableHeaderView = self.headView;
            }else{
                self.tableView.tableHeaderView = nil;
            }
        }
    }
    
    
    
    func bindRefresh() {
        
        setupRefresh(tableView, isNeedFooterRefresh: true, headerCallback: {[weak self] in
            self?.vm.numberPages = 0;
            self?.htttpRequest();
        }) {[weak self] in
            self?.vm.numberPages += 1;
            self?.htttpRequest();
        }
    }
    
    func setTableView() {
        tableView.dataSource = self;
        tableView.delegate = self;

        tableView.showsVerticalScrollIndicator = false;
        
        tableView.register(UINib.init(nibName: String.init(describing: MMLGiftListCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLGiftListCell.self));
        
         tableView.register(UINib.init(nibName: String.init(describing: MMLGiftRuleCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLGiftRuleCell.self));
    }
    
    @objc func exchangeBtAction(bt:UIButton){
        
        let row = bt.tag - 11111;
        
        let model = vm.modelArr[row];
        
        if model.status! == 1{
            return;
        }else{
            
            popwinAlter(model: model);
            
            
        }

    }
    
    
    func popwinAlter(model:MMLLuckDrawModel) {
     
        exchangeModel = model;
        
        let title = "对否兑换\(model.prizename ?? "")"
        
        let pop = DDPopupWindowVC.init(message: title, leftButtonTitle: "取消", rightButtonTitle: "兑换")
        pop.modalPresentationStyle = .overFullScreen;
        popWin = pop;
        
        pop.delegate = self;
        self.present(pop, animated: false) {
            
        }
    }
    
}

extension MMLLeftVC:DDPopupWindowVCDelegate{
    func popupWindowVCLeftButtonAction(button: UIButton) {
        self.popWin?.dismiss(animated: false, completion: {
            
        })
    }
    
    func popupWindowRightVCButtonActtion(button: UIButton) {
        self.popWin?.dismiss(animated: false, completion: {[weak self] in
            
            self?.delegate?.pushToEditAddress(model: (self?.exchangeModel)!);

        })
    }
    
    
}

extension MMLLeftVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            
            var cell:MMLGiftRuleCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLGiftRuleCell.self)) as? MMLGiftRuleCell;
            
            if let _ = cell{}else{
                
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLGiftRuleCell.self), owner: nil, options: nil)?.last as? MMLGiftRuleCell;
            }
            cell?.separatorInset = UIEdgeInsetsMake(0, 0, 0, CGFloat(MAXFLOAT))
            cell?.selectionStyle = .none;
            
            return cell!;
        }
        
        
        var cell:MMLGiftListCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLGiftListCell.self)) as? MMLGiftListCell;
        
        if let _ = cell{}else{
            
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLGiftListCell.self), owner: nil, options: nil)?.last as? MMLGiftListCell;
        }
        cell?.selectionStyle = .none;
        cell?.exchangeBt.tag = indexPath.row + 11111;
        cell?.exchangeBt.addTarget(self, action: #selector(exchangeBtAction(bt:)), for: UIControlEvents.touchUpInside);
        cell?.setModel = vm.modelArr[indexPath.row];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
    
            return vm.modelArr.count;
        }
        
        return  1;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if  indexPath.section == 0 {
            return 64;
        }
        
        return 260;
    }
}

extension MMLLeftVC:UITableViewDelegate{
    
    
}

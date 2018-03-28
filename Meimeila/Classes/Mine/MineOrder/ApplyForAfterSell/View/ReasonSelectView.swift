//
//  ReasonSelectView.swift
//  Mythsbears
//
//  Created by macos on 2017/10/10.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
@objc protocol ReasonSelectViewDelegate{
    
    func selectReason(reason:String ,and index:Int)
    
}

class ReasonSelectView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI() {
        self.addSubview(tableView);
        self.addSubview(closedBt);
        addjustLayout();
    }
    
    func addjustLayout() {
      
        closedBt.snp.makeConstraints { (make) in
            
            make.bottom.equalToSuperview();
            make.left.equalToSuperview();
            make.right.equalToSuperview();
            make.height.equalTo(44);
        }
        
        
        tableView.snp.makeConstraints { (make) in
            
            make.bottom.equalToSuperview().offset(44);
            make.left.equalToSuperview();
            make.right.equalToSuperview();
            make.height.equalTo(Screen.width);
        }
    }
    
    
    lazy var tableView:UITableView = {
        
        let view = UITableView.init(frame: CGRect.zero, style: .plain);
        view.delegate = self;
        view.dataSource = self;
        view.tableFooterView = UIView.init();
        view.rowHeight = 44;
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: 44));
        label.text = "退款原因";
        label.textColor = UIColor.lightGray;
        label.backgroundColor = UIColor.white;
        label.textAlignment = .center;
        
        view.tableHeaderView = label;
        
        view.register(UINib.init(nibName: String.init(describing: SectionOneCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: SectionOneCell.self));
   
        return view;
    }()
    
    
    var reasonArr = ["商品与信息描述不符",
                     "质量问题",
                     "卖家缺货"]
    
    var btState = [false,false,false];
    
    lazy var closedBt:UIButton = {
        
        let bt = UIButton.init(type: UIButtonType.custom);
        bt.backgroundColor = DDGlobalNavBarColor();
        bt.setTitle("关闭", for: .normal);
        bt.setTitleColor(UIColor.white, for: .normal);
        bt.addTarget(self, action: #selector(closedBtAction(_:)), for: .touchUpInside);
        return bt;
    }()
    
    @objc func closedBtAction(_ sender:Any){
        
        self.removeFromSuperview();
    }
    
    
    weak var delegate:ReasonSelectViewDelegate?
    
}


extension ReasonSelectView{
    
    @objc func btAction(bt:UIButton){
        
        let selectIndex = bt.tag - 2220;
        
        for index in 0 ..< btState.count {
            
            if selectIndex == index{
                
                btState[index] = true
                delegate?.selectReason(reason: reasonArr[selectIndex], and: selectIndex)

            }else {
                
                btState[index] = false
                
            }
            
        }
        
        tableView.reloadData();
    }
    
}


extension ReasonSelectView:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        print(indexPath.row);
        
        let selectIndex = indexPath.row;
        
        for index in 0 ..< btState.count {
            
            if selectIndex == index{
                
                btState[index] = true
                
                delegate?.selectReason(reason: reasonArr[selectIndex], and: selectIndex)
                
            }else {
                
                btState[index] = false

            }
            
        }
        
        tableView.reloadData();
    }
    
}

extension ReasonSelectView:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:SectionOneCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: SectionOneCell.self)) as? SectionOneCell;
        if let _ = cell{}else{
            
            cell = Bundle.main.loadNibNamed(String.init(describing: SectionOneCell.self), owner: nil, options: nil)?.last as? SectionOneCell;
        }
        cell?.selectionStyle = .none;
        cell?.selectBt.tag = 2220 + indexPath.row;
        cell?.selectBt.addTarget(self, action: #selector(btAction(bt:)), for: UIControlEvents.touchUpInside);
        cell?.selectBt.isSelected = btState[indexPath.row];
        if indexPath.row == 0 {
            cell?.celltitleLB.text = "商品与信息描述不符";
        }else if indexPath.row == 1 {
            cell?.celltitleLB.text = "质量问题";
        }else{
            cell?.celltitleLB.text = "卖家缺货";

        }
        
        
        
        return cell!;
    }
}

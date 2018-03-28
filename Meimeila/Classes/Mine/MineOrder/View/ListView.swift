//
//  ListView.swift
//  Mythsbears
//
//  Created by macos on 2017/9/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum OriderListType :Int{
    case all = 0
    case waitPay
    case waitSend
    case waitGet
}


class ListView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white;
        
        setUI();
    };
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUI(){
    
        addSubview(tableView);
    }
    
    fileprivate func addjustLayout(){
    
        tableView.snp.makeConstraints { (make) in
            
            make.edges.equalToSuperview();
        }
    }
    
    fileprivate lazy var tableView:UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: Screen.height - 64 - 50), style: .grouped);
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 105;
        tableView.tableFooterView = UIView.init();
        tableView.backgroundColor = UIColor.RGB(r: 241, g: 241, b: 241);
        tableView.showsVerticalScrollIndicator = false;
        tableView.register(UINib.init(nibName: String.init(describing: MineCollectCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MineCollectCell.self));
        return tableView;
    
    }()
    
    var type = OriderListType.all
    
}


extension ListView:UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row);
    }
}

extension ListView:UITableViewDataSource{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MineCollectCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MineCollectCell.self)) as? MineCollectCell;
        cell?.separatorInset.left = 0;
        cell?.selectionStyle = .none;
        if let _ = cell {
            
        }else{
        
            cell = Bundle.main.loadNibNamed(String.init(describing: MineCollectCell.self), owner: nil, options: nil)?.last as? MineCollectCell;
        }
        
        return cell!;
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = SectionHeadView.init(frame: CGRect.zero);
        return view;
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44 + 10;
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view:SecctionFootView = SecctionFootView.init(frame: CGRect.zero);
        
        return view;
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 44 + 50;
    }
    
   }




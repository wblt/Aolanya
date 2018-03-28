//
//  MoreListView.swift
//  Mythsbears
//
//  Created by macos on 2017/10/26.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MoreListViewDelegate {
    
    func didSelectRow(row:Int,title:String)
    
}

class MoreListView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI(){
        self.backgroundColor = UIColor.white;
        addSubview(tableView);
    }
    
    
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width/3 + 20, height: 44 * 4), style: UITableViewStyle.plain);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 44;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String.init(describing: UITableViewCell.self));
        tableView.isScrollEnabled = false;
        tableView.tableFooterView = UIView();
        tableView.separatorInset.left = 0;
        return tableView;
    }()
    
    var titleArr = ["设备搜索","水油数据","使用教程","音乐设置"];
    var imageArr = ["mall_search","mall_search","mall_search","mall_search"];

    weak var delagate:MoreListViewDelegate?
}

extension MoreListView:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let row = indexPath.row;
    
        
        self.delagate?.didSelectRow(row: row, title: titleArr[row]);
    }
}

extension MoreListView:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: UITableViewCell.self));
        
        if let _ = cell {}
        else{
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: String.init(describing: UITableViewCell.self));
        }
        
        cell?.textLabel?.text = titleArr[indexPath.row];
        cell?.imageView?.image = UIImage.init(named: imageArr[indexPath.row]);
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 16);
        return cell!;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (titleArr.count);
    }
}


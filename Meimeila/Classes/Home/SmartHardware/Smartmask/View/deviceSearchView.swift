//
//  deviceSearchView.swift
//  Mythsbears
//
//  Created by macos on 2017/10/26.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol DeviceSearchViewDelegate {
    
    func starToSearchDevice()

    func starToConnrct(peripheral:CBPeripheral)
    
    
}

class DeviceSearchView: UIView {

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
        addSubview(bt);
    }
    
    
    @objc func dismissView(){
        isShow = false;
        self.removeFromSuperview();
    }
    
    lazy var tableView:UITableView = {[weak self] in
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width * 2 / 3, height: Screen.width/2 + 39), style: UITableViewStyle.plain);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 44;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String.init(describing: UITableViewCell.self));
        tableView.isScrollEnabled = false;
        tableView.tableFooterView = UIView();
        tableView.separatorInset.left = 0;
        tableView.tableHeaderView = self?.headView;
        tableView.tableFooterView = UIView();
        return tableView;
    }()
    
    
    lazy var headView:UILabel = {
        let view = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width * 2 / 3, height: 39));
        view.text = "设备搜索";
        view.textColor = UIColor.white;
        view.textAlignment = .center;
        view.backgroundColor = UIColor.RGB(r: 58, g: 58, b: 58);
        return view;
    }()
    
    
    lazy var bt:UIButton = {
        
        let bt = UIButton.init(type: UIButtonType.custom);
        bt.setTitle("取消", for: UIControlState.normal);
        bt.setTitleColor(UIColor.darkGray, for: UIControlState.normal);
        bt.frame = CGRect.init(x: (Screen.width * 2 / 3 - Screen.width/5)/2, y: Screen.width / 2 + 39, width: Screen.width/5, height: 39)
        bt.addTarget(self, action: #selector(dismissView), for: UIControlEvents.touchUpInside);
        return bt;
    }()
    
    
    
    var peripheralArr = [CBPeripheral]()
    
    weak var delagate:DeviceSearchViewDelegate?
    
    var isShow:Bool = false;
        

}

extension DeviceSearchView:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let row = indexPath.row;
        
        delagate?.starToConnrct(peripheral: peripheralArr[row]);
        self.dismissView();
    }
}

extension DeviceSearchView:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: UITableViewCell.self));
        
        if let _ = cell {}
        else{
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: String.init(describing: UITableViewCell.self));
        }
        
        let p = peripheralArr[indexPath.row];
        cell?.textLabel?.text = "\(p.identifier.uuidString)"
        cell?.textLabel?.textAlignment = .center;
        return cell!;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (peripheralArr.count);
    }

}

//
//  MMLPocketHeadView.swift
//  Meimeila
//
//  Created by macos on 2017/10/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLPocketHeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = RGB_App_Green;
        setUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        addSubview(label);
        addSubview(money);
        
        setLayout();
    }
    
    func setLayout() {
       
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24);
            make.top.equalToSuperview().offset(30);
            make.height.equalTo(20);
            make.right.equalToSuperview().offset(-34);
        }
        
        money.snp.makeConstraints { (make) in
            make.left.equalToSuperview();
            make.bottom.equalToSuperview();
            make.height.equalTo(150);
            make.right.equalToSuperview();
        }
        
    }
    
    lazy var label:UILabel = {
        let view = UILabel.init();
        view.text = "账户余额(元)";
        view.textColor = UIColor.white;
        view.font = UIFont.systemFont(ofSize: 15);
        view.backgroundColor = UIColor.clear;
        return view;
    }()
 
    lazy var money:UILabel = {
        let view = UILabel.init();
        view.text = "0.00";
        view.textColor = UIColor.white;
        view.font = UIFont.systemFont(ofSize: 80);
        view.backgroundColor = UIColor.clear;
        view.textAlignment = .center;
        return view;
    }()
    
    
    var isHealthBean = false
    
}

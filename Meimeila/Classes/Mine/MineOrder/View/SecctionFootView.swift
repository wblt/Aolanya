//
//  SecctionFootView.swift
//  Mythsbears
//
//  Created by macos on 2017/9/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class SecctionFootView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setUI();
        adjustLayout();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    fileprivate   func setUI() {
        
        addSubview(titleLabel);
        addSubview(line);
        addSubview(btRight);
        addSubview(btLeft);
        addSubview(modifyMessageBt);
    }
    
    
    func adjustLayout(){
        
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.right.equalToSuperview().offset(-16);
            make.top.equalToSuperview();
            make.left.equalToSuperview();
            make.height.equalTo(44);
        }

        line.snp.makeConstraints { (make) in
            
            make.height.equalTo(1);
            make.top.equalTo(titleLabel.snp.bottom);
            make.left.equalToSuperview();
            make.right.equalToSuperview();
        }
        
        btRight.snp.makeConstraints { (make) in
            
            make.top.equalTo(line.snp.bottom).offset(8);
            make.bottom.equalToSuperview().offset(-8);
            make.right.equalToSuperview().offset(-16);
            make.width.equalTo(80);
        }
        
        
        btLeft.snp.makeConstraints { (make) in
            
            make.top.equalTo(line.snp.bottom).offset(8);
            make.bottom.equalToSuperview().offset(-8);
            make.right.equalTo(btRight.snp.left).offset(-16);
            make.width.equalTo(80);
        }
        
        
        modifyMessageBt.snp.makeConstraints { (make) in
            
            make.top.equalTo(line.snp.bottom).offset(8);
            make.bottom.equalToSuperview().offset(-8);
            make.right.equalTo(btLeft.snp.left).offset(-16);
            make.width.equalTo(80);
        }
    }
    
    lazy var titleLabel:UILabel = {
        
        let label = UILabel.init(frame: CGRect.zero);
        label.font = UIFont.systemFont(ofSize: 13);
        label.textColor = UIColor.lightGray;
        label.textAlignment = .right;
        label.text = "共1件商品 合计：￥168.00(含运费￥0.00)";
        
        return label;
    }()
    

    lazy var line:UIView = {
    
        let view = UIView.init(frame: CGRect.zero);
        view.backgroundColor = UIColor.RGB(r: 245, g: 245, b: 245);
        return view;
    
    }()
    
    lazy var btLeft:UIButton = {
    
        let bt:UIButton = UIButton.init(type: UIButtonType.custom);
        bt.setTitle("----", for: .normal);
        bt.setTitleColor(UIColor.lightGray, for: .normal);
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 16.0);
        bt.layer.borderColor = UIColor.lightGray.cgColor;
        bt.layer.borderWidth = 1.0;
        bt.layer.cornerRadius = 5.0;
        
        return bt;
    }()
    
    
    lazy var btRight:UIButton = {
        
        let bt:UIButton = UIButton.init(type: UIButtonType.custom);
        bt.setTitle("----", for: .normal);
	  //bt.setTitleColor(DDGlobalNavBarColor(), for: .normal);
		bt.setTitleColor(UIColor.lightGray, for: .normal);
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 16.0);
       // bt.layer.borderColor = DDGlobalNavBarColor().cgColor;
		bt.layer.borderColor = UIColor.lightGray.cgColor;
        bt.layer.borderWidth = 1.0;
        bt.layer.cornerRadius = 5.0;

        return bt;
    }()
    

    lazy var modifyMessageBt:UIButton = {
        
        let bt:UIButton = UIButton.init(type: UIButtonType.custom);
        bt.setTitle("----", for: .normal);
        bt.setTitleColor(UIColor.lightGray, for: .normal);
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 16.0);
        bt.layer.borderColor = UIColor.lightGray.cgColor;
        bt.layer.borderWidth = 1.0;
        bt.layer.cornerRadius = 5.0;
        
        return bt;
    }()
    
}

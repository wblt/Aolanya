//
//  SectionHeadView.swift
//  Mythsbears
//
//  Created by macos on 2017/9/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class SectionHeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        backgroundColor = UIColor.white;
        setUI();
        adjustLayout();

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
 fileprivate   func setUI() {
    
        addSubview(line);
        addSubview(timeLabel);
        addSubview(titleLabel);
    }
    
    
    func adjustLayout(){
        
        line.snp.makeConstraints { (make) in
            
            make.top.equalToSuperview();
            make.left.equalToSuperview();
            make.right.equalToSuperview();
            make.height.equalTo(10);
        }
        
        timeLabel.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(16);
            make.top.equalTo(line.snp.bottom);
            make.bottom.equalToSuperview();
        }
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.right.equalToSuperview().offset(-16);
            make.top.equalTo(line.snp.bottom);
            make.bottom.equalToSuperview();
        }
        
    }
    
    
    lazy var line:UIView = {
        
        let view = UIView.init(frame: CGRect.zero);
        view.backgroundColor = UIColor.RGB(r: 245, g: 245, b: 245);
        return view;
        
    }()
    
    
    lazy var timeLabel:UILabel = {
    
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 16);
        label.textColor = UIColor.lightGray;
        label.textAlignment = .left;
        label.text = "2017-08-31 10:25:08"
        return label;
    }()
    
    
    lazy var titleLabel:UILabel = {
        
        let label = UILabel.init(frame: CGRect.zero);
        label.font = UIFont.systemFont(ofSize: 16);
        label.textColor = UIColor.lightGray;
        label.textAlignment = .right;
        label.text = "------";
        return label;
    }()
    

    
}

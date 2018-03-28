//
//  MMLAboutUsHeadView.swift
//  Meimeila
//
//  Created by macos on 2017/11/25.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLAboutUsHeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        setUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var icon:UIImageView = {
        let view = UIImageView.init(image: UIImage.init(named: "1024"));
        view.layer.cornerRadius = 65;
        view.clipsToBounds = true;
        return view;
    }()
    
    lazy var title:UILabel = {
        let view = UILabel.init(frame: CGRect.zero);
        view.text = "美美啦";
        view.textAlignment = .center;
        view.textColor = UIColor.white;
        return view;
    }()
    
    
    
}

extension MMLAboutUsHeadView{
    
    func setUI() {
        self.backgroundColor = APPgreenColor;
        self.addSubview(icon);
        self.addSubview(title);
    
        icon.snp.makeConstraints { (make) in
            make.width.equalTo(130);
            make.height.equalTo(130);
            make.top.equalToSuperview().offset(50);
            make.centerX.equalToSuperview();
        }
    
        
        title.snp.makeConstraints { (make) in
            make.width.equalTo(100);
            make.height.equalTo(20);
            make.top.equalToSuperview().offset(200);
            make.centerX.equalToSuperview();
        }
        
    
    }

}

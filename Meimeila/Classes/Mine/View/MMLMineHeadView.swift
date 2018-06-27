//
//  MMLMineHeadView.swift
//  Meimeila
//
//  Created by macos on 2017/10/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMineHeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        setUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI() {
        backgroundColor = RGB_App_Green;
        addSubview(headIconBt);
        addSubview(nickNameLabel);
        addSubview(btCollectionView);
        
        addSubview(loginBt);
        
        setLayout();
    }
 
    func setLayout() {
        
        headIconBt.snp.makeConstraints { (make) in
            
            make.width.equalTo(100.0);
            make.height.equalTo(100.0);
            make.top.equalToSuperview().offset(20);
            make.centerX.equalToSuperview();
        }
    
        nickNameLabel.snp.makeConstraints { (make) in
            
            make.height.equalTo(20.0);
            make.top.equalTo(headIconBt.snp.bottom).offset(5);
            make.width.equalTo(Screen.width/2);
            make.centerX.equalToSuperview();
        }
        
        
        btCollectionView.snp.makeConstraints { (make) in
            
            make.height.equalTo(64.0);
            make.left.equalToSuperview();
            make.right.equalToSuperview();
            make.bottom.equalToSuperview();
        }
        
        
        loginBt.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(Screen.width/3);
            make.right.equalToSuperview().offset(-Screen.width/3);
            make.height.equalTo(44);
            make.top.equalToSuperview().offset(34);
            make.centerX.equalToSuperview();
        }
        
        
    }
    
    
    var cellDateArr = [["name":"全部订单","icon":"icon_allOrderList"],
                       ["name":"待付款","icon":"icon_waitPay"],
                       ["name":"待收货","icon":"icon_waitGet"],
                       ["name":"已完成","icon":"icon_orderFinish"]];
	var cellDateArr1 = [["name":"全部订单","icon":"icon_allOrderList"],
					   ["name":"待审核","icon":"icon_waitPay"],
					   ["name":"待收货","icon":"icon_waitGet"],
					   ["name":"已完成","icon":"icon_orderFinish"]];

	
	
    lazy var flayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout.init();
        layout.itemSize = CGSize.init(width: Screen.width/4, height: 64)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        return layout;
    }()
    
    lazy var btCollectionView:UICollectionView = {
        let view = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flayout);
        view.isScrollEnabled = false;
        view.dataSource = self;
        view.delegate = self;
        view.backgroundColor = UIColor.white;
        view.register(UINib.init(nibName: String.init(describing: MMLHeadBtCell.self), bundle: nil), forCellWithReuseIdentifier: String.init(describing: MMLHeadBtCell.self));
        
        return view;
    }()
    
    
    lazy var headIconBt:UIButton = {
        let bt = UIButton.init(type: UIButtonType.custom);
        bt.layer.cornerRadius = 50;
        bt.clipsToBounds = true;
        bt.setImage(UIImage.init(named: "icon_defaultHeadIcon"), for: .normal);
        return bt;
    }()
    
    var nickNameLabel:UILabel = {
        
        let view = UILabel.init();
        view.textColor = UIColor.white;
        view.textAlignment = .center;
        view.text = "魅族MX7";
        return view;
    }()
 
    lazy var loginBt:UIButton = {
        let bt = UIButton.init(type: UIButtonType.custom);
        bt.layer.cornerRadius = 22;
        bt.layer.borderWidth = 1.0;
        bt.layer.borderColor = UIColor.white.cgColor;
        bt.backgroundColor = RGB_App_Green;
        bt.setTitle("登录", for: UIControlState.normal);
        bt.addTarget(self, action: #selector(pushLoginVC), for: UIControlEvents.touchUpInside);
        return bt;
    }()
    
    var currentVC:DDBaseViewController?
}


extension MMLMineHeadView {
    
    
    @objc func pushLoginVC() {
       currentVC?.navigationController?.pushViewController(MMLLoginVC(), animated: true);
    }
    
    
    
    func loginStatue(_ isLogin:Bool) {
        
        if isLogin {
            
            headIconBt.isHidden = false;
            nickNameLabel.isHidden = false;
            loginBt.isHidden = true;
        }else {
            
            headIconBt.isHidden = true;
            nickNameLabel.isHidden = true;
            loginBt.isHidden = false;
        }
        
    }
    
}


extension MMLMineHeadView:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("我的头部按钮->",indexPath.row);
        
        let loginStatue = DDDeviceManager.shared.loginStatue();
        if !loginStatue {
            let vc = MMLLoginVC()
            currentVC?.navigationController?.pushViewController(vc, animated: true);
            
            return;
        }
        
        let vc = MSXMineOrderListsVC();
        
        if indexPath.row == 0 {
            vc.selectPage = 0;
        }else if indexPath.row == 1 {
            vc.selectPage = 1;

        }else if indexPath.row == 2 {
            vc.selectPage = 2;

        }else if indexPath.row == 3 {
            vc.selectPage = 3;

        }
        
        currentVC?.navigationController?.pushViewController(vc, animated: true);
    }
}

extension MMLMineHeadView:UICollectionViewDataSource{
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MMLHeadBtCell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: MMLHeadBtCell.self), for: indexPath) as! MMLHeadBtCell;
        
		var dic = cellDateArr[indexPath.row];
		if DDUDManager.share.getInviter() != "" {
			dic = cellDateArr1[indexPath.row];
		}else {
			dic = cellDateArr[indexPath.row];
		}
        cell.setDic = dic;
        return cell;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDateArr.count;
    }
}

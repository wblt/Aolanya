//
//  ButtonHeadView.swift
//  Mythsbears
//
//  Created by macos on 2017/9/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class ButtonHeadView: UIView {

   
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setUI();
        addjustLayout();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    func setUI() {
        
        addSubview(btCollectionView);
    }
    
    
    func addjustLayout() {
        btCollectionView.snp.makeConstraints { (make) in
            
            make.edges.equalToSuperview();
        }
        
    }
    
    
    
    lazy var btCollectionView:UICollectionView = {
    
        let flowLayout = UICollectionViewFlowLayout.init();
        flowLayout.scrollDirection = .horizontal;
        flowLayout.itemSize = CGSize.init(width: Screen.width/4, height: 44.0);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.isScrollEnabled = false;
        collectionView.backgroundColor = UIColor.white;
        
        collectionView.register(btCollectionViewCell.self, forCellWithReuseIdentifier: String.init(describing: btCollectionViewCell.self));
        
        return collectionView;
    }()
    
    
    
    lazy var titleArr = ["全部","待付款","待发货","待收货"];
    
    
    
}




extension ButtonHeadView:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("select",indexPath.row);
    }

}

extension ButtonHeadView:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell:btCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: btCollectionViewCell.self), for: indexPath) as! btCollectionViewCell ;
        
        cell.btTitleLabel.text = titleArr[indexPath.row];
        return cell;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4;
    }
    
    
}



class btCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        adjustLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private method
    private func setupUI () {
        contentView.backgroundColor = UIColor.white;
        contentView.addSubview(btTitleLabel)
    }
    
    private func adjustLayout() {
        btTitleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: -lazy load
    var btTitleLabel: UILabel = {
        
        let label = UILabel.init();
        label.text = "--";
        label.textAlignment = .center;
        label.font = UIFont.systemFont(ofSize: 16);
        label.textColor = UIColor.darkGray;
        return label;
    
    }()
}





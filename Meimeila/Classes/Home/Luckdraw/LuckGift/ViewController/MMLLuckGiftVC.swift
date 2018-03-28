//
//  MMLLuckGiftVC.swift
//  Meimeila
//
//  Created by macos on 2017/12/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLLuckGiftVC: DDBaseViewController {

    @IBOutlet weak var btLeft: UIButton!
    
    
    @IBOutlet weak var btRight: UIButton!
    
    @IBAction func btLeftAction(_ sender: Any) {
        btLeft.isSelected = true;
        btRight.isSelected = false;
        
        setLine_x(x: 0)
        
        
        
    }
    
    
    @IBAction func btRightAction(_ sender: Any) {
        btLeft.isSelected = false;
        btRight.isSelected = true;
        setLine_x(x: 1)
    }
    
    
    @IBOutlet weak var lineView: UIView!
  
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btLeft.isSelected = true;
    }

    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLLuckGiftVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupUI() {
        setCollectionView();
        
    }
    
    lazy var vcArr:[UIViewController] = {
        
        var arr = [UIViewController]();
        
        let vc0 = MMLLeftVC();
        
        vc0.delegate = self;
        
        let vc1 = MMLRightVC();
        arr.append(vc0);
        arr.append(vc1);
        return arr;
    }()
}


extension MMLLuckGiftVC:MMLLeftVCDelegate{
    func pushToEditAddress(model: MMLLuckDrawModel) {
        
        let vc = MMLExchangeGiftAddressVC();
        vc.exchangeModel = model;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
}

    
extension MMLLuckGiftVC{
    
    func setCollectionView() {
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.bounces = false;
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.isPagingEnabled = true;
        collectionView.isScrollEnabled = false;
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String.init(describing: UICollectionViewCell.self));
    }
    
    
    func setLine_x(x:Int) {
        
        UIView.animate(withDuration: 0.2) {
            
            var fram = self.lineView.frame ;
            let w = fram.size.width;
            
            fram.origin.x = w * CGFloat(x)
            
            self.lineView.frame = fram;
            
        }
        
        setCollection_x(x: x);
    }
    
    
    func setCollection_x(x:Int) {
        
        collectionView.setContentOffset(CGPoint.init(x: (Screen.width) * CGFloat(x), y: 0), animated: true);
        
    }
    
}

extension MMLLuckGiftVC:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return vcArr.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: UICollectionViewCell.self), for: indexPath);
        
        // 2.设置cell的内容
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let vc = vcArr[indexPath.row];
        vc.view.frame = cell.bounds;
        cell.contentView.addSubview(vc.view);
        return cell;
    }
    
    
}

extension MMLLuckGiftVC:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}

extension MMLLuckGiftVC:UICollectionViewDelegate{
    
    
}




//
//  MSXMineOrderListsVC.swift
//  Mythsbears
//
//  Created by macos on 2017/9/25.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import FDStackView

class MSXMineOrderListsVC: DDBaseViewController {

    
    @IBOutlet weak var allBt: UIButton!
    
   
    @IBOutlet weak var waitPayBt: UIButton!
    
    @IBOutlet weak var waitSendBt: UIButton!
    
    
    @IBOutlet weak var waitGetBt: UIButton!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var btBGView: FDStackView!
    
    var selectPage:Int = 0;
    
    lazy var btLine:UIView = {
    
        let view = UIView.init(frame: CGRect.init(x: 0, y:42, width: Screen.width/4 - 20, height: 2.0));
        view.layer.cornerRadius = 1;
        view.backgroundColor = DDGlobalNavBarColor();

        return view;
    }()
    
    var btArr = [UIButton]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的订单";
        
        setUI();
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        

    }
    
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing:String.init(describing: MSXMineOrderListsVC.self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        
        btArr.append(allBt);
        btArr.append(waitPayBt);
        btArr.append(waitSendBt);
        btArr.append(waitGetBt);
        btBGView.addSubview(btLine);

        
        
        setCollectionView();
    
        addRightNavBarBt();
    }
    
    

    @IBAction func btAction(_ sender: Any) {

        let bt = sender as! UIButton;
        let tag = bt.tag - 110;
        
        selectPage = tag;
        
        selectBt();
    }
    
    
    func  selectBt() {
        
        for (index,bt) in btArr.enumerated() {
            
            if index == selectPage {
                
                bt.setTitleColor(DDGlobalNavBarColor(), for: .normal);
            
                setLine_X(bt);
                
            }else{
            
                bt.setTitleColor(UIColor.RGB(r: 63, g: 63, b: 63), for: .normal);

            }
        }
        
    }
    
    //右边
    func addRightNavBarBt() {
        
        addNavBarRightButton(imageName: "icon_shopCar") { (bt) in
            print("购物车!");
            self.navigationController?.popToRootViewController(animated: false);
            Barista.post(notification: Barista.Notification.gotoHome, object: nil);
            
            
        }
        
    }
    
    func setLine_X(_ bt:UIButton) {
        
        UIView.animate(withDuration: 0.2) { 
          
            self.btLine.frame.origin.x = Screen.width/4 * CGFloat(self.selectPage) + 10;
        };
        
        setPage_X();
    }
    
    
    func setPage_X() {
        
        collectionView.contentOffset.x = CGFloat(selectPage) * Screen.width;
    }
    
    
   fileprivate func  setCollectionView() {
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollsToTop = false;
    collectionView.showsHorizontalScrollIndicator = false;
    collectionView.backgroundColor = UIColor.white;
    collectionView.isPagingEnabled = true;
    collectionView.bounces = false;
    
//    collectionView.contentOffset = CGPoint.init(x: Screen.width * CGFloat(selectPage), y: 0);
    
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String.init(describing: UICollectionViewCell.self));
    
    }

    
    lazy  var childrenVCArr:[UIViewController] = { [weak self] in
    
        var arr = [UIViewController]();
        
        let all = MMLAllList();
        arr.append(all);
        
        let pay = MMLWaitPay();
        arr.append(pay);
    
        let send = MMLWaitGet();
        arr.append(send);
        
        let get = MMLFinish();
        arr.append(get);
        
        self?.addChildViewController(all);
        self?.addChildViewController(pay);
        self?.addChildViewController(send);
        self?.addChildViewController(get);
    
        return arr;
        
    }()
    
    
  }





extension MSXMineOrderListsVC:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      let count =  childrenVCArr.count;
        
        selectBt();

        return count;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: UICollectionViewCell.self), for: indexPath)
        
        // 2.设置cell的内容
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let childVc = childrenVCArr[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell;

    }
}


extension MSXMineOrderListsVC:UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}


extension MSXMineOrderListsVC:UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size;
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0;
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0;
    }
}

extension MSXMineOrderListsVC:UIScrollViewDelegate{

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage =  scrollView.contentOffset.x/Screen.width;
                
        selectPage = Int(currentPage);
        selectBt();

    }

}

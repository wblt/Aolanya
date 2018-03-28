//
//  MMLMineOrderVC.swift
//  Meimeila
//
//  Created by macos on 2017/10/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import FDStackView


class MMLMineOrderVC: DDBaseViewController {
    
    @IBOutlet weak var allOrderListBt: UIButton!
    
    @IBOutlet weak var btBGView: UIView!
    
    @IBOutlet weak var waitPayBt: UIButton!
    
    @IBOutlet weak var waitGetBt: UIButton!
    
    @IBOutlet weak var finishBt: UIButton!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBAction func allOrderListBtAction(_ sender: Any) {
        
        selectBt = 0;
        setPage_Bt_Line();
    }
    
    @IBAction func waitPayBtAction(_ sender: Any) {
        selectBt = 1;
        setPage_Bt_Line();
    }
    
    
    @IBAction func waitGetBtAction(_ sender: Any) {
        selectBt = 2;
        setPage_Bt_Line();
    }
    
    
    @IBAction func finishBtAction(_ sender: Any) {
        selectBt = 3;
        setPage_Bt_Line();
    }
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLMineOrderVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
     
    }
    
    override func setupUI() {
        
        btBGView.addSubview(selectLine);
        
        addRightNavBarBt();
        setCollectionView();
        setPage_Bt_Line();
    }

    //右边
    func addRightNavBarBt() {
        
        addNavBarRightButton(imageName: "icon_shopCar") { (bt) in
            print("购物车!");
        self.navigationController?.popToRootViewController(animated: false);
            Barista.post(notification: Barista.Notification.gotoHome, object: nil);

            
        }
       
    }
    
    //
    func setCollectionView() {
        
//        collectionView.collectionViewLayout = flayout;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollsToTop = false;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.backgroundColor = UIColor.white;
        collectionView.isPagingEnabled = true;
        collectionView.bounces = false; collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String.init(describing: UICollectionViewCell.self));
    }
    

    
    lazy var chileVCArr :[DDBaseViewController] = {[weak self] in
        
        var arr = [DDBaseViewController]();
        let vc1 = MMLAllList();
        let vc2 = MMLWaitPay();
        let vc3 = MMLWaitGet();
        let vc4 = MMLFinish();
        
        self?.addChildViewController(vc1);
        self?.addChildViewController(vc2);
        self?.addChildViewController(vc3);
        self?.addChildViewController(vc4);
        
        arr.append(vc1);
        arr.append(vc2);
        arr.append(vc3);
        arr.append(vc4);
        return arr;
    }()
    
    lazy var btArr:[UIButton] = {[weak self] in
        var arr = [UIButton]();
        arr.append((self?.allOrderListBt)!);
        arr.append((self?.waitPayBt)!);
        arr.append((self?.waitGetBt)!);
        arr.append((self?.finishBt)!);
        return arr;
    }()
    
    lazy var selectLine:UIView = {[weak self] in
        let line = UIView.init();
        line.backgroundColor = RGB_App_Green;
        line.frame = CGRect.init(x: CGFloat((selectBt)) * Screen.width/4, y: 44, width: Screen.width/4, height: 2);
        return line;
    }()
    
    var selectBt:Int = 0;
}


extension MMLMineOrderVC {
    
    fileprivate func setPage_Bt_Line(){
        setSelectBtColor();
        setLine_x();
        setPage();
    }
    
    //按钮变色
  fileprivate  func setSelectBtColor() {
        
        for (index,item) in btArr.enumerated() {
            
            if selectBt == index {
                item.isSelected = true;
            }else {
                item.isSelected = false;
            }
        }
    }
    
   fileprivate func setLine_x() {
        
    let page = selectBt;

        UIView.animate(withDuration: 0.3) {[weak self] in

            let x = (CGFloat(page) * (Screen.width/4));

            self?.selectLine.frame = CGRect.init(x: x, y: (self?.selectLine.frame.origin.y)!, width: Screen.width/4, height: 2);
        }
    
    }
    
    
  fileprivate  func setPage() {
    let page = selectBt;
    
    let xx = CGFloat(page) * Screen.width;
    self.collectionView.setContentOffset(CGPoint.init(x: xx, y: 0), animated: true);
    
    print(self.collectionView.contentOffset.x);
    
    }
}

extension MMLMineOrderVC:UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let x = scrollView.contentOffset.x;
        let page = x/Screen.width;
        
        switch page {
        
        case 0.0:
            selectBt = 0;
        case 1.0:
            selectBt = 1;
        case 2.0:
            selectBt = 2;
        case 3.0 :
            selectBt = 3;
        default:
            return;
        }
        
        setPage_Bt_Line();
    }
}

extension MMLMineOrderVC:UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: UICollectionViewCell.self), for: indexPath);
        
        // 2.设置cell的内容
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let vc = chileVCArr[indexPath.row];
        vc.view.frame = cell.contentView.bounds;
        cell.contentView.addSubview(vc.view);
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chileVCArr.count;
    }
}

extension MMLMineOrderVC:UICollectionViewDelegateFlowLayout{
    
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


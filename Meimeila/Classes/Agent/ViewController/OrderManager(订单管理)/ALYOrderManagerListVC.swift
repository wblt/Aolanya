//
//  ALYOrderManagerListVC.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/17.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import FDStackView

class ALYOrderManagerListVC: DDBaseViewController {
	
	var name:String?
	
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var notSureBtn: UIButton!
	
	@IBOutlet weak var notSendBtn: UIButton!
	
	@IBOutlet weak var notReceiveBtn: UIButton!
	
	@IBOutlet weak var finshBtn: UIButton!
	
	@IBOutlet weak var btBGView: FDStackView!
	
	@IBAction func noSureAction(_ sender: Any) {
		let bt = sender as! UIButton;
		let tag = bt.tag - 110;
		
		selectPage = tag;
		
		selectBt();
	}
	
	@IBAction func notSendAction(_ sender: Any) {
		let bt = sender as! UIButton;
		let tag = bt.tag - 110;
		
		selectPage = tag;
		
		selectBt();
	}
	
	@IBAction func notReceiveAction(_ sender: Any) {
		let bt = sender as! UIButton;
		let tag = bt.tag - 110;
		
		selectPage = tag;
		
		selectBt();
	}
	
	@IBAction func finishAction(_ sender: Any) {
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

        // Do any additional setup after loading the view.
		self.title =  "\(name)的订单"
		setUI()
    }

	// 如果不写这个方法，iOS8会崩溃
	init() {
		super.init(nibName: String.init(describing:String.init(describing: ALYOrderManagerListVC.self)), bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setUI() {
		
		btArr.append(notSureBtn);
		btArr.append(notSendBtn);
		btArr.append(notReceiveBtn);
		btArr.append(finshBtn);
		btBGView.addSubview(btLine);
		
		setCollectionView();
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
		
		let vc1 = ALYNotSureVC();
		arr.append(vc1);
		
		let vc2 = ALYNotSendVC();
		arr.append(vc2);
		
		let vc3 = ALYNotRecivedVC();
		arr.append(vc3);
		
		let vc4 = AYLFinishVCViewController();
		arr.append(vc4);
		
		self?.addChildViewController(vc1);
		self?.addChildViewController(vc2);
		self?.addChildViewController(vc3);
		self?.addChildViewController(vc4);
		
		return arr;
		
		}()
	
	
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ALYOrderManagerListVC:UICollectionViewDataSource{
	
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


extension ALYOrderManagerListVC:UICollectionViewDelegate{
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		
	}
	
}


extension ALYOrderManagerListVC:UICollectionViewDelegateFlowLayout{
	
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

extension ALYOrderManagerListVC:UIScrollViewDelegate{
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let currentPage =  scrollView.contentOffset.x/Screen.width;
		
		selectPage = Int(currentPage);
		selectBt();
		
	}
	
}

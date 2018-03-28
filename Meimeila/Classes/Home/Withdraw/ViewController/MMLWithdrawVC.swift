//
//  MMLWithdrawVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLWithdrawVC: DDBaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var withdrawButton: UIButton!
    @IBOutlet weak var withdrawRecordButton: UIButton!
    
    // 记录当前选中的按钮
    private var currentSelectedButton: UIButton = UIButton()

    
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLWithdrawVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我要提现"
    }

    override func setupUI() {
        currentSelectedButton = withdrawButton
        withdrawButton.layer.masksToBounds = true
        withdrawButton.layer.cornerRadius = 5
        withdrawRecordButton.layer.masksToBounds = true
        withdrawRecordButton.layer.cornerRadius = 5
        setupCollectionView()
    }
    
    // MARK: - Private method
    private func setupCollectionView() {
        collectionView.scrollsToTop = false
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String.init(describing: UICollectionViewCell.self))
        collectionView.backgroundColor = UIColor.clear
    }
    

    
    // MARK: - Event respose
    // 提现或者提现记录
    @IBAction func withdrawOrRecordAction(_ sender: Any) {
        let button = (sender as! UIButton)
        let index = (button.tag)
        if currentSelectedButton == button {
            
        }else {
            currentSelectedButton.setTitleColor(UIColor.black, for: .normal)
            currentSelectedButton.backgroundColor = UIColor.white
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor.red
            currentSelectedButton = button
        }
        
        // 2.滚动正确的位置
        let offsetX = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
    
    // MARK: - lazy load
    fileprivate lazy var childVCS: [UIViewController] = {[weak self] in
        var vcs = [UIViewController]()
        let vc = MMLWithdrawChildVC.init()
        vcs.append(vc)
        
        let vc1 = MMLWithdrawalRecordVC.init()
        vcs.append(vc1)
        
        self?.addChildViewController(vc)
        self?.addChildViewController(vc1)
        
        return vcs
        }()
    


}

// MARK: - UICollectionViewDataSource
extension MMLWithdrawVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCS.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: UICollectionViewCell.self), for: indexPath)
        
        // 2.设置cell的内容
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let childVc = childVCS[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MMLWithdrawVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 设置水平间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MMLWithdrawVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 当前选中的索引
        let index = scrollView.contentOffset.x / scrollView.width
        let button = index == 0 ? withdrawButton : withdrawRecordButton
        withdrawOrRecordAction(button as Any)
        debugLog(index)
    }
}

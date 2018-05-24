//
//  MMLShareVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/18.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

protocol MMLShareVCDelegate: NSObjectProtocol {
    func shareModule(moduleType: UMShareType)
}

class MMLShareVC: UIViewController {

    weak var delegate: MMLShareVCDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    
    init() {
        super.init(nibName: String.init(describing: MMLShareVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        setupCollectionView()

    }

    // MARK: - Private methods
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: (Screen.width - 30) / 3.0, height: CGFloat(60))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: String.init(describing: MMLShareCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String.init(describing: MMLShareCollectionViewCell.self))
    }

    // MARK: - Event respose
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    fileprivate lazy var moduleDatas: [Dictionary<String, Any>] = {
        var datas = Array<Any>.init()
        datas.append(["title":"微信朋友圈", "iconName":"wechat_circle_friends", "module": UMShareType.wechatLine])
        datas.append(["title":"微信好友", "iconName":"wechat_friends", "module": UMShareType.wechat])
       // datas.append(["title":"QQ好友", "iconName":"qq_friends", "module": UMShareType.qq])
       // datas.append(["title":"QQ空间", "iconName":"qq_zone", "module": UMShareType.qzone])
        datas.append(["title":"微博", "iconName":"weibo", "module": UMShareType.sina])
        datas.append(["title":"复制链接", "iconName":"cope_link", "module": UMShareType.copy])
        return datas as! [Dictionary<String, Any>]
    }()
}

// MARK: - UICollectionViewDataSource
extension MMLShareVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moduleDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MMLShareCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: MMLShareCollectionViewCell.self), for: indexPath) as! MMLShareCollectionViewCell
        cell.dict = moduleDatas[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MMLShareVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // 添加弹性动画
        let originFrame = cell.frame
        cell.frame.origin.y = collectionView.frame.size.height
        let duration = 0.2 + Double(indexPath.row) / 10.0
        UIView.animate(withDuration: 1.0, delay: duration, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
             cell.frame = originFrame
        }) { (finished: Bool) in
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = delegate {
            delegate?.shareModule(moduleType: moduleDatas[indexPath.item]["module"] as! UMShareType)
        }
        dismiss(animated: false, completion: nil)
    }
}

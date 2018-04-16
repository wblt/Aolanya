//
//  MMLHomeHeaderView.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLHomeHeaderView: UIView {
    
    weak var parentVC: MMLHomeVC!
    // 设置轮播图数据
    var banners: [MMLHomeDataBanner]? {
        didSet {
            if let _ = banners {
                var datas = [String]()
                banners?.forEach({ (homeDataBanner) in
                    datas.append(kPrefixLink + homeDataBanner.img)
                })
                // 添加数据
                bannerView.images = datas
            }
        }
    }
    
    // 广告模块
    var modulars: [MMLHomeDataModular]? {
        didSet {
            if let _ = modulars {
                for (index, value) in modulars!.enumerated() {
                    // 填充数据
                    debugLog(index)
                    switch index {
                    case 0:
                        intelligentdDetectionView.jq_setImage(imageUrl: kPrefixLink + value.modularImg, placeholder: "home_intelligentdetection")
                        break
                    case 1:
                        deepPurificationView.jq_setImage(imageUrl: kPrefixLink + value.modularImg, placeholder: "home_deeppurification")
                        break
                    case 2:
                        deepHydratingView.jq_setImage(imageUrl: kPrefixLink + value.modularImg, placeholder: "home_deephydrating")
                        break
                    case 3:
                        privatebeauticianView.jq_setImage(imageUrl: kPrefixLink + value.modularImg, placeholder: "home_privatebeautician")
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        bannerViewAction()
        adjustLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private method
    private func setupUI() {
        addSubview(bannerBGView)
        addSubview(moduleView)
        addSubview(imagesBannerView)
        addSubview(privatebeauticianBGView)
        addSubview(recommendProductView)
    }
    
    private func adjustLayout() {
        let bannerBGViewH: CGFloat = UIScreen.main.bounds.size.width * 150 / 375.0
        bannerBGView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(bannerBGViewH)
        }
        
        bannerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // 我要红包 收藏等等
        let moduleViewH: CGFloat = 110.0
        moduleView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(bannerBGView.snp.bottom)
            make.height.equalTo(moduleViewH)
        }
        collectionView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(-10)
        }
        
        // 布局含有三块图片的广告位
        let imagesBannerViewH: CGFloat = UIScreen.main.bounds.size.width * 200 / 375.0
        imagesBannerView.snp.makeConstraints { (make) in
            make.top.equalTo(moduleView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(imagesBannerViewH)
        }
        
        let intelligentdDetectionViewW = (UIScreen.main.bounds.size.width - 10) * 4 / 9
        intelligentdDetectionView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(intelligentdDetectionViewW)
        }
        
        let deepPurificationViewW = (UIScreen.main.bounds.size.width - 10) * 5 / 9
        let deepPurificationViewH = (imagesBannerViewH - 10) / 2
        deepPurificationView.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.width.equalTo(deepPurificationViewW)
            make.height.equalTo(deepPurificationViewH)
        }
        
        deepHydratingView.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview()
            make.width.equalTo(deepPurificationViewW)
            make.height.equalTo(deepPurificationViewH)
        }
        
        // 单条广告
        let privatebeauticianBGViewH: CGFloat = UIScreen.main.bounds.size.width * 160.0 / 375.0
        privatebeauticianBGView.snp.makeConstraints { (make) in
            make.top.equalTo(imagesBannerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(privatebeauticianBGViewH)
        }
        privatebeauticianView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
        }
        
        // 推荐商品
        let recommendProductH: CGFloat = 35.0
        recommendProductView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(recommendProductH)
        }
        
        let headerViewH = bannerBGViewH + moduleViewH + imagesBannerViewH + privatebeauticianBGViewH + recommendProductH
        self.frame = CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: headerViewH)
        
    }
    
    // MARK: - Event respose
    private func bannerViewAction() {
        bannerView.slectedClosure = {[weak self](index) in
            debugLog("广告图点击")
            //let VC = MMLContentDetailsVC()
            let data: MMLHomeDataBanner = (self?.banners![index])!
            let VC = MMLProductDetailsVC()
            VC.shoppingID = data.shoppingID
            self?.parentVC.navigationController?.pushViewController(VC, animated: true)
        }
    }
    // imageView的点击事件
    @objc  func viewSingleTapAction(tapGes: UITapGestureRecognizer) {
        debugLog(tapGes.view?.tag)
        let index = (tapGes.view?.tag)!
        let count = modulars?.count ?? 0
        
        if index > count {
            return
        }
        
        if let _ = modulars { // 解决没有请求到数据点击崩溃bug
            let data: MMLHomeDataModular = modulars![index]
            let VC = MMLProductDetailsVC()
            VC.shoppingID = data.shoppingID
//            let urlStr = data.modularUrl ?? " "
//            VC.loadUrlString(urlStr, title: "内容详情")
            parentVC.navigationController?.pushViewController(VC, animated: true)
        }

    }
    
    private func currentSelectedItem(index: Int) {
        switch index {
        case 0: // 签到红包
            parentVC.navigationController?.pushViewController(MMLRedenvelopeVC(), animated: true)
            break
        case 1: // 我的收藏
            parentVC.navigationController?.pushViewController(MMLMyCollectionVC(), animated: true)
            break
        case 2: // 提现
            parentVC.navigationController?.pushViewController(MMLSmartHardwareVC(), animated: true)
            break
        case 3: // 挣钱
            let VC = DDLuckdrawVC()
            VC.loadUrlString("http://ml.nnddkj.com/meimeila/API/pan/", title: "")
            parentVC.navigationController?.pushViewController(VC, animated: true)
            break
        default:
            break
        }
    }
    
    // MARK: - Lazy load
    // 广告位
    private lazy var bannerBGView: UIView = {[weak self] in
       let view = UIView.init()
        view.addSubview((self?.bannerView)!)
        return view
    }()
    
    private lazy var bannerView: JQBannerView = {
        let bannerView = JQBannerView.init(frame: CGRect.zero)
        bannerView.needInfinite = true
        bannerView.jqAutomaticSlidingInterval = 5
        bannerView.jqItemSpacing = 6
        //bannerView.backgroundColor = UIColor.RGB("#cdcdcd")
        return bannerView
    }()
    
    // 模块
    private lazy var moduleView: UIView = {[weak self] in
        let view = UIView.init()
        view.addSubview((self?.collectionView)!)
        view.backgroundColor = DDGlobalBGColor()
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: (Screen.width - 30) / 3.0, height: CGFloat(kHomefunction))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //layout.sectionInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 15, right: 0)
        let collectionView: UICollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: String.init(describing: MMLHeaderViewModuleCell.self), bundle: nil), forCellWithReuseIdentifier: String.init(describing: MMLHeaderViewModuleCell.self))
        return collectionView
    }()
    
    // 图片广告位(三块)
    private lazy var imagesBannerView: UIView = {[weak self] in
      let view = UIView.init()
        view.addSubview((self?.intelligentdDetectionView)!)
        view.addSubview((self?.deepPurificationView)!)
        view.addSubview((self?.deepHydratingView)!)
        return view
    }()
    // 智能检测
    private lazy var intelligentdDetectionView: UIImageView = {
        let view = UIImageView.init()
        view.isUserInteractionEnabled = true
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 5
        view.image = UIImage.init(named: "home_intelligentdetection")
        view.tag = 0
        let tap =  UITapGestureRecognizer.init(target: self, action: #selector(viewSingleTapAction(tapGes:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    // 深层净化
    private lazy var deepPurificationView: UIImageView = {
        let view = UIImageView.init()
        view.isUserInteractionEnabled = true
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 5
        view.image = UIImage.init(named: "home_deeppurification")
        view.tag = 1
        let tap =  UITapGestureRecognizer.init(target: self, action: #selector(viewSingleTapAction(tapGes:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    //  深透补水
    private lazy var deepHydratingView: UIImageView = {
        let view = UIImageView.init()
        view.isUserInteractionEnabled = true
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 5
        view.image = UIImage.init(named: "home_deephydrating")
        view.tag = 2
        let tap =  UITapGestureRecognizer.init(target: self, action: #selector(viewSingleTapAction(tapGes:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    
    // 单条广告
    private lazy var privatebeauticianBGView: UIView = {[weak self] in
        let view = UIView.init()
        view.backgroundColor = DDGlobalBGColor()
        view.addSubview((self?.privatebeauticianView)!)
        return view
    }()
    
    // 私人美容师
    private lazy var privatebeauticianView: UIImageView = {
        let view = UIImageView.init()
        view.isUserInteractionEnabled = true
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 5
        view.image = UIImage.init(named: "home_privatebeautician")
        view.tag = 3
        let tap =  UITapGestureRecognizer.init(target: self, action: #selector(viewSingleTapAction(tapGes:)))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    // 推荐商品
    private lazy var recommendProductView: UIImageView = {
        let view = UIImageView.init()
        view.isUserInteractionEnabled = true
        view.image = UIImage.init(named: "home_recommend")
        view.contentMode = .center
        return view
    }()
    
    
    fileprivate lazy var moduleDatas: [Dictionary<String, String>] = {
        var datas = Array<Any>.init()
        datas.append(["title":"签到红包","iconName":"home_signinrede"])
        datas.append(["title":"我的收藏","iconName":"home_collection"])
        datas.append(["title":"智能硬件","iconName":"home_withdrawal"])
       // datas.append(["title":"奖品来了","iconName":"home_makemoney"])
        return datas as! [Dictionary<String, String>]
    }()
    
}

// MARK: - UICollectionViewDataSource
extension MMLHomeHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moduleDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MMLHeaderViewModuleCell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: MMLHeaderViewModuleCell.self), for: indexPath) as! MMLHeaderViewModuleCell
        cell.dict1 = moduleDatas[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MMLHomeHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelectedItem(index: indexPath.item)
    }
}

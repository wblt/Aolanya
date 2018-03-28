//
//  MMLFoundHeaderView.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLFoundHeaderView: UIView {

    
    var bannerDatas: [MMLFoundBrandBanner]? {
        didSet {
            if let _ = bannerDatas {
                var datas = [String]()
                bannerDatas?.forEach({ (data) in
                    datas.append(kPrefixLink + data.img)
                })
                // 添加数据
                bannerView.images = datas
            }
        }
    }
    weak var parentVC: UIViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        bannerViewAction()
        adjustLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubview(bannerBGView)
        addSubview(latest)
        bannerBGView.addSubview(bannerView)
    }
    
    private func adjustLayout() {
        let bannerViewH: CGFloat = UIScreen.main.bounds.size.width * 150 / 375.0
        bannerBGView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(bannerViewH)
        }
        
        bannerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let latestH: CGFloat = 44.0
        latest.snp.makeConstraints { (make) in
            make.top.equalTo(bannerBGView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(latestH)
        }
        
        self.frame = CGRect.init(x: 0.0, y: 0.0, width: latestH, height: bannerViewH + latestH)
    }
    
    // MARK: - Event respose
    private func bannerViewAction() {
        bannerView.slectedClosure = {[weak self](index) in
            debugLog("广告图点击")
            let VC = MMLProductDetailsVC()
            let data: MMLFoundBrandBanner = (self?.bannerDatas![index])!
//            let urlStr = data.link ?? " "
//            VC.loadUrlString(urlStr, title: "内容详情")
            VC.shoppingID = data.shoppingID
            self?.parentVC.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    
    // MARK - Lazy load
    
    private lazy var bannerBGView: UIView = {
        let view = UIView.init()
        return view
    }()
    
    private lazy var  latest: UIImageView = {
        let label = UIImageView()
        label.backgroundColor = DDGlobalBGColor()
        label.image = UIImage.init(named: "found_new");
        return label
    }()
    
    private lazy var bannerView: JQBannerView = {
        let bannerView = JQBannerView.init(frame: CGRect.zero)
        bannerView.needInfinite = true
        bannerView.jqAutomaticSlidingInterval = 5
        bannerView.jqItemSpacing = 6
        //bannerView.backgroundColor = UIColor.RGB("#cdcdcd")
        return bannerView
    }()
}

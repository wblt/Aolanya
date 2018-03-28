//
//  JQPageView.swift
//  YSBRXSwift
//
//  Created by HJQ on 2017/6/16.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Foundation
import FSPagerView
import SnapKit

// MARK: - 优雅的管理selector
fileprivate struct Action {
    static let startButtonClick = #selector(JQWelcomView.startButtonClick)
    
}

class JQWelcomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configSubViewsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        setupUI()
        configSubViewsLayout()
    }
    
    deinit {
        debugLog("JQWelcomViewdeinit")
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - private methods
    private func setupUI () {
        backgroundColor = UIColor.white
        addSubview(homeBannerView)
        addSubview(fsPageViewControl)
    }
    
    private func configSubViewsLayout() {
        homeBannerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        fsPageViewControl.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
    
    }
    
    // MARK: - event response
    @objc fileprivate func startButtonClick() {
        self.alpha = 1.0
        UIView.animate(withDuration: 0.8, animations: {
            self.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.alpha = 0.0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    
    
    // MARK: - lazy load
    fileprivate var images: [String] = {
        let tempImages: [String] = [
            "guide-page",
            "guide-page1",
            "guide-page2"
        ]
        return tempImages
    }()
    
    private lazy var homeBannerView: FSPagerView = { [weak self] in
        let  homeBannerV: FSPagerView = FSPagerView.init()
        homeBannerV.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "PagerViewCell")
        //homeBannerV.isInfinite = true
        //homeBannerV.automaticSlidingInterval = 3.0
        //homeBannerV.transformer =  FSPagerViewTransformer.init(type: .crossFading)
        homeBannerV.itemSize = CGSize.zero
        homeBannerV.delegate = self
        homeBannerV.dataSource = self
        return homeBannerV
    }()
    
    fileprivate lazy var fsPageViewControl: FSPageControl = { [weak self] in
        let pageControl: FSPageControl = FSPageControl.init()
        pageControl.numberOfPages = self?.images.count ?? 0
        pageControl.contentHorizontalAlignment = .center
        pageControl.itemSpacing = 10
        pageControl.interitemSpacing = 10
        pageControl.setFillColor(UIColor.red, for: .selected)
        pageControl.setStrokeColor(UIColor.white, for: .normal)
        //pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return pageControl
    }()
    
    fileprivate func getImageName(index: Int) -> String? {
        var imageNamePath: String?
        if let guide_imagesPath: String = Bundle.main.path(forResource: "guide_pageImages.bundle", ofType: "") {
            if let bundle: Bundle = Bundle.init(path: guide_imagesPath) {
                var fileName: String = images[index]
                if UIScreen.main.scale == 3.0 {
                    fileName.append("@3x")
                }else {
                    fileName.append("@2x")
                }
                if let imageURL: String = bundle.path(forResource: fileName, ofType: "png") {
                    imageNamePath = imageURL
                }
            }
        }
        return imageNamePath
    }
    
    fileprivate func createButton() -> UIButton {
        
        let tempButton: UIButton = UIButton.init(type: UIButtonType.custom)
        tempButton.tag = 66
        tempButton.backgroundColor = UIColor.orange
        tempButton.setTitleColor(UIColor.white, for: .normal)
        tempButton.setTitle("开始体验", for: .normal)
        tempButton.layer.masksToBounds = true
        tempButton.layer.cornerRadius = 5
        tempButton.isHidden = true
        tempButton.addTarget(self, action: Action.startButtonClick, for: .touchUpInside)
        return tempButton
    }
}

// MARK:- FSPagerView DataSource
extension JQWelcomView: FSPagerViewDataSource {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return images.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "PagerViewCell", at: index)
        
        if let imageUrl = getImageName(index: index) {
            cell.imageView?.image = UIImage.init(contentsOfFile: imageUrl)
            cell.imageView?.image = UIImage.init(named: "")
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
        }

        for view in cell.contentView.subviews {
            if view.tag == 66 {
                view.removeFromSuperview()
            }
        }
        let tempButton = createButton()
        cell.contentView.addSubview(tempButton)
        tempButton.snp.makeConstraints({ (make) in
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-70)
        })
        if index == (images.count - 1) {
            tempButton.isHidden = false
        }else {
            tempButton.isHidden = true
        }
        // 是否显示文字
        //cell.textLabel?.text = index.description+index.description
        return cell
    }
    
    
}

// MARK:- FSPagerView Delegate
extension JQWelcomView: FSPagerViewDelegate {
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        self.fsPageViewControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.fsPageViewControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.fsPageViewControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
}

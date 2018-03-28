//
//  JQBannerView.swift
//  YSBRXSwift
//
//  Created by HJQ on 2017/6/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Foundation
import FSPagerView
import SnapKit
import Kingfisher

private let KJQBANNERVIEWCELL = "KJQBANNERVIEWCELL"

class JQBannerView: UIView {
    
    override init(frame: CGRect) {
        self.slectedClosure = {_ in }
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
    
    // 选中回调闭包
    open var slectedClosure: ((_ index: Int) -> ())?
    // 刷新数据
    open func jqBannerViewReloadData() {
        self.homeBannerView.reloadData()
    }
    // 设置数据源(如果String为nil的情况要转换成" ")
    open var images: [String] = [String]() {
        didSet {
            fsPageViewControl.numberOfPages = images.count
            fsPageViewControl.currentPage  = 0
            self.homeBannerView.reloadData()
        }
    }
    open var titles: [String] = [String]() {
        didSet {
            self.homeBannerView.reloadData()
        }
    }
    // 设置是否要循环
    open var needInfinite: Bool = false {
        didSet {
            homeBannerView.isInfinite = needInfinite
        }
    }
    // 设置动画类型
    open var jqtransformerType: FSPagerViewTransformerType = .depth {
        didSet {
            homeBannerView.transformer = FSPagerViewTransformer.init(type: jqtransformerType)
        }
    }
    // 设置自动轮播间隔
    open var jqAutomaticSlidingInterval: CGFloat = 3.0 {
        didSet {
            homeBannerView.automaticSlidingInterval = jqAutomaticSlidingInterval
        }
    }
    
    // 设置pageControl的位置
    open var jqContentHorizontalAlignment: UIControlContentHorizontalAlignment = .center {
        didSet {
            fsPageViewControl.contentHorizontalAlignment = jqContentHorizontalAlignment
        }
    }
    
    // 设置点的大小
    open var jqItemSpacing: CGFloat = 7.0 {
        didSet {
            fsPageViewControl.itemSpacing = jqItemSpacing
        }
    }
    
    // 设置点的间距
    open var jqInteritemSpacing: CGFloat = 7.0 {
        didSet {
            fsPageViewControl.interitemSpacing = jqInteritemSpacing
        }
    }
    
    open func jqSetFillColor(color: UIColor, state: UIControlState) {
        fsPageViewControl.setFillColor(color, for: state)
    }
    
    open func jqSetStrokeColor(color: UIColor, state: UIControlState) {
        fsPageViewControl.setFillColor(color, for: state)
    }
    
    // 使用自定义的图片
    open func jqSetImage(img: UIImage, state: UIControlState) {
        fsPageViewControl.setImage(img, for: state)
    }
    
    // MARK: - private methods
    private func setupUI () {
        backgroundColor = UIColor.white
        addSubview(homeBannerView)
        addSubview(fsPageViewControl)
        //addSubview(startButton)
    }
    
    private func configSubViewsLayout() {
        homeBannerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        fsPageViewControl.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(0)
        }
        
    }
    
    
    private lazy var homeBannerView: FSPagerView = {
        let  homeBannerV: FSPagerView = FSPagerView.init()
        homeBannerV.register(FSPagerViewCell.self, forCellWithReuseIdentifier: KJQBANNERVIEWCELL)
        homeBannerV.isInfinite = false
        homeBannerV.automaticSlidingInterval = 0.0
        homeBannerV.transformer =  FSPagerViewTransformer.init(type: .depth)
        homeBannerV.itemSize = CGSize.zero
        homeBannerV.delegate = self
        homeBannerV.dataSource = self
        return homeBannerV
        }()
    
    fileprivate lazy var fsPageViewControl: FSPageControl = {
        let pageControl: FSPageControl = FSPageControl.init()
        pageControl.numberOfPages = 0
        pageControl.contentHorizontalAlignment = .center
        pageControl.itemSpacing = 10
        pageControl.interitemSpacing = 10
        pageControl.setFillColor(UIColor.red, for: .selected)
        pageControl.setStrokeColor(UIColor.white, for: .normal)
        //pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return pageControl
        }()
}

// MARK:- FSPagerView DataSource
extension JQBannerView: FSPagerViewDataSource {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return images.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: KJQBANNERVIEWCELL, at: index)
        cell.imageView?.jq_setImage(imageUrl: images[index], placeholder: "http_error")
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        // 是否显示文字
        if titles.count > 0 {
           cell.textLabel?.text = titles[index]
        }
        return cell
    }
}

// MARK:- FSPagerView Delegate
extension JQBannerView: FSPagerViewDelegate {
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        self.fsPageViewControl.currentPage = index
        if let closure = slectedClosure {
            closure(index)
        }
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.fsPageViewControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.fsPageViewControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
}


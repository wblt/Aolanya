//
//  BannerHoverView.swift
//  BannerHoverView-Sample
//
//  Created by 段昊宇 on 2017/5/20.
//  Copyright © 2017年 Desgard_Duan. All rights reserved.
//

/* 
 // 使用方式
 // EleHoverView是继承BannerHoverView的子View
 func setBanerHover()  {
    bannerHoverView = EleHoverView.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: 125))
    bannerHoverView.topmg = 65
    bannerHoverView.headerScrollView = tableView
 
    tableView.addObserver(bannerHoverView, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: nil)
 }
 
 deinit {
    tableView.removeObserver(bannerHoverView, forKeyPath: "contentOffset")
 }
 */


import UIKit
import Foundation

// 功能说明：顶部悬停

class BannerHoverView: UIView {
    
    static private let eps: CGFloat = 1e-6
    
    public var headerScrollView: UIScrollView!
    public var topmg: CGFloat = 0
    public fileprivate(set) var bottommg: CGFloat = 0
    public fileprivate(set) var isTop: Bool = false
    public fileprivate(set) var isBottom: Bool = true
    fileprivate var completeBlock: ((BannerHoverView) -> Void)?
    fileprivate var startBlock: ((BannerHoverView) -> Void)?
    fileprivate var scrollBlock: ((BannerHoverView, CGFloat) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bottommg = frame.size.height
        isTop = false
        isBottom = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIView Delegate
    public override func willMove(toWindow newWindow: UIWindow?) {
        headerScrollView.contentInset = UIEdgeInsets.init(top: bottommg, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let new = change?[NSKeyValueChangeKey.newKey] {
            let point = (new as! NSValue).cgPointValue
            updateSubViewsWithScrollOffset(newOffset: point)
        }
    }
    
    public func setTopAction(action: @escaping (_ view: BannerHoverView) -> Void) {
        startBlock = action
    }
    
    public func setBottomAction(action: @escaping (_ view: BannerHoverView) -> Void) {
        completeBlock = action
    }
    
    public func setScrollAction(action: @escaping (_ view: BannerHoverView, _ offset: CGFloat) -> Void) {
        scrollBlock = action
    }
    
    // MARK: - Scroll Offset
    fileprivate func updateSubViewsWithScrollOffset(newOffset: CGPoint) {
        var newOffset = newOffset
        let startChangeOffset = -headerScrollView.contentInset.top
        newOffset = CGPoint.init(x: newOffset.x, y: newOffset.y < startChangeOffset ? startChangeOffset : min(newOffset.y, -topmg))
        let newY = -newOffset.y - bottommg
        frame = CGRect.init(x: 0, y: newY, width: frame.size.width, height: frame.size.height)
        let distance = -topmg - startChangeOffset
        let percent = 1 - (newOffset.y - startChangeOffset) / distance
        
        // Solve Call Back
        if 1.0 - percent > BannerHoverView.eps && percent - 0.0 > BannerHoverView.eps {
            isBottom = false
            isTop = false
        }
        else if isBottom == false && isTop == false {
            if 1.0 - percent < BannerHoverView.eps {
                isTop = true
                if let topAction = completeBlock {
                    topAction(self)
                }
            }
            else if percent - 0.0 < BannerHoverView.eps {
                isBottom = true
                if let bottomAction = startBlock {
                    bottomAction(self)
                }
            }
        }
        if let scrollAction = scrollBlock {
            scrollAction(self, percent)
        }
    }
}

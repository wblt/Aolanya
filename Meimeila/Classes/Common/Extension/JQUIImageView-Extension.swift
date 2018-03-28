//
//  UIImageView-Extension.swift
//  YSBRXSwift
//
//  Created by HJQ on 2017/6/15.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    /// Kingfisher图片加载
    ///
    /// - Parameters:
    ///   - imageUrl:  将要加载的图片
    ///   - placeholder: 占位图片
    ///   - isShowIndicator: 是否展示指示器
    ///   - options: forceRefresh 强制刷新 每次联网刷新 transition 1s渐显效果
    func jq_setImage(imageUrl: String?, placeholder: String? = "appDefault", isShowIndicator: Bool? = true, isNeedForceRefresh: Bool = false) {
        self.kf.indicatorType = isShowIndicator! ? .activity : .none
        var image: UIImage?
        if let placeholder = placeholder  {
           image = UIImage.init(named: placeholder)
        }
        
        // KingfisherOptionsInfoItem.forceRefresh,
        var options = [KingfisherOptionsInfoItem]()
        if isNeedForceRefresh {
            options.append(KingfisherOptionsInfoItem.forceRefresh)
        }
        self.kf.setImage(with: URL.init(string: imageUrl ?? ""), placeholder: image, options:options , progressBlock: { (_, _) in
            
        }) { (image, error, cacheType, url) in
            
        }
    }
    
    
}

//
//  UIButton-Extension.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIButton {
    
    // 设置按钮的背景图片
    func jq_setButtonBGImage(url: URL?, placeholder: String? = "appDefault", state: UIControlState) {
        
        var image: UIImage?
        if let placeholder = placeholder  {
            image = UIImage.init(named: placeholder)
        }
        
        self.kf.setBackgroundImage(with: url, for: state, placeholder: image, options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1))], progressBlock: { (_, _) in
            
        }) { (_, _, _, _) in
        }
    }
    
    // 设置按钮的Image
    func jq_setButtonImage(url: URL?, placeholder: String? = "appDefault", state: UIControlState) {
        
        var image: UIImage?
        if let placeholder = placeholder  {
            image = UIImage.init(named: placeholder)
        }
        
        self.kf.setImage(with: url, for: state, placeholder: image, options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1))], progressBlock: { (_, _) in
            
        }) { (_, _, _, _) in
            
        }
    }
    
}

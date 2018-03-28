//
//  DDVerticalButton.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// 按钮的图片和文字垂直方向排列
class DDVerticalButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
        imageView?.contentMode = .scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        titleLabel?.textAlignment = .center
        imageView?.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 调整图片
        imageView?.x = (self.width - 25)/2
        imageView?.y = 3
        imageView?.width = 25
            //self.width - 20
        imageView?.height = 25
            //imageView!.width
        // 调整文字
        titleLabel?.x = 0
        titleLabel?.y = imageView!.height + 5
        titleLabel?.width = self.width
        titleLabel?.height = self.height - self.titleLabel!.y
    }

}

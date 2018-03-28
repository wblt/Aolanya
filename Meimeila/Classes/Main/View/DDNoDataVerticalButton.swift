//
//  DDNoDataVerticalButton.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/25.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class DDNoDataVerticalButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.x = (width - (imageView?.width)!) / 2
        titleLabel?.x = (width - (titleLabel?.width)!) / 2
        titleLabel?.y = imageView!.height + (imageView?.y)! + 15
    }

}

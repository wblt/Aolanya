//
//  DDCommonLabel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Foundation

public class DDCommonLabel: UILabel {

    var insets: UIEdgeInsets? = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    
    override  public func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, self.insets!))
    }
//    
//    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        backgroundColor = UIColor.orange
//        layer.borderWidth = 0
//    }
//    
//    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
//        backgroundColor = UIColor.white
//        layer.borderWidth = 0.5
//    }
//    
//    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesCancelled(touches, with: event)
//        backgroundColor = UIColor.white
//        layer.borderWidth = 0.5
//    }
    
//    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesMoved(touches, with: event)
//        backgroundColor = UIColor.white
//        layer.borderWidth = 0.5
//    }

}

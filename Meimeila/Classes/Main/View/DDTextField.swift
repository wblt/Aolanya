//
//  DDTextField.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class DDTextField: UITextField {

    // UITextField 禁止粘贴
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let menuViewController: UIMenuController? = UIMenuController.shared
        if let _ = menuViewController {
            menuViewController?.isMenuVisible = false
        }
        return false
    }

}

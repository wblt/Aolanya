//
//  DDPopupWindowVC.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol DDPopupWindowVCDelegate {
    func popupWindowVCLeftButtonAction(button: UIButton)
    func popupWindowRightVCButtonActtion(button: UIButton)
}

// 自定义弹窗
class DDPopupWindowVC: UIViewController {

    weak var delegate: DDPopupWindowVCDelegate?
    
    private var leftButtonTitle: String!
    private var rightButtonTitle: String!
    private var messageStr: String!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    // 如果不写这个方法，iOS8会崩溃
    init(message: String, leftButtonTitle: String, rightButtonTitle: String) {
        super.init(nibName: String.init(describing: DDPopupWindowVC.self), bundle: nil)
        self.leftButtonTitle = leftButtonTitle
        self.rightButtonTitle = rightButtonTitle
        self.messageStr = message
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        showAniamtion()
    }
    
    // MARK: - Private method
    private func setupData() {
        leftButton.setTitle(leftButtonTitle, for: .normal)
        messageLabel.text = messageStr
        rightButton.setTitle(rightButtonTitle, for: .normal)
    }
    
    
    private func showAniamtion() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        contentView.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        // 弹簧动画
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.contentView.transform =  CGAffineTransform.identity
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }, completion: nil)
    }
    
    private func hideAnimation() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        contentView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.contentView.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        }) { (_) in
            self.contentView.transform = CGAffineTransform.identity
            self.view.removeFromSuperview()
        }
    }

    // MARK: - Event respose
    @IBAction func leftButtonAction(_ sender: Any) {
        let button = sender as! UIButton
        if let _ = delegate {
            delegate?.popupWindowVCLeftButtonAction(button: button)
        }
        hideAnimation()
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        let button = sender as! UIButton
        if let _ = delegate {
            delegate?.popupWindowRightVCButtonActtion(button: button)
        }
        hideAnimation()
    }
    

}

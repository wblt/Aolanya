//
//  DDAnimationButton.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/6.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// 类型
enum DDAnimationButtonType {
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
    case scale
}

class DDAnimationButton: UIButton {

    var animationType: DDAnimationButtonType = .topToBottom
    
    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            if oldValue != isEnabled {
                if oldValue {
                    lastDisabledTitle = title(for: .disabled)
                    loading(title: lastDisabledTitle)
                    setTitle("", for: .disabled)
                } else {
                    reset()
                    setTitle(lastDisabledTitle, for: .disabled)
                }
            }
        }
    }
    
    lazy var backV = UIView()
    lazy var messageLbl = UILabel()
    lazy var indicatorV: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.sizeToFit()
        indicator.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        return indicator
    }()
    private var lastTitle: String?
    private var lastDisabledTitle: String?
    private var lastWidth: CGFloat?
    private var lsatHeight: CGFloat?
    private let margin: CGFloat = 8
    
    private var transformY: CGFloat {
        return self.height * (animationType == .topToBottom ? (-1) : (animationType == .bottomToTop ? 1 : 0))
    }
    
    private var transformX: CGFloat {
        return self.width * (animationType == .leftToRight ? (-1) : (animationType == .rightToLeft ? 1 : 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        layer.masksToBounds = true
        
        messageLbl.textColor = titleLabel?.textColor
        messageLbl.font = titleLabel?.font
        backV.addSubview(messageLbl)
        
        indicatorV.activityIndicatorViewStyle = .gray
        backV.addSubview(indicatorV)
        
        backV.height = self.height
        backV.centerY = self.height * 0.5
        backV.backgroundColor = .clear
        backV.alpha = 0
        
        addSubview(backV)
        
        lastTitle = currentTitle
        lsatHeight = self.height
        lastWidth = self.width
    }
    
    private func loading(title: String?) {
        messageLbl.text = title
        messageLbl.textColor = self.titleColor(for: .disabled)
        messageLbl.shadowColor = self.titleShadowColor(for: .disabled)
        messageLbl.font = self.titleLabel?.font
        messageLbl.sizeToFit()
        
        indicatorV.centerY = backV.centerY
        indicatorV.x = margin
        messageLbl.centerY = indicatorV.centerY
        messageLbl.x = indicatorV.right + margin
        backV.right = messageLbl.right
        backV.width = messageLbl.right + margin
        //self.width = self.width < backV.width ? backV.width : self.width
        backV.x = (self.width - backV.width ) * 0.5
        
        indicatorV.startAnimating()
        backV.transform = (title == lastTitle) ? .identity : animationType == .scale ? CGAffineTransform(scaleX: 0.5, y: 0.5) : CGAffineTransform(translationX: transformX, y: transformY)
        UIView.animate(withDuration: 0.5) {
            self.titleLabel!.alpha = 0
            self.backV.alpha = 1
            self.backV.transform = .identity
        }
    }
    
    private func reset() {
        UIView.animate(withDuration: 0.5, animations: {
            self.titleLabel!.alpha = 1
            self.backV.alpha = 0
            self.backV.transform = (self.currentTitle == self.lastDisabledTitle) ? .identity : self.animationType == .scale ? CGAffineTransform(scaleX: 0.5, y: 0.5) : CGAffineTransform(translationX: 0, y: self.transformY)
        }) { (finished) in
            self.backV.transform = .identity
            self.indicatorV.stopAnimating()
            UIView.animate(withDuration: 0.5, animations: {
                if self.currentTitle == self.lastDisabledTitle {
                    //self.width = self.lastWidth ?? self.width
                }else{
                    //self.sizeToFit()
                    //self.width = self.width > (self.lastWidth ?? self.width) ? self.width : (self.lastWidth ?? self.width)
                    //self.height = self.lsatHeight ?? self.height
                }
            })
        }
    }

}

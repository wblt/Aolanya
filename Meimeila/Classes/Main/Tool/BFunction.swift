//
//  BFunction.swift
//  HangJia
//
//  Created by Alvin on 16/1/7.
//  Copyright © 2016年 Alvin. All rights reserved.
//

import UIKit
import SVProgressHUD
import MBProgressHUD

class BFunction: NSObject {
    
    static let shared = BFunction()
    fileprivate(set) var toastCount = 0
    fileprivate(set) var isShow = false
    var isShowYaoYiYao = true// 是否弹窗摇一摇, 只弹一次

    fileprivate override init() {
        
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
    }
    
    /**
     仅仅显示文字
     
     - parameter msg: text
     */
    func showToastMessge(_ msg: String!) {
        isShow = false
        hideLoadingMessage()
        isShow = true
        toastCount += 1
        
        let window = UIApplication.sharedDelegate().window
        let hud = MBProgressHUD.showAdded(to: window!, animated: true)
        hud.bezelView.backgroundColor = UIColor.black//(white: 0.0, alpha: 0.8)
        hud.contentColor = UIColor.white
        hud.mode = .text
        hud.label.text = msg
        hud.hide(animated: true, afterDelay: 1)
    }
    
    /**
     隐藏提示框
     */
    func hideLoadingMessage() {
        
        if isShow {
            
            DDUtility.delay(0.4) {
                
                if self.toastCount == 1 {
                    SVProgressHUD.dismiss()
                    self.isShow = false
                }
                
                if self.toastCount > 0 {
                    self.toastCount -= 1
                }
            }
        }else{
            
            SVProgressHUD.dismiss()
            isShow = false
            toastCount = 0
        }
    }
    
    /**
     等待提示框
     
     - parameter msg: text
     */
    func showLoading() {
        if isShow {
            hideLoadingMessage()
        }
        isShow = true
        toastCount += 1
        SVProgressHUD.show()
    }
    
    /**
     等待提示框
     
     - parameter msg: text
     */
    func showLoadingMessage(_ msg: String) {
        if isShow {
            hideLoadingMessage()
        }
        isShow = true
        toastCount += 1
        SVProgressHUD.show(withStatus: msg)
    }
    
    /**
     文本提示框
     
     - parameter msg: text
     */
    func showMessage(_ msg: String) {
        if isShow {
            hideLoadingMessage()
        }
        isShow = true
        toastCount += 1
        showToastMessge(msg)
    }
    
    /**
     成功提示框
     
     - parameter msg: text
     */
    func showSuccessMessage(_ msg: String) {
        if isShow {
            hideLoadingMessage()
        }
        isShow = true
        toastCount += 1
        showToastMessge(msg)
    }
    
    /**
     失败提示框
     
     - parameter msg: text
     */
    func showErrorMessage(_ msg: String) {
        if isShow {
            hideLoadingMessage()
        }
        
        isShow = true
        toastCount += 1
        showToastMessge(msg)
    }
    
    /**
     进度条提示框
     
     - parameter progress: 百分百
     - parameter message:  text
     */
    func showProgress(_ progress: Double, msg: String) {
        
        isShow = false
        SVProgressHUD.showProgress(Float(progress), status: msg)
    }
    
    
    /**
     只有一个按钮提示框（点击按钮没有回调）
     
     - parameter title:          标题
     - parameter subTitle:       副标题
     - parameter cancelBtnTitle: 取消按钮的标题
     */
    func showAlert(title: String?, subTitle: String?, cancelBtnTitle: String = "取消") {
        
        showAlert(title: title, subTitle: subTitle, cancelBtnTitle: cancelBtnTitle, ontherBtnTitle: nil, ontherBtnAction: nil)
    }
    
    /**
     只有一个按钮提示框（点击按钮有回调）
     
     - parameter title:           标题
     - parameter subTitle:        副标题
     - parameter cancelBtnTitle:  取消按钮的标题
     - parameter cancelBtnAction: 取消按钮的回调
     */
    func showAlert(title: String?, subTitle: String?, cancelBtnTitle: String = "知道了", cancelBtnAction: (() -> Void)?) {
        
        let alert = DDAlertController(title: title, message: subTitle, preferredStyle: .alert)
        let action = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (action) in
            
            cancelBtnAction?()
        })
        alert.addAction(action)
        
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            
            window.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    /**
     两个按钮的提示框
     
     - parameter title:           标题
     - parameter subTitle:        副标题
     - parameter cancelBtnTitle:  取消按钮的标题
     - parameter ontherBtnTitle:  另一个按钮的标题
     - parameter ontherBtnAction: 另一个按钮的回调
     */
    func showAlert(title: String?, subTitle: String?, cancelBtnTitle: String = "取消", ontherBtnTitle: String?, ontherBtnAction: (() -> Void)?) {
        
        let alert = DDAlertController(title: title, message: subTitle, preferredStyle: .alert)
        
        let action = UIAlertAction(title: cancelBtnTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        
        if let ontherBtnTitle = ontherBtnTitle {
            let action1 = UIAlertAction(title: ontherBtnTitle, style: .default, handler: { (alert) in
                
                ontherBtnAction?()
            })
            alert.addAction(action1)
        }
        
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            
            window.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    /**
     弹出ActioSheet
     
     - parameter title:    标题
     - parameter subTitle: 副标题
     - parameter titles:   按钮标题数组
     - parameter callback: 点击按钮回调
     */
    func showActioSheetWithTitleArray(title: String?, subTitle: String?, titles: [String], callback: @escaping (_ index: Int, _ title: String) -> Void) {
        
        let alert = UIAlertController(title: title, message: subTitle, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action)
        
        for (i, title) in titles.enumerated() {
            
            alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action: UIAlertAction) in
                
                callback(i, title)
            }))
        }
        
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            
            window.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    /**
     视图弹出后放大又缩小的动画实现、类似于alertView效果
     
     - parameter view: view
     */
    fileprivate func shake(to view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.duration = 0.47
        
        var values: [NSValue] = []
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(0.1, 0.1, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        
        animation.values = values
        view.layer.add(animation, forKey: nil)
    }
    
    // 收藏动画
    func collectionAnimation(button: UIButton) {
        let keyframeAnimation = CAKeyframeAnimation.init(keyPath: "transform.scale")
        keyframeAnimation.values = [0.1, 1.0, 1.5]
        keyframeAnimation.keyTimes = [0.0, 0.5, 0.8, 1.0]
        keyframeAnimation.calculationMode = kCAAnimationLinear
        button.imageView?.layer.add(keyframeAnimation, forKey: "Show")
    }
}

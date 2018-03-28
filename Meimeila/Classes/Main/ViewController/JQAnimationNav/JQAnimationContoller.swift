//
//  JQAnimationContoller.swift
//  JQNavigationController
//
//  Created by HJQ on 2017/10/22.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

let JQScreenwidth = UIScreen.main.bounds.size.width
let JQScreenHeight = UIScreen.main.bounds.size.height

class JQAnimationContoller: NSObject {
    
    var navigationOperation: UINavigationControllerOperation!
    var navigationController: UINavigationController! {
        didSet {
            let beyondVC: UIViewController = (self.navigationController.view.window?.rootViewController)!
            //判断该导航栏是否有TabBarController
            if self.navigationController.tabBarController == beyondVC {
                isTabbarExist = true
            }else {
                isTabbarExist = false
            }
        }
    }
    
    private lazy var screenShotArray: [UIImage] = [UIImage]()
    /**
     所属的导航栏有没有TabBarController
     */
    private var isTabbarExist: Bool = false
    
    /**
     导航栏Pop时删除了多少张截图（调用PopToViewController时，计算要删除的截图的数量）
     */
    var removeCount: Int = 0
    
    class func AnimationControllerWithOperation(operation: UINavigationControllerOperation) -> JQAnimationContoller {
        let ac = JQAnimationContoller.init()
        ac.navigationOperation = operation
        return ac
    }
    
    class func AnimationControllerWithOperation(operation: UINavigationControllerOperation, navigationController: UINavigationController) -> JQAnimationContoller{
        let ac = JQAnimationContoller.init()
        ac.navigationController = navigationController
        ac.navigationOperation = operation
        return ac
    }
    
    /**
     调用此方法删除数组最后一张截图 (调用pop手势或一次pop多个控制器时使用)
     */
    func removeLastScreenShot() {
        if !screenShotArray.isEmpty {
            screenShotArray.removeLast()
        }
        
    }
    
    /**
     移除全部屏幕截图
     */
    func removeAllScreenShot() {
        if !screenShotArray.isEmpty {
            screenShotArray.removeAll()
        }
    }
    
    /**
     从截屏数组尾部移除指定数量的截图
     */
    func removeLastScreenShotWithNumber(number: Int) {
        for (_, _) in screenShotArray.enumerated() {
            if !screenShotArray.isEmpty {
              screenShotArray.removeLast()
            }
        }
    }
    


}

extension JQAnimationContoller {
    func screenShot() -> UIImage {
        // 将要被截图的view,即窗口的根控制器的view(必须不含状态栏,默认ios7中控制器是包含了状态栏的)
        let beyondVC: UIViewController = self.navigationController.view.window!.rootViewController!
        // 背景图片 总的大小
        let size: CGSize = beyondVC.view.frame.size
        // 开启上下文,使用参数之后,截出来的是原图（true  0.0 质true量高）
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        // 要裁剪的矩形范围
        let rect: CGRect = UIScreen.main.bounds
        //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
        if isTabbarExist {
            beyondVC.view.drawHierarchy(in: rect, afterScreenUpdates: false)
        }else {
            self.navigationController.view.drawHierarchy(in: rect, afterScreenUpdates: false)
        }
        // 从上下文中,取出UIImage
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        // 千万记得,结束上下文(移除栈顶的基于当前位图的图形上下文)
        UIGraphicsEndImageContext()
        
        //UIImageWriteToSavedPhotosAlbum(snapshot!, nil, nil, nil)
        
        // 返回截取好的图片
        return snapshot!
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension JQAnimationContoller: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let screentImgView = UIImageView.init(frame: UIScreen.main.bounds)
        let screenImg = screenShot()
        screentImgView.image = screenImg
        
        //取出fromViewController,fromView和toViewController，toView
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
    
        var fromViewEndFrame = transitionContext.finalFrame(for: fromViewController!)
        fromViewEndFrame.origin.x = UIScreen.main.bounds.size.width
        var fromViewStartFrame = fromViewEndFrame
        let toViewEndFrame = transitionContext.finalFrame(for: toViewController!)
        let toViewStartFrame = toViewEndFrame
    
        let containerView = transitionContext.containerView
        let rect = UIScreen.main.bounds

        if self.navigationOperation == .push { // 如果是push动画
            screenShotArray.append(screenImg)
            
            //这句非常重要，没有这句，就无法正常Push和Pop出对应的界面
            containerView.addSubview(toView!)
            toView?.frame = toViewStartFrame
            
            let nextVC = UIView.init(frame: CGRect.init(x: rect.width, y: 0, width: rect.width, height: rect.height))
            
            //将截图添加到导航栏的View所属的window上
            self.navigationController.view.window?.insertSubview(screentImgView, at: 0)
            nextVC.layer.shadowColor = UIColor.black.cgColor
            nextVC.layer.shadowOffset = CGSize.init(width: -0.8, height: 0)
            nextVC.layer.shadowOpacity = 0.6
            
            self.navigationController.view.transform = CGAffineTransform(translationX: rect.width, y: 0)
        
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                self.navigationController.view.transform = CGAffineTransform(translationX: 0, y: 0)
                screentImgView.center = CGPoint.init(x: rect.width / 2, y: rect.height / 2)

            }, completion: { (_) in
                nextVC.removeFromSuperview()
                screentImgView.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }
        
        if self.navigationOperation == .pop { // 如果是pop
            fromViewStartFrame.origin.x = 0
            containerView.addSubview(toView!)
            
            let lastVcImgView = UIImageView.init(frame: CGRect.init(x: -rect.width, y: 0, width: rect.width, height: rect.height))
            //若removeCount大于0  则说明Pop了不止一个控制器
            if removeCount > 0 {
                for i in 0..<removeCount {
                    if i == removeCount - 1 {
                        //当删除到要跳转页面的截图时，不再删除，并将该截图作为ToVC的截图展示
                        lastVcImgView.image = screenShotArray.last
                        removeCount = 0
                        break
                    }else {
                        if !screenShotArray.isEmpty {
                            screenShotArray.removeLast()
                        }
                    }

                }
            }else {
                lastVcImgView.image = screenShotArray.last

            }
            screentImgView.layer.shadowColor = UIColor.black.cgColor
            screentImgView.layer.shadowOffset = CGSize.init(width: -0.8, height: 0)
            screentImgView.layer.shadowOpacity = 0.6
            self.navigationController.view.window?.addSubview(lastVcImgView)
            self.navigationController.view.addSubview(screentImgView)
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                screentImgView.center = CGPoint.init(x: rect.width * 3 / 2, y: rect.height / 2)
                lastVcImgView.center = CGPoint.init(x: rect.width / 2, y: rect.height / 2)
                
            }, completion: { (_) in
                lastVcImgView.removeFromSuperview()
                screentImgView.removeFromSuperview()
                if !self.screenShotArray.isEmpty {
                    self.screenShotArray.removeLast()
                }
                transitionContext.completeTransition(true)
            })
        }
    }
    
    
}

//
//  JQNavigationController.swift
//  JQNavigationController
//
//  Created by HJQ on 2017/10/22.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

private let kDefaultAlpha = 0.6
private let kTargetTranslateScale = 0.75

class JQNavigationController: UINavigationController {

    var panGestureRec: UIScreenEdgePanGestureRecognizer!
    
    private var screenshotImgView: UIImageView!
    private var coverView: UIView!
    private var screenshotImgs: [UIImage] = [UIImage]()
    private lazy var animationController: JQAnimationContoller =  JQAnimationContoller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        commitInit()
        setupUI()
        viewBindEvents()

    }
    
    // MARK: - Private methods
    private func commitInit() {
        navigationBar.tintColor = UIColor.init(red: 111/255.0, green: 113.0/255.0, blue: 121/255.0, alpha: 1.0)
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize.init(width: -0.8, height: 0)
        view.layer.shadowOpacity = 0.6
    }
    
    private func setupUI() {
        setupScreenshotImgView()
        setupCoverView()
    }
    
    private func viewBindEvents() {
        // 1,创建Pan手势识别器,并绑定监听方法 边缘手势
        panGestureRec = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(panGestureRec(panGestureRec:)))
        panGestureRec.edges = .left
        view.addGestureRecognizer(panGestureRec)
    }
    
    private func setupScreenshotImgView() {
        // 2.创建截图的ImageView
        screenshotImgView = UIImageView.init(frame: UIScreen.main.bounds)
    }
    
    private func setupCoverView() {
        // 3.创建半透明的遮罩
        coverView = UIView.init(frame: screenshotImgView.frame)
        coverView.backgroundColor = UIColor.black
    }

}

extension JQNavigationController {
    // 使用上下文截图,并使用指定的区域裁剪,模板代码
    private func screenShot() {
        // 将要被截图的view,即窗口的根控制器的view(必须不含状态栏,默认ios7中控制器是包含了状态栏的)
        let beyondVC: UIViewController = self.view.window!.rootViewController!
        // 背景图片 总的大小
        let size: CGSize = beyondVC.view.frame.size
        // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        // 要裁剪的矩形范围
        let rect = UIScreen.main.bounds
        //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
        //判读是导航栏是否有上层的Tabbar  决定截图的对象
        if self.tabBarController == beyondVC {
            beyondVC.view.drawHierarchy(in: rect, afterScreenUpdates: false)
        }else {
            self.view.drawHierarchy(in: rect, afterScreenUpdates: false)
        }
        
        // 从上下文中,取出UIImage
        let snapshot: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        // 添加截取好的图片到图片数组
        if let _ = snapshot {
            screenshotImgs.append(snapshot!)
        }
        // 千万记得,结束上下文(移除栈顶的基于当前位图的图形上下文)
        UIGraphicsEndImageContext()
        
    }
}

// MARK: - Event respose
extension JQNavigationController {
    // 监听手势的方法
    @objc func panGestureRec(panGestureRec: UIScreenEdgePanGestureRecognizer) {
        // 如果当前显示的控制器已经是根控制器了，不需要做任何切换动画,直接返回
        if self.visibleViewController == self.viewControllers.first {return}
        // 判断pan手势的各个阶段
        switch panGestureRec.state {
        case .began:
            // 开始拖拽
            dragBegin()
            break
            case .cancelled: break
            case .failed: break
            case .ended:
            // 结束阶段
                dragEnd()
            break
            
        default:
            // 开始拖拽
            dragging(pan: panGestureRec)
            break
        }
    }
    
    // 开始拖动,添加图片和遮罩
    private func dragBegin() {
        // 重点,每次开始Pan手势时,都要添加截图imageview 和 遮盖cover到window中
        view.window?.insertSubview(screenshotImgView, at: 0)
        view.window?.insertSubview(coverView, aboveSubview: screenshotImgView)
        
        // 并且,让imgView显示截图数组中的最后(最新)一张截图
        screenshotImgView.image = screenshotImgs.last
    }
    
    // 正在拖动,动画效果的精髓,进行位移和透明度变化
    private func dragging(pan: UIPanGestureRecognizer) {
        // 得到手指拖动的位移
        let offsetX = pan.translation(in: self.view).x
        
        // 让整个view都平移     // 挪动整个导航view
        if offsetX > 0 {
            view.transform = CGAffineTransform(translationX: offsetX, y: 0)
        }
        
        // 计算目前手指拖动位移占屏幕总的宽高的比例,当这个比例达到3/4时, 就让imageview完全显示，遮盖完全消失
        let currentTranslateScaleX: Double = Double(offsetX / self.view.frame.size.width)
        let rect = UIScreen.main.bounds
        if offsetX < rect.width {
            screenshotImgView.transform = CGAffineTransform(translationX: (offsetX - rect.width) * 0.6, y: 0)
        }
        // 让遮盖透明度改变,直到减为0,让遮罩完全透明,默认的比例-(当前平衡比例/目标平衡比例)*默认的比例
        let alpha: Double = kDefaultAlpha - (currentTranslateScaleX / kTargetTranslateScale) * kDefaultAlpha;
        coverView.alpha = CGFloat(alpha)
    }
    
    // 结束拖动,判断结束时拖动的距离作相应的处理,并将图片和遮罩从父控件上移除
    private func dragEnd() {
        // 取出挪动的距离
        let translateX: CGFloat = self.view.transform.tx
        let width = self.view.frame.size.width
       
        let rect = UIScreen.main.bounds
        if translateX <= 40 {
            // 如果手指移动的距离还不到屏幕的一半,往左边挪 (弹回)
            UIView.animate(withDuration: 0.3, animations: {
                // 重要~~让被右移的view弹回归位,只要清空transform即可办到
                self.view.transform = CGAffineTransform.identity
                // 让imageView大小恢复默认的translation
                self.screenshotImgView.transform = CGAffineTransform(translationX: -rect.width, y: 0);
                // 让遮盖的透明度恢复默认的alpha 1.0
                self.coverView.alpha = CGFloat(kDefaultAlpha)
            }, completion: { (_) in
                // 重要,动画完成之后,每次都要记得 移除两个view,下次开始拖动时,再添加进来
                self.screenshotImgView.removeFromSuperview()
                self.coverView.removeFromSuperview()
            })
        }else {
            // 如果手指移动的距离还超过了屏幕的一半,往右边挪

            UIView.animate(withDuration: 0.3, animations: {
                // 让被右移的view完全挪到屏幕的最右边,结束之后,还要记得清空view的transform
                self.view.transform = CGAffineTransform(translationX: width, y: 0);
                // 让imageView位移还原
                self.screenshotImgView.transform = CGAffineTransform(translationX: 0, y: 0);
                // 让遮盖alpha变为0,变得完全透明
                self.coverView.alpha = 0
            }, completion: { (_) in
                // 重要~~让被右移的view完全挪到屏幕的最右边,结束之后,还要记得清空view的transform,不然下次再次开始drag时会出问题,因为view的transform没有归零
                self.view.transform = CGAffineTransform.identity
                // 移除两个view,下次开始拖动时,再加回来
                self.screenshotImgView.removeFromSuperview()
                self.coverView.removeFromSuperview()
                
                // 执行正常的Pop操作:移除栈顶控制器,让真正的前一个控制器成为导航控制器的栈顶控制器
                self.popViewController(animated: false)
                // 重要~记得这时候,可以移除截图数组里面最后一张没用的截图了
                self.animationController.removeLastScreenShot();
            })
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension JQNavigationController: UINavigationControllerDelegate {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 只有在导航控制器里面有子控制器的时候才需要截图
        if self.viewControllers.count >= 1 {
            // 调用自定义方法,使用上下文截图
            screenShot()
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @discardableResult
    override func popViewController(animated: Bool) -> UIViewController? {
        let index = self.viewControllers.count
        if screenshotImgs.count >=  index - 1 {
            screenshotImgs.removeLast()
        }
        return super.popViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        var removeCount = 0
        
        // 逆序遍历
        for (index, _) in self.viewControllers.enumerated().reversed() {
            if viewController == self.viewControllers[index] {
                break
            }
            screenshotImgs.removeLast()
            removeCount += 1
        }
        animationController.removeCount = removeCount
        return super.popToViewController(viewController, animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        screenshotImgs.removeAll()
        animationController.removeAllScreenShot()
        return super.popToRootViewController(animated: animated)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension JQNavigationController {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animationController.navigationOperation = operation
        self.animationController.navigationController = self
        return self.animationController
    }
}

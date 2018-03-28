//
//  DDTabBarViewController.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class DDTabBarViewController: UITabBarController {
    
    public var homeVC = MMLHomeVC()
    public var hardwareVC = MMLFoundVC()
    public var mallVC = MMLShoppingCartVC()
    public var mineVC = MMLMineVC()
    
    // 当前选中的索引值
    fileprivate var indexFlag:Int! = 0

    // MARK: - System methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = .white
        delegate = self
        setupUI()
    }
    
    
    // MARK: - Private methods
    private func setupUI() {
        let tabBar = UITabBar.appearance()
        tabBar.isTranslucent = false  //避免受默认的半透明色影响，关闭
        tabBar.tintColor = UIColor.init(r: 59, g: 182, b: 74)
        addChildViewControllers()
    }

    /**
     * 添加子控制器
     */
    private func addChildViewControllers() {
        addChildViewController(childController: homeVC, title: "首页", imageName: "home")
        addChildViewController(childController: hardwareVC, title: "发现", imageName: "found")
        addChildViewController(childController: mallVC, title: "购物车", imageName: "shoppingcart")
        addChildViewController(childController: mineVC, title: "我的", imageName: "mine")
    }
    
    /**
     # 初始化子控制器
     
     - parameter childControllerName: 需要初始化的控制器
     - parameter title:               标题
     - parameter imageName:           图片名称
     */
    private func addChildViewController(childController: UIViewController, title: String, imageName: String) {
        // 特别注意：图片有可能出现渲染的问题
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_h")
        childController.title = title
        let navC = DDNavigationViewController(rootViewController: childController)
        addChildViewController(navC)
    }
    
    /// 获取相应的控制器
    ///
    /// - Parameters:
    ///   - sbName: storeboard的名
    ///   - registID: 对应的控制器
    /// - Returns: 对应的控制器
    func getCorreSVC(sbName: String, registID: String) -> UIViewController {
        let sb = UIStoryboard.init(name: sbName, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: registID)
        return vc
    }
    
     // item点击的动画
    fileprivate func animationWithIndex(index: Int) {
        var tabbarbuttonArray:[UIView] = []
        for tabBarButton: UIView in tabBar.subviews {
            
            print(tabBarButton.classForCoder)
            
            if "\(tabBarButton.classForCoder)" == "UITabBarButton" {
                tabbarbuttonArray.append(tabBarButton)
            }
            
            /* if tabBarButton.isKind(of: UITabBarButton.self) == true {
             tabbarbuttonArray.append(tabBarButton)
             }*/
        }
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulse.duration = 0.08
        pulse.repeatCount = 1
        pulse.autoreverses = true
        pulse.fromValue = Float(0.7)
        pulse.toValue = Float(1.3)
        tabbarbuttonArray[index].layer.add(pulse, forKey: nil)
        indexFlag = index
        
    }
}

extension DDTabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index: Int = tabBar.items!.index(of: item)!
        if indexFlag != index {
            animationWithIndex(index: index)
        }
    }
    
    // 设置当前的item是否可以选中
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}

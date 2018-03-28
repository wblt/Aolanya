//
//  DDNavigationViewController.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit


// MARK: - 优雅的管理selector
fileprivate struct Action {
    static let navigationBackClickAction = #selector(DDNavigationViewController.navigationBackClick)
}

class DDNavigationViewController: JQNavigationController {

    // MARK: - system methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //setupScreenPOP()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            // 进入新页面隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_back_white"), style: .plain, target: self, action: Action.navigationBackClickAction)
        }
        
        super.pushViewController(viewController, animated: animated)
        // 获取tabBar的frame, 如果没有直接返回
        guard var frame = self.tabBarController?.tabBar.frame else {
            return
        }
        // 设置frame的y值, y = 屏幕高度 - tabBar高度
        frame.origin.y = UIScreen.main.bounds.size.height - frame.size.height
        // 修改tabBar的frame
        self.tabBarController?.tabBar.frame = frame
    }
    
    // MARK: - Private methods
    private func setupUI() {
        /// 设置导航栏标题
        let navBar = UINavigationBar.appearance()
        navBar.isTranslucent = false
        navBar.barTintColor = DDGlobalNavBarColor()
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
    }
    
    // MARK: - 
    /// 返回按钮
    @objc func navigationBackClick() {
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        popViewController(animated: true)
    }
    
}

extension DDNavigationViewController {
    // MARK: - 添加全屏返回手势
    fileprivate func setupScreenPOP() {
        
        // 1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2.获取手势添加到的View中
        guard let gesView = systemGes.view else { return }
        
        // 3.获取target/action
        // 3.1.利用运行时机制查看所有的属性名称
        //         var count : UInt32 = 0
        //         let ivars = class_copyIvarList(UITableViewRowAction.self, &count)!
        //         for i in 0..<count {
        //         let ivar = ivars[Int(i)]
        //         let name = ivar_getName(ivar)
        //             print(String(cString: name!))
        //         }
        //        free(ivars)
        
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        
        // 3.2.取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        // 3.3.取出Action
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
    }
}

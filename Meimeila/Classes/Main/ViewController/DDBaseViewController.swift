//
//  DDBaseViewController.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import MJRefresh
//import FDFullscreenPopGesture

class DDBaseViewController: UIViewController {

    typealias NavBarItemBlock = (_ button: UIButton) -> ()
    
    private var navBarRightItemBlock: NavBarItemBlock!
    private var navBarBackItemBlcok: NavBarItemBlock!
    
    // 当前的页索引
    var pageIndex = 0
    
    
    // MARK: - System methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //解决 NavigationBar 挡住 view 内容的问题
        //将edgesForExtendedLayout设置成UIRectEdgeNone,表明View是不要扩展到整个屏幕的
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        view.backgroundColor = DDGlobalBGColor()
        // 去除分割线
        navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage.init()
        // 允许全屏滑动返回
        //navigationController?.fd_prefersNavigationBarHidden = true
        setupUI()
    }
    
    // 电池栏相关
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    deinit {
        debugLog("vcdeinit")
    }
    
    // MARK: - Private method
    
    // MARK: - Public method
    
    func setupUI() {}
    
    
    // 设置导航栏的颜色
    func baseViewWillAppearSetNavBar() {
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.init(r: 58, g: 58, b: 58)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.init(r: 58, g: 58, b: 58), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
    }
    
    func baseViewWillDisappearSetNavBar() {
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.init(r: 60, g: 182, b: 74)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
    }
    
    /// 设置上拉，下拉刷新
    // isNeedFooterRefresh false 则是只有头部刷新  默认有上下拉刷新功能
    func setupRefresh(_ taget: UIScrollView, isNeedFooterRefresh: Bool? = true, headerCallback: (()->Void)?, footerCallBack: (()->Void)?) {
        
        weak var tempTarget  = taget
        if let callback = headerCallback {
            
            taget.mj_header = DDRefreshNormalHeader(refreshingBlock: { [weak self] in
                
                self?.pageIndex = 1
                //taget.mj_footer.isHidden = true
                if isNeedFooterRefresh! {
                    tempTarget!.mj_footer.resetNoMoreData()
                }
                callback()
            })
        }
        
        if isNeedFooterRefresh! {
            
            if let callback = footerCallBack {
                let footer = MJRefreshBackStateFooter.init(refreshingBlock: {[weak self] in
                    self?.pageIndex += 15
                    callback()
                })
                
                footer?.setTitle("已显示全部内容", for: MJRefreshState.noMoreData)
                tempTarget!.mj_footer = footer
            }
        }

    }
    
    
    // 添加导航栏右边的按钮
    func addNavBarRightButton(imageName: String?, callBack: @escaping NavBarItemBlock) {
        navBarRightItemBlock = callBack
        let rightButton = UIButton.init(type: .custom)
        rightButton.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        rightButton.setImage(UIImage.init(named: imageName ?? " "), for: .normal)
        rightButton.addTarget(self, action: #selector(baseNavBarRightItemAction(btn:)), for: .touchUpInside)
        let rightItem = UIBarButtonItem.init(customView: rightButton)
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func addNavBarRightButton(btnTitle: String?,titleColor: UIColor?, callBack: @escaping NavBarItemBlock) {
        navBarRightItemBlock = callBack
        let rightButton = UIButton.init(type: .custom)
        rightButton.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        rightButton.setTitle(btnTitle, for: .normal)
        rightButton.setTitleColor(titleColor, for: .normal)
        rightButton.addTarget(self, action: #selector(baseNavBarRightItemAction(btn:)), for: .touchUpInside)
        let rightItem = UIBarButtonItem.init(customView: rightButton)
        navigationItem.rightBarButtonItem = rightItem
    }
    
    // 添加导航栏右边的按钮
    func addNavBarRightButtons(imageNames: [String], callBack: @escaping NavBarItemBlock) {
        navBarRightItemBlock = callBack
        
        var buttons = [UIBarButtonItem]()
        for i in 0..<imageNames.count {
            let rightButton = UIButton.init(type: .custom)
            rightButton.tag = i
            rightButton.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
            rightButton.setImage(UIImage.init(named: imageNames[i]), for: .normal)
            rightButton.addTarget(self, action: #selector(baseNavBarRightItemAction(btn:)), for: .touchUpInside)
            let rightItem = UIBarButtonItem.init(customView: rightButton)
            buttons.append(rightItem)
        }
        navigationItem.rightBarButtonItems = buttons
    }
    
    func addNavBarRightButtons(btnTitles: [String],titleColor: UIColor?, callBack: @escaping NavBarItemBlock) {
        navBarRightItemBlock = callBack
        
        var buttons = [UIBarButtonItem]()
        for i in 0..<btnTitles.count {
            let rightButton = UIButton.init(type: .custom)
            rightButton.tag = i
            rightButton.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
            rightButton.setImage(UIImage.init(named: btnTitles[i]), for: .normal)
            rightButton.addTarget(self, action: #selector(baseNavBarRightItemAction(btn:)), for: .touchUpInside)
            let rightItem = UIBarButtonItem.init(customView: rightButton)
            buttons.append(rightItem)
        }
        navigationItem.rightBarButtonItems = buttons
    }
    
    // 返回按钮
    func addNavBarBackButton(imageName: String?, callBack: @escaping NavBarItemBlock) {
        navBarBackItemBlcok = callBack
        let rightButton = UIButton.init(type: .custom)
        rightButton.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        rightButton.setImage(UIImage.init(named: imageName ?? " "), for: .normal)
        rightButton.addTarget(self, action: #selector(baseNavBarBackItemAction(btn:)), for: .touchUpInside)
        let rightItem = UIBarButtonItem.init(customView: rightButton)
        navigationItem.leftBarButtonItem = rightItem
    }
    
    // MARK: - Action methods
    @objc private func baseNavBarRightItemAction(btn: UIButton) {
        navBarRightItemBlock(btn)
    }
    
    @objc private func baseNavBarBackItemAction(btn: UIButton) {
        navBarBackItemBlcok(btn)
    }

}

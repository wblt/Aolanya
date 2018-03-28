//
//  MMLHomeVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/16.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLHomeVC: DDBaseViewController {

    init() {
        super.init(nibName: String.init(describing: MMLHomeVC.self), bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBindEvents()
        setupFirstLoad()
        if DDDeviceManager.shared.firstLoadStatus() {
            setupShowNewsWelfare()
        }
        requestHomeData()
        addNotifications()
        

    }
    
    override func setupUI() {
        setupNavBar()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        //Add FPS Label
//        let fpsLabel = FPSLabel(frame: CGRect(x: UIScreen.main.bounds.width - 45.0, y:UIScreen.main.bounds.height - 25.0 , width: 40.0, height: 20.0))
//        UIApplication.shared.keyWindow?.addSubview(fpsLabel)
    }
    
    deinit {
        Barista.remove(observer: self, notification: .gotoHome)
        Barista.remove(observer: self, notification: .gotoOrders)
    }
    
    // MARK: - Private method
    private func setupNavBar() {
        navigationItem.titleView = searchView
        addNavBarBackButton(imageName: "home_scan") { [weak self](btn) in
            // 扫码
            self?.navigationController?.pushViewController(MMLScanCodeVC(), animated: true)
        }
        
        addNavBarRightButton(imageName: "home_message") { [weak self](btn) in
            // 消息
            self?.navigationController?.pushViewController(MMLSystemMessageListVC(), animated: true)
        }
    }
    
    // 首次加载
    private func setupFirstLoad() {
        if !DDDeviceManager.shared.firstLoadStatus() {
            let window = UIApplication.shared.keyWindow
            let welcomeVC = WelcomeVC()
            welcomeVC.delegate = self
            welcomeVC.view.frame = UIScreen.main.bounds
            window?.addSubview(welcomeVC.view)
            addChildViewController(welcomeVC)
        }
    }
    
    // 显示新手福利
    private func setupShowNewsWelfare() {
        if !DDDeviceManager.shared.showNewsWelfare() {
            let window = UIApplication.shared.keyWindow
            let newsWelfareVC = MMLNewsWelfareVC()
            newsWelfareVC.view.frame = UIScreen.main.bounds
            newsWelfareVC.delegate = self
            window?.addSubview(newsWelfareVC.view)
            addChildViewController(newsWelfareVC)
        }
    }
    
    private func viewBindEvents() {
        // 自定义返回按钮，导致默认返回手势失效的解决办法
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true // 手势有效设置为YES  无效为NO
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        setupRefresh(tableView, headerCallback: { [weak self] in
            self?.homeDataViewModel.numberPages = 0
            self?.requestHomeData()
        }) {  [weak self] in
            self?.homeDataViewModel.numberPages += 15
            self?.requestHomeData()
        }
    }
    
    private func addNotifications() {
        Barista.add(observer: self, selector: #selector(notificationGotoHomeAction(noti:)), notification: .gotoHome)
        Barista.add(observer: self, selector: #selector(notificationGotoOrdersAction(noti:)), notification: .gotoOrders)
    }
    
    // 获取数据
    private func requestHomeData() {
        homeDataViewModel.getHomeData() {[weak self] in
            // 1.设置轮播图
            self?.homeHeaderView.banners = self?.homeDataViewModel.homeDataModel?.banner
            self?.homeHeaderView.modulars = self?.homeDataViewModel.homeDataModel?.modular
            debugLog(self?.homeDataViewModel.homeDataModel?.banner)
            // 2.设置资讯 和 设置推荐商品
            self?.tableView.reloadData()
        }
    }
    
    // 是否需要登录
    private func checkInLogin() -> Bool{
        if !DDDeviceManager.shared.loginStatue() {
            let vc = MMLLoginVC()
            navigationController?.pushViewController(vc, animated: true)
            return true
        }
        return false
    }
    
    // MARK: - Eevent respose
    
    // MARK: - Action methods
    //
    @objc func notificationGotoHomeAction(noti: NSNotification) {
        tabBarController?.selectedIndex = 0
    }
    
    @objc func notificationGotoOrdersAction(noti: NSNotification) {
        // 返回个人中心跳转订单
        tabBarController?.selectedIndex = 3
        let nav: UINavigationController =  tabBarController?.selectedViewController as! UINavigationController
        let VC = MMLMineOrderVC()
        nav.pushViewController(VC, animated: true)
    }
    
    // 跳转到搜索
    @objc func searchAction() {
        navigationController?.pushViewController(MMLSearchVC(), animated: true)
    }
    
    // MARK: - Lazy load
    private lazy var tableView: UITableView = {[weak self] in
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView.init()
        tableView.tableHeaderView = self?.homeHeaderView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120.0
        tableView.register(UINib.init(nibName: String.init(describing: MMLHomeListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLHomeListTableViewCell.self))
        return tableView
        }()
    
    private lazy var homeHeaderView: MMLHomeHeaderView = {[weak self] in
        let view = MMLHomeHeaderView.init(frame: CGRect.zero)
        view.parentVC = self
        return view
    }()
    
    private lazy var homeDataViewModel: DDHomeDataViewModel = {[weak self] in
        let viewModel = DDHomeDataViewModel.init()
        viewModel.tableView = self?.tableView
        return viewModel
        }()
    
    // 导航栏搜索框
    // TODO: - pop回来titleView不见了 是因为使用约束的问题
    private lazy var searchView: UIView = {[weak self] in
        let width = UIScreen.main.bounds.size.width * 250 / 375.0
        let searchFrame = CGRect(x: 0, y: 0, width: width, height: 30)
        let view = UIView.init(frame: searchFrame)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        self?.searchViewButton.frame = CGRect.init(x: (width - 100)/2, y: 0, width: 100, height: 30)
        view.addSubview((self?.searchViewButton)!)
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(searchAction))
        view.addGestureRecognizer(tapGes)
        return view
    }()
    
    private lazy var searchViewButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.isUserInteractionEnabled = false
        button.setImage(UIImage.init(named: "mall_search"), for: .normal)
        button.setTitle(" 搜索", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        return button
    }()
}

// MARK: - UITableViewDataSource
extension MMLHomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = tableView.mj_footer {
            tableView.mj_footer.isHidden = homeDataViewModel.productListDatas.isEmpty
        }
        return homeDataViewModel.productListDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MMLHomeListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLHomeListTableViewCell.self)) as? MMLHomeListTableViewCell
        if let _ = cell {
        }else {
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLHomeListTableViewCell.self), owner: nil, options: nil)?.first as? MMLHomeListTableViewCell
        }
        cell?.separatorInset.left = 0
        cell?.shoppingData = homeDataViewModel.productListDatas[indexPath.row]
        return cell!
    }
    
}

// MARK: - UITableViewDelegate
extension MMLHomeVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MMLProductDetailsVC()
        vc.shoppingID = homeDataViewModel.productListDatas[indexPath.row].shopingID
        navigationController?.pushViewController(vc, animated: true)
    }
}

// 引导页显示完成
// MARK: - WelcomeVCDelegate
extension MMLHomeVC: WelcomeVCDelegate {
    func welcomeVCShowFinish() {
        setupShowNewsWelfare()
    }
    
    
}

// 新手福利
// MARK: - MMLNewsWelfareVCDelegate
extension MMLHomeVC: MMLNewsWelfareVCDelegate {
    func newsWelfareVCCloseAction(isNeverShow: Bool) {
        DDDeviceManager.shared.saveShowNewsWelfare(isShowNewsWelfare: isNeverShow)
    }
    
    func newsWelfareVCReceiveAction(isNeverShow: Bool) {
        DDDeviceManager.shared.saveShowNewsWelfare(isShowNewsWelfare: isNeverShow)
        if checkInLogin() {return}
    }
    
    
}

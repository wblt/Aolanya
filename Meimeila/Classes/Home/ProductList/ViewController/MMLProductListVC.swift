//
//  MMLProductListVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/18.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLProductListVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var latestButton: UIButton!
    @IBOutlet weak var salesButton: UIButton!
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var salesScreeningButton: UIButton!
    @IBOutlet weak var priceScreeningButton: UIButton!
    
    // 记录当前点击的按钮
    private var currentSelectedButton: UIButton = UIButton()
    
    var keyWord: String = ""
    private var type: Int = 0
    // 销量降序
    private var isSalesDesc: Bool = true
    // 价格降序
    private var isPriceDesc: Bool = true
    
    init() {
        super.init(nibName: String.init(describing: MMLProductListVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseViewWillAppearSetNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        baseViewWillDisappearSetNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresh()
        searchTextField.text = keyWord
        requestProductListData()
        currentSelectedButton = latestButton
    }
    
    override func setupUI() {
        setupNavBar()
        setupTableView()
    }
    
    // MARK: - Private methods
    
    // 设置导航栏
    private func setupNavBar() {
        
        addNavBarBackButton(imageName: "btn_back") { [weak self](btn) in
            self?.navigationController?.popViewController(animated: true)
        }
        
        navigationItem.titleView = searchTextField
        
        addNavBarRightButton(btnTitle: "搜索", titleColor: UIColor.lightGray) { [weak self](btn) in
            if  self?.searchTextField.text!.trimmingCharacters(in: .whitespaces).count != 0 {
                self?.tableView.mj_header.beginRefreshing()
                self?.view.endEditing(false)
            }

        }
    }
    
    // 获取商品列表数据
    private func requestProductListData() {
        productListViewModel.getProductList(keyword: searchTextField.text ?? "", type: type, successBlock: {[weak self] in
            self?.tableView.reloadData()
        })
    }
    
    // 添加上下拉刷新
    private func setupRefresh() {
        setupRefresh(tableView, headerCallback: { [weak self] in
            self?.productListViewModel.numberPages = 0
            self?.requestProductListData()
        }) {  [weak self] in
            self?.productListViewModel.numberPages += 15
            self?.requestProductListData()
            
        }
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120.0
        tableView.register(UINib.init(nibName: String.init(describing: MMLHomeListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLHomeListTableViewCell.self))
    }
    
    // MARK: - Event respose
    // 商品刷选
    @IBAction func screeningAction(_ sender: Any) {
        let button = sender as! UIButton
        if currentSelectedButton != button {
            button.setTitleColor(UIColor.red, for: .normal)
            currentSelectedButton.setTitleColor(UIColor.init(r: 58, g: 58, b: 58), for: .normal)
            currentSelectedButton = button
            
            // 销量
            if button == salesButton {
                isSalesDesc = true
                type = isSalesDesc ? button.tag : 4
                salesScreeningButton.setImage(UIImage.init(named: isSalesDesc ? "search_price_down" : "search_price_up"), for: .normal)
            }else if button == priceButton { // 价格
                isPriceDesc = true
                type = isPriceDesc ? button.tag : 5
                priceScreeningButton.setImage(UIImage.init(named: isPriceDesc ? "search_price_down" : "search_price_up"), for: .normal)
            }else {
                isSalesDesc = true
                isPriceDesc = true
                type = button.tag
                salesScreeningButton.setImage(UIImage.init(named: "search_price"), for: .normal)
                priceScreeningButton.setImage(UIImage.init(named: "search_price"), for: .normal)
            }
            
        }else {
            // 销量
            if button == salesButton {
                isSalesDesc = !isSalesDesc
                type = isSalesDesc ? button.tag : 4
                salesScreeningButton.setImage(UIImage.init(named: isSalesDesc ? "search_price_down" : "search_price_up"), for: .normal)
            } else if button == priceButton { // 价格
                isPriceDesc = !isPriceDesc
                type = isPriceDesc ? button.tag : 5
                priceScreeningButton.setImage(UIImage.init(named: isPriceDesc ? "search_price_down" : "search_price_up"), for: .normal)
                
            }else {
                type = button.tag
            }
        }
        self.tableView.mj_header.beginRefreshing()
    }
    
    
    // MARK: - lazy load
    // TODO: 宽度需要按比例
    private lazy var searchTextField: UITextField = {
        let width = Screen.width * 250 / 375
        let leftImageView = UIImageView.init(image: UIImage.init(named: "mall_search"))
        leftImageView.contentMode = .center
        leftImageView.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let textField = DDMallSearchTextField.init(leftView: leftImageView, frame: CGRect.init(x: 0, y: 0, width: width, height: 30), color: nil, boardWidth: 0, boardRadius: 15)
        textField.backgroundColor = DDGlobalBGColor()
        textField.placeholder = "搜索商品"
        textField.returnKeyType = .search
        textField.delegate = self
        return textField
    }()
    
    fileprivate lazy var productListViewModel: DDProductListViewModel = {[weak self] in
        let vm = DDProductListViewModel()
        vm.tableView = self?.tableView
        return vm
        }()

}

// MARK: - UITableViewDataSource
extension MMLProductListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = tableView.mj_footer {
            tableView.mj_footer.isHidden = productListViewModel.productListDatas.isEmpty
        }
        return productListViewModel.productListDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MMLHomeListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLHomeListTableViewCell.self)) as? MMLHomeListTableViewCell
        if let _ = cell {
        }else {
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLHomeListTableViewCell.self), owner: nil, options: nil)?.first as? MMLHomeListTableViewCell
        }
        cell?.separatorInset.left = 0
        cell?.productListData = productListViewModel.productListDatas[indexPath.row]
        return cell!
    }
    
}

// MARK: - UITableViewDelegate
extension MMLProductListVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MMLProductDetailsVC()
        vc.shoppingID = productListViewModel.productListDatas[indexPath.row].shopingID
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension MMLProductListVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if  self.searchTextField.text!.trimmingCharacters(in: .whitespaces).count != 0 {

        }
        return true
    }
}

//
//  MMLShoppingCartVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/16.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLShoppingCartVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomBGView: UIView!
    
    // 是否是编辑状态
    fileprivate var isEdit: Bool = false
    // 导航栏右边的按钮
    fileprivate var navBarRightButton: UIButton = UIButton()
    fileprivate var selectAllPayButton: UIButton = UIButton()
    fileprivate var selectAllDeletedButton: UIButton = UIButton()
    
    // 总价
    fileprivate var totalPrice: Double = 0.0
    
    //总邮费
    fileprivate var totalPostPrice: Double = 0.0
    
    // 需要删除的数据
    fileprivate var needDeletedArray: [DDShoppingCarListData] = [DDShoppingCarListData]()
    fileprivate var needDeletedIndexArray: [Int] = [Int]()
    
    init() {
        super.init(nibName: String.init(describing: MMLShoppingCartVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        requestCarListData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "购物车结算"
        viewBindEvent()
     //   requestCarListData()
    }
    
    override func setupUI() {
        setupNavBar()
        setupTableView()
        bottomBGView.addSubview(shoppingCarBottomView)
        shoppingCarBottomView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Private methods
    private func setupNavBar() {
        addNavBarRightButton(btnTitle: "编辑", titleColor: UIColor.white) { [weak self](btn) in
            self?.navBarRightButton = btn
            btn.setTitle("完成", for: .selected)
            btn.isSelected = !btn.isSelected
            self?.isEdit = btn.isSelected
            self?.tableView.reloadData()
            self?.shoppingCarBottomView.type = (self?.isEdit)!
        }
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView.init()
        tableView.backgroundColor = DDGlobalBGColor()
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: String.init(describing: DDShoppingCarListCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: DDShoppingCarListCell.self))
    }
    
    // 商品的全选
    // type 当前的状态 isCancelAllSelected 是否取消全选
    fileprivate func productListAllSelected(type: Bool, isCancelAllSelected: Bool = false) {
        shoppingcarViewModel.shoppingCarListDatas.forEach { (data) in
            if type == false {
                data.isSelectedPay = true
                if isCancelAllSelected {
                    data.isSelectedPay = false
                }
            }else {
                data.isSelectedDeleted = true
                if isCancelAllSelected {
                    data.isSelectedDeleted = false
                }
            }
        }
        calculationTotalPrice()
        tableView.reloadData()
    }
    
    // 计算总价
    fileprivate func calculationTotalPrice() {
        totalPrice = 0.0
        totalPostPrice = 0.0
        shoppingcarViewModel.shoppingCarListDatas.forEach { (data) in
            if data.isSelectedPay {
                totalPrice += Double(data.shoppingCartNumber)! * Double(data.price)!
                
               let post = Double(data.postage)!
                
                if  totalPostPrice == 0.0{
                    
                    totalPostPrice = post;
                }else if post < totalPostPrice{
                    totalPostPrice = post
                    
                }
                
            }
        }
        // 总价为
        debugLog("总价为===》\(totalPrice),邮费为====》\(totalPostPrice)")
        
        shoppingCarBottomView.setupPriceInfo(totalPrice: totalPrice + totalPostPrice,and: totalPostPrice);
        
        
        
        
    }
    
    // 回去删除的shoppingID
    fileprivate func getDeletedShoppingID() -> String{
        var deletedShoppingID = ""
        needDeletedArray.removeAll()
        needDeletedIndexArray.removeAll()
        
        for (index, value) in shoppingcarViewModel.shoppingCarListDatas.enumerated() {
            if value.isSelectedDeleted {
                needDeletedArray.append(value)
                needDeletedIndexArray.append(index)
            }
        }
		
		var shopIdArray = Array<Any>()
		
        // 拼接要删除的商品ID
        for i in 0..<needDeletedArray.count {
            let model = needDeletedArray[i]
			var shopid = [String:String]()
			shopid["shoppingId"] = model.shopingID
			shopIdArray.append(shopid)
            if i != needDeletedArray.count - 1 {
                deletedShoppingID += model.shopingID + "##"
            }else {
                deletedShoppingID += model.shopingID
            }
        }
		
		let data = try?JSONSerialization.data(withJSONObject: shopIdArray, options: JSONSerialization.WritingOptions.prettyPrinted)
		deletedShoppingID = String.init(data: data!, encoding:String.Encoding(rawValue: String.Encoding.utf8.rawValue) )!
		
        return deletedShoppingID
        
    }
    
    // 获取购物车列表
    private func requestCarListData() {
        shoppingcarViewModel.getshoppingCarList {[weak self] in
            self?.tableView.reloadData()
            // 如果是下拉刷新全选按钮状态重置
            if self?.shoppingcarViewModel.numberPages == 0 {
                self?.selectAllPayButton.isSelected = false
                self?.selectAllDeletedButton.isSelected = false
                self?.calculationTotalPrice()
            }
            
            // 设置数量
            let count = self?.shoppingcarViewModel.shoppingCarListDatas.count ?? 0
            if count == 0 {
                self?.title = "购物车结算"
            }else {
                self?.title = "购物车(\(count))"
            }
            
        }
    }
    
    // 商品删除
    fileprivate func requestProductDeletedData(shoppingID: String) {
        shoppingcarViewModel.productDeleted(shoppingID: shoppingID) {[weak self] in
			
//			self?.needDeletedIndexArray.forEach({ (index) in
//                self?.shoppingcarViewModel.shoppingCarListDatas.remove(at: index)
//            })
			
			self?.shoppingcarViewModel.numberPages = 0
			self?.requestCarListData()
			
            // 设置数量
            let count = self?.shoppingcarViewModel.shoppingCarListDatas.count ?? 0
            if count == 0 {
                self?.title = "购物车结算"
            }else {
                self?.title = "购物车(\(count))"
            }
            self?.tableView.reloadData()
            self?.calculationTotalPrice()
        }
    }
    
    // MARK: - event respose
    private func viewBindEvent() {
		
        setupRefresh(tableView, isNeedFooterRefresh: false, headerCallback: {[weak self] in
            self?.shoppingcarViewModel.numberPages = 0
            self?.requestCarListData()
            
        }) {[weak self] in
            self?.shoppingcarViewModel.numberPages += 15
            self?.requestCarListData()
        }
    }
    
    // MARK: - lazy load
    private lazy var shoppingCarBottomView: DDShoppingCarBottomView = {
        let view = DDShoppingCarBottomView.init(frame: CGRect.zero)
        view.delegate = self
        return view
    }()
    
    fileprivate lazy var shoppingcarViewModel: DDShoppingCarViewModel = {[weak self] in
        let shoppingCarViewModel = DDShoppingCarViewModel()
        shoppingCarViewModel.tableView = self?.tableView
        return shoppingCarViewModel
        }()
    
}

// MARK: - UITableViewDataSource
extension MMLShoppingCartVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.displayprompts(message: "购物车空着哦~", image: "shopping_cart_empty", cellCount: shoppingcarViewModel.shoppingCarListDatas.count)
        if let _ = tableView.mj_footer {
            tableView.mj_footer.isHidden = shoppingcarViewModel.shoppingCarListDatas.isEmpty
        }
        return shoppingcarViewModel.shoppingCarListDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: DDShoppingCarListCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: DDShoppingCarListCell.self)) as? DDShoppingCarListCell
        if let _ = cell {
        }else {
            cell = Bundle.main.loadNibNamed(String.init(describing: DDShoppingCarListCell.self), owner: nil, options: nil)?.first as? DDShoppingCarListCell
        }
        cell?.type = isEdit
        cell?.indexPath = indexPath
        cell?.shoppingCarListData = shoppingcarViewModel.shoppingCarListDatas[indexPath.row]
        cell?.delegate = self
        return cell!
    }
    


}

// MARK: - UITableViewDelegate
extension MMLShoppingCartVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let VC = MMLProductDetailsVC()
        VC.shoppingID = shoppingcarViewModel.shoppingCarListDatas[indexPath.row].shopingID
        // 跳转到商品详情
        navigationController?.pushViewController(VC, animated: true)
    }
}

// MARK: - DDShoppingCarBottomViewDlegate
extension MMLShoppingCartVC: DDShoppingCarBottomViewDlegate {
    func shoppingCarBottomViewSlectedButton(button: UIButton, type: Int) {
        let tempType = ShoppingCarBottomViewBtnType(rawValue: type)!
        switch tempType {
            
        case .deletedSelectedAllType:
            selectAllDeletedButton = button
            button.isSelected = !button.isSelected
            // 编辑状态的全选
            productListAllSelected(type: isEdit, isCancelAllSelected: !button.isSelected)
            break
        case .tosettleaccountsSelectedAllType:
            selectAllPayButton = button
            button.isSelected = !button.isSelected
            // 结算状态的全选
            productListAllSelected(type: isEdit, isCancelAllSelected: !button.isSelected)
            break
        case .deletedType:
            let deletedShoppingID =  getDeletedShoppingID()
            debugLog("将要删除的shoppingID===>" + deletedShoppingID)
			// 删除
			requestProductDeletedData(shoppingID: deletedShoppingID)
			
			
            break
        case .tosettleaccountsType:
            
            // 需要下单的商品信息
            let VC = MMLSettlementVC()
            
            let model = MMLSettlementProductInfoModel()
            shoppingcarViewModel.shoppingCarListDatas.forEach { (data) in
                if data.isSelectedPay {
                    model.productList.append(data)
                }
            }
            model.totalPrice = totalPrice
            VC.productInfoModel = model
            model.totalPostPrice = totalPostPrice;
            
            if model.productList.count == 0 {
                BFunction.shared.showMessage("请选择商品再结算")
                return
            }
            // 结算
            navigationController?.pushViewController(VC, animated: true)
            break
            
        }
        debugLog("底部按钮点击")
    }
}

// MARK: - DDShoppingCarListCellDelegate
extension MMLShoppingCartVC: DDShoppingCarListCellDelegate {
    // 选择之后重新计算总价
    func selectedProduct(indexPath: IndexPath) {
        calculationTotalPrice()
    }
    
    // 增加商品数量
    func productIncrease(indexPath: IndexPath, addOrSubView: DDProductAddOrSubtractView, textField: UITextField) {
        let model = shoppingcarViewModel.shoppingCarListDatas[indexPath.row]
        shoppingcarViewModel.productIncrease(shoppingID: model.shopingID, number: "1", successBlock: {[weak self] in
            // TODO: 如果数量有问，则要取接口数据
            let number = Int(model.shoppingCartNumber)! + 1
            model.shoppingCartNumber = "\(number)"
            self?.calculationTotalPrice()
            self?.tableView.reloadRows(at: [indexPath], with: .none)
        })
    }
    
    // 减少商品数量
    func productDeIncrease(indexPath: IndexPath, addOrSubView: DDProductAddOrSubtractView, textField: UITextField) {
        let model = shoppingcarViewModel.shoppingCarListDatas[indexPath.row]
        shoppingcarViewModel.productDeincrease(shoppingID: model.shopingID, number: "1") {[weak self] in
            if Int(model.shoppingCartNumber)! > 1 {
                // TODO: 如果数量有问，则要取接口数据
                let number = Int(model.shoppingCartNumber)! - 1
                model.shoppingCartNumber = "\(number)"
            }
            self?.calculationTotalPrice()
            self?.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
}

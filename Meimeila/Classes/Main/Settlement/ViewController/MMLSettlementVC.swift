//
//  MMLSettlementVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftyJSON
class MMLSettlementVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightCons: NSLayoutConstraint!
    
    // 地址相关
    @IBOutlet weak var addAddressView: UIView!
    @IBOutlet weak var detailAddressView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailAddressLabel: UILabel!
    @IBOutlet weak var bottomAddressLabel: UILabel!
    
    // 选择支付方式相关
    @IBOutlet weak var wechatPayView: UIView!
    @IBOutlet weak var wechatSelectedButton: UIButton!
    @IBOutlet weak var aliPayView: UIView!
    @IBOutlet weak var aliPaySelectedButton: UIButton!
    
    
    @IBOutlet weak var moneyPayView: UIView!
    
    @IBOutlet weak var moneyPayBt: UIButton!
    //运费
    @IBOutlet weak var transportMoney: UILabel!
    
    // 配送和发票
    @IBOutlet weak var distributionView: UIView!
    @IBOutlet weak var invoiceView: UIView!
    // 发票类型
    @IBOutlet weak var invoiceTypeLabel: UILabel!
    
    /// 商品价格和配送费用
    @IBOutlet weak var productPriceLabel: UILabel!
    
    // 留言
    @IBOutlet weak var messageTF: UITextField!
    
    // 总计
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var productInfoModel: MMLSettlementProductInfoModel!
    private var addressID: String!
    private var isHaveToPay: Bool = false // 是否已经支付过了
    
    var invoiceJson:String?
    
    init() {
        super.init(nibName: String.init(describing: MMLSettlementVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.sharedManager().enable = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.sharedManager().enable = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "用户结算"
        adjustLayout()
        viewBindEvents()
        addNotificationMonitor()
        requesetDefaultAddressData()
    }
    
    deinit {
        Barista.remove(observer: self, notification: .aliPayResult)
        Barista.remove(observer: self, notification: .wechatPayResult)
    }
    
    override func setupUI() {
        setupTableView()
        self.addAddressView.isHidden = true
        self.bottomAddressLabel.isHidden = true
    }
    
    // MARK: - Private method
    private func setupTableView() {
        tableView.tableFooterView = UIView.init()
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: String.init(describing: MMLSettlementProductListCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLSettlementProductListCell.self))
    }
    
    private func adjustLayout() {
        tableViewHeightCons.constant = CGFloat(60 * productInfoModel.productList.count)
        totalPriceLabel.text = "合计:￥" + "\(productInfoModel.totalPrice + productInfoModel.totalPostPrice)"
        
        productPriceLabel.text =  "￥" + "\(productInfoModel.totalPrice)"
        
        transportMoney.text = "￥" + "\(productInfoModel.totalPostPrice)"
        
        // 默认使用微信支付
        wechatSelectedButton.isSelected = true
        
    }
    
    ///转json字符串
    func jsonString() -> String{
        var dic = [String:String]()
        //dic["invoiceTitle"] = "个人";
		dic["invoiceName"] = "放弃发票";
        dic["invoiceType"] = "纸质发票";
        let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0));
        let js = String.init(data: data!, encoding: String.Encoding.utf8)
        
        print("invoice json string--->>>>",js!);
        return js!;
    }
    
    
    // 添加通知监听微信或者支付支付的结果
    private func addNotificationMonitor() {
        
        Barista.add(observer: self, selector: #selector(wechatPayResultNotification(noti:)), notification: .wechatPayResult)
        Barista.add(observer: self, selector: #selector(aliPayResultNotification(noti:)), notification: .aliPayResult)
    }

    
    private func viewBindEvents() {
        // 1.没有默认地址添加地址
        let addAddressTapGes = UITapGestureRecognizer.init(target: self, action: #selector(addressAction(tap:)))
        addAddressView.tag = 0
        addAddressView.addGestureRecognizer(addAddressTapGes)
        
        // 选择地址
        let detailAddressTapGes = UITapGestureRecognizer.init(target: self, action: #selector(addressAction(tap:)))
        detailAddressView.tag = 1
        detailAddressView.addGestureRecognizer(detailAddressTapGes)
        
        // 支付
        let wechatPayTapGes = UITapGestureRecognizer.init(target: self, action: #selector(selectedPayMethodAction(tap:)))
        wechatPayView.tag = 0
        wechatPayView.addGestureRecognizer(wechatPayTapGes)
        
        let aliPayTapGes = UITapGestureRecognizer.init(target: self, action: #selector(selectedPayMethodAction(tap:)))
        aliPayView.tag = 1
        aliPayView.addGestureRecognizer(aliPayTapGes)
        
        
        let moneyPayTapGes = UITapGestureRecognizer.init(target: self, action: #selector(selectedPayMethodAction(tap:)))
        moneyPayView.tag = 2
        moneyPayView.addGestureRecognizer(moneyPayTapGes)
        
        
        // 发票
        let invoiceTapGes = UITapGestureRecognizer.init(target: self, action: #selector(invoiceAction(tap:)))
        invoiceView.addGestureRecognizer(invoiceTapGes)
        
    }
    
    // 支付宝支付
    func aliPayAction() {
        DDAliPay.shared.payAction(orderStr: settlementViewModel.aliPayModel.getAlipay) { (result) in
            debugLog(result)
            Barista.post(notification: .aliPayResult, object: result as AnyObject)
        }
    }
    
    // 微信支付
    func wechatPayAction() {
        DDWechatPay.shared.payAction(payModel: settlementViewModel.wechatPayModel)
    }
    
    // MARK: - Lazy load
    private lazy var settlementViewModel: MMLSettlementViewModel = {
        let vm = MMLSettlementViewModel.init()
        return vm
    }()
    
}

// MARK: - 获取网络数据
extension MMLSettlementVC {
    
    // 获取默认地址
    private func requesetDefaultAddressData() {
        settlementViewModel.getDefaultAddress {[weak self] in
            let model = self?.settlementViewModel.defaultAddressModel?.data
            if model == nil { // 当前没有默认的收货地址
                
                self?.addAddressView.isHidden = false
                self?.detailAddressView.isHidden = true
                
            }else { // 默认有收货地址
                self?.bottomAddressLabel.isHidden = false
                self?.addAddressView.isHidden = true
                self?.detailAddressView.isHidden = false
                self?.addressID = model?.adressID
                self?.nameLabel.text = (model?.consignee)! + "  " + (model?.addresseePhone)!
                self?.detailAddressLabel.text = (model?.localArea)! + (model?.detailedAddress)!
                self?.bottomAddressLabel.text = "配送至：" + (model?.localArea)! + (model?.detailedAddress)!
            }
        }
    }
    
    // 支付宝下单
    private func requestAliPayOrderData() {
        
        var orders = [[String: String]]()
        productInfoModel.productList.forEach { (data) in
            var dict = [String: String]()
            dict["shoppingID"] = data.shopingID
            dict["shoppingNumber"] = data.shoppingCartNumber
			dict["price"] = data.price
            orders.append(dict)
        }
		
		let str = totalPriceLabel.text!
		let index = str.index(str.startIndex, offsetBy:4)//获取字符d的索引
		let result = str.substring(from: index)
		
        // 转换成json字符串
        let data = try? JSONSerialization.data(withJSONObject: orders, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        let strJson = String(data: data!, encoding: String.Encoding.utf8)
       
        settlementViewModel.placeAliPayOrder(orders: strJson!, addressID: addressID,invoice: invoiceJson ?? jsonString(),total:result) {[weak self] in
            self?.aliPayAction()
        }
        
    }
    
    // 微信下单
    private func requestWechatOrderData() {
        var orders = [[String: String]]()
        productInfoModel.productList.forEach { (data) in
            var dict = [String: String]()
            dict["shoppingID"] = data.shopingID
            dict["shoppingNumber"] = data.shoppingCartNumber
			dict["price"] = data.price
            orders.append(dict)
        }
		
		let str = totalPriceLabel.text!
		let index = str.index(str.startIndex, offsetBy:4)//获取字符d的索引
		let result = str.substring(from: index)
	
        // 转换成json字符串
        let data = try? JSONSerialization.data(withJSONObject: orders, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        let strJson = String(data: data!, encoding: String.Encoding.utf8)
        settlementViewModel.placewechatPayOrder(orders: strJson!, addressID: addressID,invoice: invoiceJson ?? jsonString(),total: result) {[weak self] in
            self?.wechatPayAction()
        }
    }
    
    
    ///余额支付
    private func moneyPay(){
        
        var orders = [[String: String]]()
        productInfoModel.productList.forEach { (data) in
            var dict = [String: String]()
            dict["shoppingID"] = data.shopingID
            dict["shoppingNumber"] = data.shoppingCartNumber
            orders.append(dict)
        }
        // 转换成json字符串
        let data = try? JSONSerialization.data(withJSONObject: orders, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        let strJson = String(data: data!, encoding: String.Encoding.utf8)
        
        let vc = MMLMoneyPayKeyBoardVC();
        vc.payModel = MMLMoneyPayModel.init(orders: strJson!, addressID: addressID, orderID: nil,invoice: invoiceJson ?? jsonString());
        
        vc.delegate = self;
        
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.5);
        vc.modalPresentationStyle = .overFullScreen;
        self.present(vc, animated: false, completion: {
        })
    }
    
}


extension MMLSettlementVC:MMLMoneyPayKeyBoardVCDelegate{
    func exchangeGiftPW(pw: String) {
        
    }
    
    func paySucceeds(issucceeds: Bool) {
        // 跳转到结算页
        let VC = MMLPayResultVC()
        VC.isPaySuccess = issucceeds

        navigationController?.pushViewController(VC, animated: true)
    }
    
  
    func forgetPw() {
        
        let vc = MMLMineSet();
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    
}


// MARK: - Event respose
extension MMLSettlementVC {
    
    // 微信支付的结果
    @objc func wechatPayResultNotification(noti: Notification) {
        debugLog(noti.object)
        let index = noti.object as! Int
        let isPaySuccess: Bool = index == 0 ? true : false
        if !isHaveToPay {
            isHaveToPay = true
            // 跳转到结算页
            let VC = MMLPayResultVC()
            VC.isPaySuccess = isPaySuccess
            VC.isFormType = 0
            VC.wechatPayModel = settlementViewModel.wechatPayModel
            navigationController?.pushViewController(VC, animated: true)
        }

    }
    
    // 支付宝支付的结果
    @objc func aliPayResultNotification(noti: Notification) {
        debugLog(noti.object)
        guard let result: [String: Any] = noti.object as! [String : Any] else {return};
        
        let index :NSString  = (result["resultStatus"] as? NSString)!
        
        let isPaySuccess: Bool = index == "9000"  ? true : false
        if !isHaveToPay {
            isHaveToPay = true
            // 跳转到结算页
            let VC = MMLPayResultVC()
            VC.isPaySuccess = isPaySuccess
            VC.isFormType = 1
            VC.orderStr = settlementViewModel.aliPayModel.getAlipay
            navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @objc  func addressAction(tap: UITapGestureRecognizer) {
        let tag = (tap.view?.tag)!
        if tag == 0{
            debugLog("添加地址")
            let VC = MMLAddNewAddressVC()
            VC.delegate = self
            navigationController?.pushViewController(VC, animated: true)
        }else {
            debugLog("选择地址")
            let VC = MMLMineAddressVC()
            VC.delegate = self
            navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    // 选择支付方式
    @objc  func selectedPayMethodAction(tap: UITapGestureRecognizer) {
        let tag = (tap.view?.tag)!
        if tag == 0{
            debugLog("微信支付")
            wechatSelectedButton.isSelected = true
            aliPaySelectedButton.isSelected = false
            moneyPayBt.isSelected = false;

        }else if tag == 1 {
            debugLog("支付宝支付")
            aliPaySelectedButton.isSelected = true
            wechatSelectedButton.isSelected = false
            moneyPayBt.isSelected = false;

        }else{
            debugLog("余额支付")

            aliPaySelectedButton.isSelected = false
            wechatSelectedButton.isSelected = false
            moneyPayBt.isSelected = true;
        }
    }
    
    // 发票相关
    @objc func invoiceAction(tap: UITapGestureRecognizer) {
        BFunction.shared.showToastMessge("暂不支持开具发票，有需要请联系客服！")
//        let VC = MMInvoiceVC()
//        VC.delegate = self
//        navigationController?.pushViewController(VC, animated: true)
    }
    
    // 去付款
    @IBAction func payAction(_ sender: Any) {
        
        if addressID != nil {  // 当前地址可以用
            if wechatSelectedButton.isSelected {
                // 判断是否安装了微信
                if  DDWechatPay.shared.isWXAppInstalled() {
                    requestWechatOrderData()
                }else {
                    BFunction.shared.showToastMessge("您尚未安装微信客户端，请安装后再来支付")
                }
                
            }else if aliPaySelectedButton.isSelected{
                requestAliPayOrderData()
            }else{
                
                print("余额支付");
                
                moneyPay();
            }
            
        }else {
            BFunction.shared.showToastMessge("请添加收货地址")
        }
        
    }
    
}

/// 评价列表
// MARK: - UITableViewDelegate
extension MMLSettlementVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MMLSettlementVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productInfoModel.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MMLSettlementProductListCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLSettlementProductListCell.self)) as? MMLSettlementProductListCell
        if let _ = cell {
        }else {
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLSettlementProductListCell.self), owner: nil, options: nil)?.first as? MMLSettlementProductListCell
        }
        cell?.data = productInfoModel.productList[indexPath.row]
        return cell!
    }
}

// 发票信息
// MARK: - MMInvoiceVCDelegate
extension MMLSettlementVC: MMInvoiceVCDelegate {
    func invoiceSave(text: String, json: String) {
        invoiceTypeLabel.text = text
        print(json);
        invoiceJson = json;
    }
    
    
}

// 添加收货地址
// MARK: - MMLAddNewAddressVCDelegate
extension MMLSettlementVC: MMLAddNewAddressVCDelegate {
    func addNewAddressVCAddAddressSuccess(model: AddressModel?) {
        bottomAddressLabel.isHidden = false
        addAddressView.isHidden = true
        detailAddressView.isHidden = false
        addressID = model?.addressID
        nameLabel.text = (model?.consignee)! + "  " + (model?.addresseePhone)!
        detailAddressLabel.text = (model?.localArea)! + (model?.detailedAddress)!
        bottomAddressLabel.text = "配送至：" + (model?.localArea)! + (model?.detailedAddress)!
    }
    
    
}

// 选择收货地址
// MARK: - MMLMineAddressVCDeleagte
extension MMLSettlementVC: MMLMineAddressVCDeleagte {
    func mineAddressListVCSlectedAddress(model: AddressModel) {
        bottomAddressLabel.isHidden = false
        addAddressView.isHidden = true
        detailAddressView.isHidden = false
        addressID = model.addressID
        nameLabel.text = (model.consignee)! + "  " + (model.addresseePhone)!
        detailAddressLabel.text = (model.localArea)! + (model.detailedAddress)!
        bottomAddressLabel.text = "配送至：" + (model.localArea)! + (model.detailedAddress)!
    }
}

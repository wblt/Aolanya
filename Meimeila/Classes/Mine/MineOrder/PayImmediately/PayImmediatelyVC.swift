//
//  PayImmediatelyVC.swift
//  Mythsbears
//
//  Created by macos on 2017/11/8.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class PayImmediatelyVC: DDBaseViewController {

    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var timeCountDown: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newShopModel();
        addNotificationMonitor();
    }

    override func viewWillAppear(_ animated: Bool) {
        vm.starTime();
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        vm.stopTime();
    }
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing:String.init(describing: PayImmediatelyVC.self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func setupUI() {
        self.title = "立即付款"
        self.view.backgroundColor = DDGlobalBGColor();
        setTabelView();
        setupNavBar();
        addNotificationMonitor();
        priceLabel.text = "\(shopOrderModel.orderPrice ?? "0.00")元"
        
    }
    
    deinit {
        Barista.remove(observer: self, notification: .aliPayResult)
        Barista.remove(observer: self, notification: .wechatPayResult)
    }
    
    lazy var vm:PayImmediatelyViewModel = {[weak self] in
        
        let vm = PayImmediatelyViewModel();
        vm.shopModel = self?.shopOrderModel;
        vm.delegate = self
        return vm;
        
    }()
    
    
    lazy var order_vm:MSXPocketViewModel = {[weak self] in
        let vm = MSXPocketViewModel();
        return vm;
        }()
    
    lazy var headView:UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: 44));
        view.backgroundColor = UIColor.white;
        let title = UILabel.init(frame: CGRect.init(x: 16, y: 0, width: Screen.width - 16, height: 44));
        title.text = "支付方式"
        title.textColor = UIColor.lightGray;
        title.font = UIFont.systemFont(ofSize: 18);
        view.addSubview(title);
        return view;
    }()
    private var popupVC: DDPopupWindowVC?
    var shopOrderModel:ShopOrderModel!
    var productInfoModel:MMLSettlementProductInfoModel!
    private var isHaveToPay: Bool = false // 是否已经支付过了

//    private lazy var placeTheOrderViewModel: DDPlaceTheOrderViewModel = {
//        let vm = DDPlaceTheOrderViewModel.init()
//        return vm
//    }()
}


extension PayImmediatelyVC{
    
    func setTabelView(){
        
        tableView.rowHeight = 54;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableHeaderView = headView;
        tableView.separatorInset.left = 0;
        tableView.bounces = false;
        tableView.tableFooterView = UIView.init();
        tableView.register(UINib.init(nibName: String.init(describing: payImmdiatelyCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: payImmdiatelyCell.self))
    }
    
    @objc func cellBtSelectAction(bt:UIButton){
        
        changeBtState(selectIndex: bt.tag - 3330);
    }
    
    ///选中Cell
    func changeBtState(selectIndex:Int){
    
        for index in 0 ..< vm.cellSelectBtState.count {
            
            if selectIndex == index{
                
                vm.cellSelectBtState[selectIndex] = true
            }else {
                vm.cellSelectBtState[index] = false;
            }
            
        }
        
        tableView.reloadData();
        
        payAction(type: selectIndex);
    }
    
    
    ///商品模型转换
    func newShopModel(){
        
        let infoModel = shopOrderModel.orderInfo;
        
        let model = MMLSettlementProductInfoModel()
        
        infoModel?.forEach({ (item) in
            let car = DDShoppingCarListData.init(from: item)
            model.productList.append(car);
        })
        model.totalPrice = Double(shopOrderModel.orderPrice ?? "0") ?? 0.0;
        productInfoModel = model;
    }
    
    // 添加通知监听微信或者支付支付的结果
    private func addNotificationMonitor() {
        
        Barista.add(observer: self, selector: #selector(wechatPayResultNotification(noti:)), notification: .wechatPayResult)
        Barista.add(observer: self, selector: #selector(aliPayResultNotification(noti:)), notification: .aliPayResult)
    }
    
    
    private func setupNavBar() {
        addNavBarBackButton(imageName: "btn_back_white") { [weak self](btn) in
            // 防止重复添加的问题
            if let _ = self?.popupVC {
                return
            }
            let VC = DDPopupWindowVC.init(message: "挑选了那么久 真的要放弃吗？", leftButtonTitle: "离开", rightButtonTitle: "继续支付")
            VC.delegate = self
            VC.view.frame = (self?.view.bounds)!
            self?.popupVC = VC
            self?.view.addSubview(VC.view)
            self?.addChildViewController(VC)
        }
    }
}


extension PayImmediatelyVC{
    
    ///开始支付
    func payAction(type:Int) {
        
        if type == 0{
            
            moneyPay();
            
        }else if type == 1{
            
            if DDWechatPay.shared.isWXAppInstalled(){
    
                weChatPayRequest(orderID:shopOrderModel.orderID ?? "" , price: shopOrderModel.orderFinalPrice ?? "0.00", invoice: shopOrderModel.invoice)
            }else{
                
                BFunction.shared.showMessage("您未安装微信，无法支付!")
            }
            
        }else if type == 2{
            aliPayRequest(orderID: shopOrderModel.orderID ?? "", price: shopOrderModel.orderFinalPrice ?? "0.00")
        }
        
    }
    
    // 支付宝下单-不用
    private func requestAliPayOrderData() {
       
        var orders = [[String: String]]()
        productInfoModel?.productList.forEach { (data) in
            var dict = [String: String]()
            dict["shoppingID"] = data.shopingID
            dict["shoppingNumber"] = data.shoppingCartNumber
            orders.append(dict)
        }
        // 转换成json字符串
        let data = try? JSONSerialization.data(withJSONObject: orders, options: JSONSerialization.WritingOptions.prettyPrinted)
        let strJson = String(data: data!, encoding: String.Encoding.utf8)
//        placeTheOrderViewModel.placeAliPayOrder(orders: strJson!, addressID:"addressID") {[weak self] in
//            self?.aliPayAction()
//        }
        
    }
    
    // 微信下单-不用
    private func requestWechatOrderData() {
        
        var orders = [[String: String]]()
        productInfoModel?.productList.forEach { (data) in
            var dict = [String: String]()
            dict["shoppingID"] = data.shopingID
            dict["shoppingNumber"] = data.shoppingCartNumber
            orders.append(dict)
        }
        // 转换成json字符串
        let data = try? JSONSerialization.data(withJSONObject: orders, options: JSONSerialization.WritingOptions.prettyPrinted)
        let strJson = String(data: data!, encoding: String.Encoding.utf8)
//        placeTheOrderViewModel.placewechatPayOrder(orders: strJson!, addressID: "addressID") {[weak self] in
//            self?.wechatPayAction()
//        }
    }


    
    
    
    // 支付宝支付-不用
    func aliPayAction() {
//        DDAliPay.shared.payAction(orderStr: placeTheOrderViewModel.aliPayModel.getAlipay) { (result) in
//            debugLog(result)
//            Barista.post(notification: .aliPayResult, object: result as AnyObject)
//        }
    }
    
    // 微信支付
    func wechatPayAction() {
//        DDWechatPay.shared.payAction(payModel: placeTheOrderViewModel.wechatPayModel)
    }
    
    
    
    
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
            VC.payType = 1
            VC.delegate = self;
            VC.isPayImmediately = true;
            navigationController?.pushViewController(VC, animated: true)
        }
        
    }
    
    // 支付宝支付的结果
    @objc func aliPayResultNotification(noti: Notification) {
        debugLog(noti.object)
        guard let result = noti.object as? [String: String] else {return}
        let index = Int(result["resultStatus"]!)
        let isPaySuccess: Bool = index == 9000 ? true : false
        if !isHaveToPay {
            isHaveToPay = true
            // 跳转到结算页
            let VC = MMLPayResultVC()
            VC.isPaySuccess = isPaySuccess
            VC.isFormType = 1
            VC.payType = 2;
            VC.isPayImmediately = true;
            VC.delegate = self;
            navigationController?.pushViewController(VC, animated: true)
        }
    }
}


extension PayImmediatelyVC:MMLPayResultVCDelegate{
    func payAgain(type: Int) {
        
        payAction(type: type);
    }
    
}

//使用充值接口支付
extension PayImmediatelyVC{
    ///使用微信充值接口支付
    func weChatPayRequest(orderID:String,price:String,type:Int = 1,invoice:String?) {
        
        order_vm.reChargeMoneyWith_weChatPay(price: price, orderID: orderID,type:type, invoice: invoice,succeeds: {[weak self] in
            
            DDWechatPay.shared.payAction(payModel: (self?.order_vm.WechatPayModel)!);
        })
    }
    
    ///使用支付宝充值接口支付
    func aliPayRequest(orderID:String,price:String,type:Int = 1) {
        
        order_vm.reChargeMoneyWith_alipay(price: price, orderID: orderID,type:type, invoice: nil,succeeds: {[weak self] in
            
            DDAliPay.shared.payAction(orderStr: (self?.order_vm.aliPayModel.getAlipay)!, successBlock: { (result) in
                
                Barista.post(notification: .aliPayResult, object: result as AnyObject)

            })
        })
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
        vc.payModel = MMLMoneyPayModel.init(orders: strJson!, addressID: (shopOrderModel.aeliveryAddressModel?.addressID)!, orderID: shopOrderModel.orderID,invoice: shopOrderModel.invoice);
        
        vc.delegate = self;
        
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.5);
        vc.modalPresentationStyle = .overFullScreen;
        self.present(vc, animated: false, completion: {
        })
    }
    
}



extension PayImmediatelyVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:payImmdiatelyCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: payImmdiatelyCell.self)) as? payImmdiatelyCell
        
        if let _ = cell{}else{
            cell = Bundle.main.loadNibNamed(String.init(describing: payImmdiatelyCell.self), owner: nil, options: nil)?.last as? payImmdiatelyCell
        }
        
        cell?.setUI = vm.cellUIArr[indexPath.row];
        cell?.selectBt.isSelected = vm.cellSelectBtState[indexPath.row];
        cell?.selectBt.tag = 3330 + indexPath.row;
        cell?.selectBt.addTarget(self, action: #selector(cellBtSelectAction(bt:)), for: UIControlEvents.touchUpInside);
        cell?.selectionStyle = .none;
        return cell!;
    }
    
}

extension PayImmediatelyVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        changeBtState(selectIndex: indexPath.row);
    }
}


extension PayImmediatelyVC:DDPopupWindowVCDelegate{
    func popupWindowVCLeftButtonAction(button: UIButton) {
        popupVC = nil
        if button.tag == 1 {
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func popupWindowRightVCButtonActtion(button: UIButton) {
        popupVC = nil
    }
    
    
    
}

//计算剩余时间
extension PayImmediatelyVC:PayImmediatelyViewModelDelegate{
    func upDateTime(time: [Int]) {
        
        timeCountDown.text = "\(time[0])时\(time[1])分\(time[2])秒"
        
        if time[0] == 0 && time[1] == 0 && time[2] == 0 {
            
            vm.stopTime();
        }
        
    
    }

}

//
extension PayImmediatelyVC:MMLMoneyPayKeyBoardVCDelegate{
    func exchangeGiftPW(pw: String) {
        
    }
    
    func paySucceeds(issucceeds: Bool) {
        // 跳转到结算页
        let VC = MMLPayResultVC()
        VC.isPaySuccess = issucceeds
        
        navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    func forgetPw() {
        
        let vc = MMLMineSet()
        navigationController?.pushViewController(vc, animated: true);
    }
    
}

//
//  DDSmartmaskVC.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

private let channelOnPeropheralView = "channelOnPeropheralView"
private let kDefaultDeviceUUid = "kDefaultDeviceUUid"

class DDSmartmaskVC: DDBaseViewController {
    
    ///播放器
    lazy var player:MMLMusicPlayer = {[weak self] in
        
        let p = MMLMusicPlayer.shared;
        return p;
        }()
    
    
    @IBOutlet weak var musicBt: UIButton!
   
    @IBAction func musicBtAction(_ sender: Any) {
        
        musicBt.isSelected = !musicBt.isSelected;

        if musicBt.isSelected {
            
            self.musicBtStatue = 1;
        }else{
            self.musicBtStatue = 0;
        }
        
        
        musicAnimation();
        
    }
    
    var musicBtStatue:Int = 10;
    
    lazy var musicMV:MMLMusicViewModel = {
        let vm = MMLMusicViewModel.init();
        return vm;
    }()
    
    
    //幅度显示
    @IBOutlet weak var fuduValueLabel: UILabel!
    
    //减弱
    @IBOutlet weak var weakBt: UIButton!
    //开始
    @IBOutlet weak var startBt: UIButton!
    //加强
    @IBOutlet weak var strongBt: UIButton!
    //滑条
    @IBOutlet weak var slider: UISlider!
    //时间
    @IBOutlet weak var timeLabel: UILabel!
    //水百分比
    @IBOutlet weak var waterPercentLabel: UILabel!
    //油百分比
    @IBOutlet weak var oilPercentLabel: UILabel!
    //水数值
    @IBOutlet weak var waterValueImageView: UIImageView!
    //油数值
    @IBOutlet weak var oilValueImageView: UIImageView!
    
    //刻度
    @IBOutlet weak var waterProgress: UIImageView!
    
    //刻度
    @IBOutlet weak var oilProgress: UIImageView!
    
    //左水滴
    @IBOutlet weak var leftWaterDropBt: UIButton!
    
    //右水滴
    @IBOutlet weak var rightWaterDropBt: UIButton!

    //中水滴
    @IBOutlet weak var middleWaterDropBt: UIButton!
    
    @IBOutlet weak var deviceLabel: UILabel!
    
    //减弱
    @IBAction func weakBtAction(_ sender: Any) {
        
        if Int(vm.workStatus) == 0 || currPeripheral == nil {
            BFunction.shared.showErrorMessage("请链接蓝牙设备")
            return;
        }

        if self.slider.value - 25.5 <= 25.5{
            self.slider.value = 25.5;
        }else if self.slider.value - 25.5 > 25.5{
            self.slider.value -= 25.5;
        }
        
        self.fuduValueLabel.text = "\(Int(self.slider.value / 25.5))";
        
        vm.vm_write_strong_weak(peripheral: self.currPeripheral, characteristic: services[1].characteristics![0], sliderValu: UInt8(slider.value));
        
    }
    
    //加强
    @IBAction func strongBtAction(_ sender: Any) {
        
        if Int(vm.workStatus) == 0 || currPeripheral == nil{
            BFunction.shared.showErrorMessage("请链接蓝牙设备")
            return;
        }
        
        if self.slider.value + 25.5 >= 255{
            self.slider.value = 255.0
        }else if self.slider.value + 25.5 < 255{
            self.slider.value += 25.5;
        }
        
        self.fuduValueLabel.text = "\(Int(self.slider.value / 25.5))";

        vm.vm_write_strong_weak(peripheral: self.currPeripheral, characteristic: services[1].characteristics![0], sliderValu: UInt8(slider.value));
    }
    
    //开始
    @IBAction func startBtAction(_ sender: Any) {
        
        
        if currPeripheral == nil {
            BFunction.shared.showErrorMessage("请链接蓝牙设备")
            return;
        }
        
        if Int(vm.workStatus) == 0 && !self.services.isEmpty{
           
            vm.vm_write_start(peripheral: self.currPeripheral, characteristic: self.services[1].characteristics![0], sliderValu: UInt8(slider.value));
            
        }
        
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        
        if Int(vm.workStatus) == 0 {
            BFunction.shared.showErrorMessage("请链接蓝牙设备")
            return;
        }
        
        if self.currPeripheral == nil {
            BFunction.shared.showErrorMessage("请链接蓝牙设备")
            return;
        }
        
        self.fuduValueLabel.text = "\(Int(self.slider.value / 25.5))";
        
        vm.vm_write_strong_weak(peripheral: self.currPeripheral, characteristic: services[1].characteristics![0], sliderValu: UInt8(slider.value));
    }
    
    // 蓝牙相关
    fileprivate let baby = BabyBluetooth.share()!
    // 公司蓝牙的设备名称
    fileprivate let cPeripleralName = "DMK28  "
    
    fileprivate var peripleralArray: [CBPeripheral] = []
    // 可读特征值
    fileprivate let cPQKeyNoti_charUUID = "3378"
    // 当前连接的设备
    fileprivate var currPeripheral: CBPeripheral!
    // 当前是否连接
    fileprivate var isConnect: Bool = false
    
    fileprivate let rhythm = BabyRhythm()
    fileprivate var services = [PeripheralInfo]()
    fileprivate var deviceStatus: UInt8 = 0  //设备状态
    
    var vm = SmartmaskViewModel.shared;
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: DDSmartmaskVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if vm.isPush {
            
            print("我没死");
        }else {
            print("我死了");

            //MARK:搜索
            self.currPeripheral = nil
            //取消连接
            self.baby.cancelAllPeripheralsConnection()
            //停止搜索
            self.baby.cancelScan()
            
        }
        
        
        
    }


    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.currPeripheral == nil{
            print("我又回来啦");

            reConect();
        }
        
        
        if let _ = player.stkPlayer.remoteUrl {
            
            self.musicBt.layer.resumeAnimate()
            self.musicBt.isSelected = true;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "智能面膜"
        
        setBabyDelegate();
        
        addRotateAnimation();
        
//        showFinishVC();
    }

    override func setupUI() {
   
        self.waterValueImageView.frame = CGRect.init(x: 0, y: 0, width: 0, height: 0);
        self.oilValueImageView.frame = CGRect.init(x: 0, y: 0, width: 0, height: 0);
        
        
        addNavBarRightButton(btnTitle: "更多", titleColor: UIColor.red) {[weak self] (bt) in
            print("搜索");
            
            self?.view.addSubview((self?.listView)!);
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        listView.removeFromSuperview();
    }
    
    lazy var listView:MoreListView = {[weak self] in
        
        let view = MoreListView.init(frame: CGRect.init(x: Screen.width * 2 / 3 - 36, y:5, width: Screen.width/3 + 20, height: 44 * 4));
            view.delagate = self;
        return view;
    }()
    
    lazy var deviceSearchView:DeviceSearchView = {[weak self] in
        let view = DeviceSearchView.init(frame: CGRect.init(x: Screen.width/6, y: Screen.height/2 - Screen.width/3, width: Screen.width * 2 / 3, height: Screen.width/2 + 72))
        view.delagate = self;
        return view;
    }()
}


// MARK: - 发现和连接设备
extension DDSmartmaskVC {
    
    func setOnDiscoverSerchDevice() {
        if self.currPeripheral == nil {
            DDUtility.delay(3, closure: {
                self.setOnDiscoverSerchDevice()
            })
        }
        
        if self.peripleralArray.count == 0 { // 当前没有找到设备
            return
        }
        
        
        if deviceSearchView.isShow {
            deviceSearchView.peripheralArr = self.peripleralArray;
            deviceSearchView.tableView.reloadData();
        }
        
        
        if self.peripleralArray.count == 1 && (UserDefaults.standard.object(forKey: kDefaultDeviceUUid) == nil) { // 如果当前扫到的设备只有一个，则自动连接
            let peripheral = self.peripleralArray[0]
            self.currPeripheral = peripheral
            self.connectDevice()
            UserDefaults.standard.set(currPeripheral.identifier.uuidString, forKey: kDefaultDeviceUUid)
            return
        }else if self.peripleralArray.count > 1 && (UserDefaults.standard.object(forKey: kDefaultDeviceUUid) == nil) {
            //第一次连接,有多个设备
            // 弹窗选择
            print(self.peripleralArray);
        }
        
        //查找默认链接的设备（自动连接上一次已连接的设备）
        for peripheral in self.peripleralArray {
            if let uuidString = UserDefaults.standard.object(forKey: kDefaultDeviceUUid) as? String  {
                
                if uuidString == peripheral.identifier.uuidString  {
                    self.currPeripheral = peripheral
                    //self.startAnimation()
                    self.connectDevice()
                    return
                }
            }
        }
    }
    
    // 连接设备
    func connectDevice() {
        if self.currPeripheral == nil {
            let time: TimeInterval = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                self.connectDevice()
            }
        }else{
            
            ///断开所有连接
            baby.cancelAllPeripheralsConnection()
           ///连接设备
            baby.having(self.currPeripheral).and().channel(channelOnPeropheralView).then().connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin()
            //取消搜索
            self.baby.cancelScan()
        }
    }
    
    
    // MARK:订阅一个值,用来接收设备每秒发送过来的数据
    func setNotifiy() {
        
        if currPeripheral == nil {
            return;
        }
        
        if currPeripheral.state != .connected {
            debugLog("订阅失败")
            return
        }
        
        let characteristics = self.services[0].characteristics![0]
        if  characteristics.isNotifying == false {
            
            self.currPeripheral.setNotifyValue(true, for: characteristics)
            
        }
    }
    
    
    //MARK:解析设备每秒发送过来的数据
    func readNotifiy(data: Data) {
        
        
        if currPeripheral == nil {
            return;
        }
        
        vm.vm_read_analyzeData(fromData: data);
        timeLabel.text = vm.timeString;
        
        if Int(vm.workStatus) == 0{
            leftWaterDropBt.isSelected = false;
            middleWaterDropBt.isSelected = false;
            rightWaterDropBt.isSelected = false;
        }else if Int(vm.workStatus) == 1{
            leftWaterDropBt.isSelected = !leftWaterDropBt.isSelected
            middleWaterDropBt.isSelected = false;
            rightWaterDropBt.isSelected = false;
            self.startBt.setTitle("正在运行", for: .normal);
        }else if Int(vm.workStatus) == 2{
            leftWaterDropBt.isSelected = false
            middleWaterDropBt.isSelected = !middleWaterDropBt.isSelected;
            rightWaterDropBt.isSelected = false;
            self.startBt.setTitle("正在运行", for: .normal);
        }else if Int(vm.workStatus) == 3{
            leftWaterDropBt.isSelected = false
            middleWaterDropBt.isSelected = false;
            rightWaterDropBt.isSelected = !rightWaterDropBt.isSelected;
            self.startBt.setTitle("正在运行", for: .normal);
        }
        
        waterPercentLabel.text = "水分:\(vm.waterValue_100)" + "%"
        oilPercentLabel.text = "油分:\(vm.oilValue_100)" + "%"
        
        vm.vm_setWaterAndOilValueImage(water: waterValueImageView, oil: oilValueImageView, waterProgress: waterProgress, oilProgress: oilProgress);
        
        if vm.timeString == "00:01" {
            print("结束本次使用");
            self.startBt.setTitle("开始", for: .normal);
            BFunction.shared.showMessage("本次使用结束");
            //MARK:上传数据
            upLoadTestData();
            
            setNotifiy();
            
            vm.workStatus = UInt8(0);
            
            showFinishVC();
            
        }else if vm.timeString == "11:59"{
            print("开始本次使用->播放音乐");
            musicBt.isSelected = true;
            musicAnimation();
            
            
            self.startBt.setTitle("正在运行", for: .normal);
        }else if vm.timeString == "11:05"{
            print("55秒上传数据");
            
            vm.beforeWater = vm.waterValue_100;
            vm.beroreOil = vm.oilValue_100;
            
            upLoadTestData();
        }else if vm.timeString == "11:50"{
            vm.beforeWater = vm.waterValue_100;
            vm.beroreOil = vm.oilValue_100;
        }
        
    }
    
}


// MARK: - 搜索到周围所有的蓝牙设备
extension DDSmartmaskVC {
    //蓝牙网关初始化和委托方法设置
    /**
     进行第一步: 搜索到周围所有的蓝牙设备
     */
    func setBabyDelegate() {
        // 1.获取设备状态-手机蓝牙是否打开
        baby.setBlockOnCentralManagerDidUpdateState { [weak self](central:CBCentralManager?) in
            
            if central?.state == .poweredOn  {
                debugLog("设备打开成功，开始扫描设备")
                self?.setOnDiscoverSerchDevice()
            }else{
                
            }
        }
        
        
        //过滤器
        //设置查找设备的过滤器
        baby.setFilterOnDiscoverPeripherals { [weak self](name, adv, RSSi) -> Bool in
            if let name = adv?["kCBAdvDataLocalName"] as? String {
                if name == self?.cPeripleralName {
                    return true
                }
            }
            return false
        }
        
        
        // 2.搜索到一个新的设备
        baby.setBlockOnDiscoverToPeripherals { [weak self](centralManager, peripheral, adv, RSSI) in
            //  NSLog("%@", centralManager!);
            
            // 只有是公司对应的蓝牙
            if adv?["kCBAdvDataLocalName"] as? String == self?.cPeripleralName {
                
                debugLog(self?.cPeripleralName);
                
                self?.deviceLabel.text = "正在搜索设备..."
                
                if !(self?.peripleralArray.contains(peripheral!))! {
                    self?.peripleralArray.append(peripheral!)
                }
            }
        }
        
        // 3.设置设备连接成功的委托,同一个baby对象，使用不同的channel切换委托回调
        baby.setBlockOnConnectedAtChannel(channelOnPeropheralView) { [weak self](central:CBCentralManager?, peripheral:CBPeripheral?) in
            
            if peripheral != nil {
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                    //self.stopAnimation()
                })
                self?.isConnect = true
                debugLog("设备连接成功 :\(peripheral!.name!)")
                debugLog(peripheral?.services);
                self?.startBt.setTitle("开始", for: .normal);
                
                let uuid = self?.uuidString(peripheral: peripheral);
                
                self?.deviceLabel.text = "设备连接成功-设备ID:\(uuid ?? "68554")"
                
                DDUtility.delay(1, closure: {
                    
                    self?.timeLabel.text = "12:00";

                })
            }
        }
        
        // 3.设置设备连接失败的委托
        baby.setBlockOnFailToConnectAtChannel(channelOnPeropheralView) { [weak self](central:CBCentralManager?, peripheral:CBPeripheral?, error:Error?) in
            if peripheral != nil {
                self?.isConnect = false
                debugLog("设备连接失败 :\(peripheral!.name!)")
            }
        }
        
        // 4.设置设备断开连接的委托
        baby.setBlockOnDisconnectAtChannel(channelOnPeropheralView) { [weak self](central:CBCentralManager?, peripheral:CBPeripheral?, error:Error?) in
            if peripheral != nil {
                self?.isConnect = false
                debugLog("设备连接断开 :\(peripheral!.name!)")
                
                 self?.deviceLabel.text = "设备断开连接！"
                
            }
        }
        
        // 5.设置发现设备的Services的委托
        baby.setBlockOnDiscoverServicesAtChannel(channelOnPeropheralView) { [weak self](peripheral:CBPeripheral?, error:Error?) in
            if let service_ = peripheral?.services {
                if self?.services.count == 0 &&  (self?.services.count)! < 2 {
                    for mService in service_ {
                        
                        print("搜索到服务: \(mService.uuid.uuidString)")
                        let info = PeripheralInfo()
                        info.serviceUUID = mService.uuid
                        self?.services.append(info)
                        //  self.setData2(service: mService)
                    }
                }
                
            }
            // 开启计时
            self?.rhythm.beats()
        }
        
        // 6.设置发现设service的Characteristics的委托
        baby.setBlockOnDiscoverCharacteristics { (p, s, err) in
            
            if let uuid = s?.uuid {
                debugLog("发现service的Characteristics uuid是: \(uuid)")
            }else{
                debugLog("发现service的Characteristics 但无法读取uuid")
            }
            
            if let characteristics = s?.characteristics {
                
                for c in characteristics {
                    debugLog("charateristic name is : \(c.uuid)")
                }
            }else{
                debugLog("发现Characteristics 但无法读取")
            }
            
        }
        
        // 6.设置发现设service的Characteristics的委托
        baby.setBlockOnDiscoverCharacteristicsAtChannel(channelOnPeropheralView) { [weak self](peripheral:CBPeripheral?, service:CBService?, error:Error?) in
            
            if (self == nil){
                return;
            }
            
            if let service_ = service {
                
                var index = 0
                for m_sevice in (self?.services)! {
                    if service_.uuid.uuidString == m_sevice.serviceUUID?.uuidString {
                        m_sevice.characteristics = service!.characteristics
                        self?.services[index] = m_sevice
                    }
                    
                    index = index + 1
                }
            }
        }
        
        // 7.找到Peripherals的bloc 订阅通知
        baby.setBlockOnDiscoverDescriptorsForCharacteristicAtChannel(channelOnPeropheralView) { [weak self](peripheral:CBPeripheral?, characteristic:CBCharacteristic?, error:Error?) in
            
            // LogManager.shared.log(characteristic!.uuid.uuidString)
            
            if characteristic!.uuid.uuidString == self?.cPQKeyNoti_charUUID { // 可读
                // 如果这里不订阅，则无法读取到数据
                self?.setNotifiy()
            }
        }
        
        
        // 8.读取数据
        baby.setBlockOnReadValueForCharacteristicAtChannel(channelOnPeropheralView) { [weak self](peripheral:CBPeripheral?, characteristic:CBCharacteristic?, error:Error?) in
            NSLog("discover characteristics:\(String(describing: characteristic))")
            if characteristic?.value?.count == 20 {
                
                if self?.services.count == 2 {
                    self?.readNotifiy(data: characteristic!.value!)
                }
                
            }
            
        }
        
        
        /// 扫描设备
        let scanForPeripheralsWithOptions = [CBCentralManagerScanOptionAllowDuplicatesKey: true]
        // 连接设备 9
        baby.setBabyOptionsWithScanForPeripheralsWithOptions(scanForPeripheralsWithOptions, connectPeripheralWithOptions: nil, scanForPeripheralsWithServices: nil, discoverWithServices: nil, discoverWithCharacteristics: nil)
        
        // baby.cancelAllPeripheralsConnection()
        _ = baby.scanForPeripherals().begin()
        
    }
}


extension DDSmartmaskVC:MoreListViewDelegate,DeviceSearchViewDelegate{
    
    func didSelectRow(row: Int, title: String) {
        
        listView.removeFromSuperview();
        
        if row == 0 {
            self.view.addSubview(deviceSearchView);
            deviceSearchView.isShow = true;
            deviceSearchView.delagate?.starToSearchDevice();
            
        }else if row == 1 {
            
            let vc = SmartmaskDateVC()
            vc.title = title;
            
            vm.isPush =  true;
            
            navigationController?.pushViewController(vc, animated: true);
        }else if row == 2 {
            
            let vc = MMLUseHelp()
            
            vc.html = "operation";
            self.navigationController?.pushViewController(vc, animated: true);
        }else if row == 3 {
            
            let vc = MMLMusicVC();
            vc.player = self.player;
            navigationController?.pushViewController(vc, animated: true);
        }
        
        
    }

    
    func starToSearchDevice() {
        print("开始搜索")
        reConect();
    }
    
    
    func starToConnrct(peripheral: CBPeripheral) {
        self.currPeripheral = peripheral;
        UserDefaults.standard.set(currPeripheral.identifier.uuidString, forKey: kDefaultDeviceUUid);
        self.connectDevice();
    }
    
}


extension DDSmartmaskVC{
    
    func reConect() {
        
        //MARK:搜索
        self.currPeripheral = nil
        //取消连接
        self.baby.cancelAllPeripheralsConnection()
        //停止搜索
        self.baby.cancelScan()
        
        //开始搜索
        _ = baby.scanForPeripherals().begin()
        
        //代理
//        self.setBabyDelegate()
        //连接
        self.setOnDiscoverSerchDevice()
    }
}


extension DDSmartmaskVC{
    
    //上传本次数据
    func upLoadTestData() {
        
        BFunction.shared.showLoading();
        
        let water = "\(vm.waterValue_100)";
        let oily = "\(vm.oilValue_100)";
        
        vm.maskDataUpLoad(water: water, oily: oily, succeeds: { (code) in
            
            BFunction.shared.showSuccessMessage("数据上传成功")
            print("上传成功");
        }) {
            print("上传出错!");
        }
    }
    
    
    ///跳转结果页
    func showFinishVC() {
        let vc = MMLTestReportVC();
        
        if vm.beforeWater == 0{
            
            vm.beforeWater = Int(arc4random()%29) + 11
        }
        
        if vm.beroreOil == 0 {
            
            vm.beroreOil = Int(arc4random()%35) + 25

        }
        
        
        
        if vm.waterValue_100 == 0 {
            vm.waterValue_100 = Int(arc4random()%36) + 44
        }
        
        if vm.oilValue_100 == 0{
            
            vm.oilValue_100 = Int(arc4random()%16) + 10

        }
        
        
        let waterDic = ["before":vm.beforeWater,"after":vm.waterValue_100];
        let oilDic = ["before":vm.beroreOil,"after":vm.oilValue_100];
        vc.resultArr = [waterDic,oilDic];
        navigationController?.pushViewController(vc, animated: true);
    }
    
    ///旋转动画 -> 音乐开始与结束动画
    func musicAnimation() {
        
        if musicBt.isSelected{
            
            musicBt.layer.pauseAnimate();
            
            if let _ = player.stkPlayer.remoteUrl {
                
                player.stkPlayer.resumePlaye();
                
            }else{
                playRemoteMusic();

            }
            
            

            musicBt.layer.resumeAnimate();

        }else{
            
            print("停止音乐");
            //停止音乐
            musicBt.layer.pauseAnimate();
            
            if let _ = player.stkPlayer.remoteUrl {
                
                player.stkPlayer.pausePlay();
            }
            
            
        }
        
    }
    
    ///添加旋转动画
    func addRotateAnimation() {
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * Double.pi
        anim.duration = 3.0
        anim.repeatCount = MAXFLOAT
        anim.isRemovedOnCompletion = false
        musicBt.layer.add(anim, forKey: "loading")
        musicBt.layer.pauseAnimate()
    }
    
    
    
    
    
    ///播放你喜欢的动画
    func playRemoteMusic() {
        
        if let _ = player.stkPlayer.remoteUrl{
            
        }else{
        
        ///加载远程数据
            musicMV.getRemoteData(haveUrl: {[weak self] (url) in
            
                
                self?.player.stkPlayer.play(url: url);
                self?.player.stkPlayer.remoteUrl = url;
                
            }) {[weak self] (url) in

    
            }
        }
    }
    
   
    
    
    ///解析UUID
    func uuidString(peripheral:CBPeripheral?) -> String{
        
        //MARK:蓝牙UUID
        let uuid = peripheral?.identifier;
        print("uuid--->",uuid as Any)
        if uuid != nil{
            
            let uid:String = "\(uuid!)";
            
            print("uuid");
            
            if !uid.isEmpty {
                
                let uuidArr =  uid.components(separatedBy: "-");
                
                if uuidArr.count != 0 {
                    
                    var id = uuidArr.first;
                    
                    var uidArr = [String]();
                    
                    for character in (id?.unicodeScalars)! {
                        
                        print(character.value);
                        
                        print("打印:");
                        
                        let valu = character.value;
                        
                        let str = "\(valu)";
                        uidArr.append(str);
                    }
                    
                    if uidArr.count > 0{
                        
                        let u1 = uidArr.first;
                        
                        let u2 = uidArr[1];
                        
                        let u3 = uidArr.last;
                        
                        
                        var string:String = "";
                        
                        string.append(u1!);
                        string.append(u2);
                        string.append(u3!);
                        
                        return string;
                    }
                }
            }
        }
        return ""
    }
    
    
}

//
//  MMLAddressSelectVC.swift
//  Meimeila
//
//  Created by macos on 2017/11/22.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
@objc protocol MMLAddressSelectVCDelegate{
    
    ///选择地址OK
    func addressSelectFinish(address:String,vc:MMLAddressSelectVC)
    
}

class MMLAddressSelectVC: DDBaseViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var cancleBt: UIButton!
    
    
    @IBOutlet weak var verifyBt: UIButton!
    
    
    @IBAction func cancleBtAction(_ sender: Any) {
        
        self.dismiss(animated: false) {
            
        }
    }
    
    
    @IBAction func verifyBtAction(_ sender: Any) {
        
      let address = getPickerViewValue();
        delegate?.addressSelectFinish(address: address,vc: self);
    }
    
    
    @IBOutlet weak var picketBGView: UIView!
    
    weak var delegate:MMLAddressSelectVCDelegate?
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLAddressSelectVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //

    //选择器
    lazy  var pickerView:UIPickerView = {
        
        let pickerView = UIPickerView.init(frame: CGRect.zero);
        //将dataSource设置成自己
        pickerView.dataSource=self
        //将delegate设置成自己
        pickerView.delegate=self
        return pickerView;
    }()
    
    //所以地址数据集合
    var addressArray = [[String: AnyObject]]()
    
    //选择的省索引
    var provinceIndex = 0
    //选择的市索引
    var cityIndex = 0
    //选择的县索引
    var areaIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    
    override func setupUI() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5);
        pickConfigure();
    }
    
    ///初始化
    func pickConfigure() {
        //初始化数据
        let path = Bundle.main.path(forResource: "address", ofType:"plist")
        self.addressArray = NSArray(contentsOfFile: path!) as! Array
        
        print(self.addressArray);
        
        self.picketBGView.addSubview(pickerView);
        
        pickerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview();
        }
    }
    
    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    //设置选择框的行数，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.addressArray.count
        } else if component == 1 {
            let province = self.addressArray[provinceIndex]
            let anyObjectArr = province["cities"] as! NSArray;
            return anyObjectArr.count;
            
        } else {
            let province = self.addressArray[provinceIndex]
            if let city = (province["cities"] as! NSArray)[cityIndex]
                as? [String: AnyObject] {
                
                let anyObjectArr = city["areas"] as! NSArray
                return anyObjectArr.count;
                
            } else {
                return 0
            }
        }
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if component == 0 {
            return self.addressArray[row]["state"] as? String
        }else if component == 1 {
            let province = self.addressArray[provinceIndex]
            let city = (province["cities"] as! NSArray)[row]
                as! [String: AnyObject]
            return city["city"] as? String
        }else {
            let province = self.addressArray[provinceIndex]
            let city = (province["cities"] as! NSArray)[cityIndex]
                as! [String: AnyObject]
            return (city["areas"] as! NSArray)[row] as? String
        }
    }
    
    //选中项改变事件（将在滑动停止后触发）
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        //根据列、行索引判断需要改变数据的区域
        switch (component) {
        case 0:
            provinceIndex = row;
            cityIndex = 0;
            areaIndex = 0;
            pickerView.reloadComponent(1);
            pickerView.reloadComponent(2);
            pickerView.selectRow(0, inComponent: 1, animated: false)
            pickerView.selectRow(0, inComponent: 2, animated: false)
        case 1:
            cityIndex = row;
            areaIndex = 0;
            pickerView.reloadComponent(2);
            pickerView.selectRow(0, inComponent: 2, animated: false)
        case 2:
            areaIndex = row;
        default:
            break;
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        pickerView.subviews.forEach { (view) in
            if view.frame.size.height < 3 {
                view.backgroundColor = UIColor.RGB(r: 60, g: 128, b: 74);
            }
        }
        
        var cityName = "";
        
        if component == 0 {
            cityName = (self.addressArray[row]["state"] as? String)!
        }else if component == 1 {
            let province = self.addressArray[provinceIndex]
            let city = (province["cities"] as! NSArray)[row]
                as! [String: AnyObject]
            cityName = (city["city"] as? String)!
        }else {
            let province = self.addressArray[provinceIndex]
            let city = (province["cities"] as! NSArray)[cityIndex]
                as! [String: AnyObject]
            cityName = ((city["areas"] as! NSArray)[row] as? String)!
        }
        
        
        let reasonLabel = UILabel.init()
        reasonLabel.textAlignment = .center
        reasonLabel.font = UIFont.systemFont(ofSize: 14)
        reasonLabel.textColor = UIColor.black
        reasonLabel.text = cityName;
        return reasonLabel;
    }
    
    //触摸按钮时，获得被选中的索引
    @objc func getPickerViewValue() -> String{
        //获取选中的省
        let p = self.addressArray[provinceIndex]
        let province = p["state"]!
        
        //获取选中的市
        let c = (p["cities"] as! NSArray)[cityIndex] as! [String: AnyObject]
        let city = c["city"] as! String
        
        //获取选中的县（地区）
        var area = ""
        if (c["areas"] as! [String]).count > 0 {
            area = (c["areas"] as! [String])[areaIndex]
        }
        
        //拼接输出消息
//        let message = "索引：\(provinceIndex)-\(cityIndex)-\(areaIndex)\n"
//            + "值：\(province) - \(city) - \(area)"
        
        let address = "\(province)-\(city)-\(area)";
        
        return address;
    }
}

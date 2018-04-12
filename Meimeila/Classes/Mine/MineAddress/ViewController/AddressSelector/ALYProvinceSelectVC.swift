//
//  ALYProvinceSelectVC.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/12.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
@objc protocol ALYProvinceSelectVCDelegate{
	
	///选择省地址OK
	func provinceSelectFinish(address:String,vc:ALYProvinceSelectVC)
	
}

class ALYProvinceSelectVC: DDBaseViewController,UIPickerViewDelegate, UIPickerViewDataSource {

	@IBOutlet weak var cancelBtn: UIButton!
	@IBOutlet weak var sureBtn: UIButton!
	@IBOutlet weak var pickterBgView: UIView!
	weak var delegate:ALYProvinceSelectVCDelegate?
	//iOS8用到XIB必须写这两个方法
	init() {
		super.init(nibName: String.init(describing: ALYProvinceSelectVC.self), bundle: nil)
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
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
		
		self.pickterBgView.addSubview(pickerView);
		
		pickerView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview();
		}
	}
	
	//设置选择框的列数为3列,继承于UIPickerViewDataSource协议
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	//设置选择框的行数，继承于UIPickerViewDataSource协议
	func pickerView(_ pickerView: UIPickerView,
					numberOfRowsInComponent component: Int) -> Int {
		if component == 0 {
			return self.addressArray.count
		}else {
			return 0
		}
	}
	
	//设置选择框各选项的内容，继承于UIPickerViewDelegate协议
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
					forComponent component: Int) -> String? {
//		if component == 0 {
//			return self.addressArray[row]["state"] as? String
//		}
		return self.addressArray[row]["state"] as? String
	}
	
	//选中项改变事件（将在滑动停止后触发）
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
					inComponent component: Int) {
		//根据列、行索引判断需要改变数据的区域
		switch (component) {
		case 0:
			provinceIndex = row;
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
		
		let address = "\(province)";
		
		return address;
	}
	
	@IBAction func cancelBtnAction(_ sender: Any) {
		self.dismiss(animated: false) {
			
		}
	}
	@IBAction func sureBtnAction(_ sender: Any) {
		let address = getPickerViewValue();
		delegate?.provinceSelectFinish(address: address,vc: self);
	}
	
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

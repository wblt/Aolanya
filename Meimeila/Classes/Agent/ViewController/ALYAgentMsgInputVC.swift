//
//  ALYAgentMsgInputVC.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/8.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import FDStackView

class ALYAgentMsgInputVC: DDBaseViewController {
	
	//区域类型  1 省   2 市   3 申请
	 var areaType: String!
	//收款码图片  1 支付宝  2  微信
	var imageType :String!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var phoneTextField: UITextField!
	@IBOutlet weak var codeTextField: UITextField!
	@IBOutlet weak var codeBtn: DDCountDownButton!
	@IBOutlet weak var weixinNumTextField: UITextField!
	@IBOutlet weak var addressLab: UILabel!
	@IBOutlet weak var zhifubaoimgView: UIImageView!
	@IBOutlet weak var weixinImgView: UIImageView!
	
	@IBOutlet weak var lab1: UILabel!
	
	@IBOutlet weak var lab2: UILabel!
	
	@IBOutlet weak var lab3: UILabel!
	@IBOutlet weak var lab4: UILabel!
	@IBOutlet weak var img1: UIImageView!
	@IBOutlet weak var img2: UIImageView!
	@IBOutlet weak var img3: UIImageView!
	@IBOutlet weak var img4: UIImageView!
	
	@IBOutlet weak var line1: UIView!
	@IBOutlet weak var line3: UIView!
	
	@IBOutlet weak var zhifubaoBgView: UIView!
	
	@IBOutlet weak var weixinBgView: UIView!
	
	@IBOutlet weak var stackbgView: FDStackView!
	
	lazy var photoManger:DDPhotoLibraryManager = {[weak self] in
		let manger = DDPhotoLibraryManager.shared
		manger.delegate = self
		return manger;
		}()
	
	lazy var agentViewModel: AgentViewModel = {
		let agVM = AgentViewModel()
		return agVM
	}()
	
	lazy var alter:UIAlertView =  {[weak self] in
		let view = UIAlertView.init(title:"图片来源", message: "", delegate: self, cancelButtonTitle: "取消");
		view.addButton(withTitle: "图库");
		view.addButton(withTitle: "相机");
		return view;
		}()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "我要赚钱"
        // Do any additional setup after loading the view.
		
		
		agentViewModel.getToExamineoneUid {
			
			print(self.agentViewModel.examineoneUid)
			
		}
    }
	
	override func setupUI() {
		
		if areaType == "1" || areaType == "2" {
			lab1.isHidden = true
			lab4.isHidden = true
			img1.isHidden = true
			img4.isHidden = true
			line1.isHidden = true
			line3.isHidden = true
			
			lab2.text = "填写合伙人信息"
			lab3.text = "等待审核"
			
			zhifubaoBgView.isHidden = true
			weixinBgView.isHidden = true
			stackbgView.removeArrangedSubview(zhifubaoBgView)
			stackbgView.removeArrangedSubview(weixinBgView)
		}
	}
	
	//获取验证码
	@IBAction func getCodeAction(_ sender: Any) {
		
		if JQValidate.phoneNum(phoneTextField.text!).isRight {
			
			BFunction.shared.showLoading()
			
			MMLLoginViewModel.shared.getSMSAction(phone: phoneTextField.text!, type: 1) { (isSucceeds) in
				self.codeBtn.startEclipse()
				BFunction.shared.showSuccessMessage("发送成功")
			}
			
		}else {
			
			BFunction.shared.showErrorMessage("请输入正确手机号")
			
		}
		
	}
	//选择地址
	@IBAction func chooseAddressAction(_ sender: Any) {
		if self.areaType == "1" {
			let vc = ALYProvinceSelectVC();
			vc.modalPresentationStyle = .overFullScreen;
			vc.delegate = self as ALYProvinceSelectVCDelegate;
			self.present(vc, animated: false) {
			}
		}else {
			let vc = MMLAddressSelectVC();
			vc.modalPresentationStyle = .overFullScreen;
			vc.delegate = self as MMLAddressSelectVCDelegate;
			self.present(vc, animated: false) {
			}
		}
	
	}
	//上传支付宝
	@IBAction func uploadZhifubaoAction(_ sender: Any) {
		self.imageType = "1"
		alter.show();
	}
	
	//上传微信
	@IBAction func uploadWeixinAction(_ sender: Any) {
		self.imageType = "2"
		 alter.show();
	}
	
	//提交
	@IBAction func sureBtnClick(_ sender: Any) {
		
		if JQValidate.phoneNum(phoneTextField.text!).isRight == false{
			 BFunction.shared.showToastMessge("请输入正确的手机号码");
			return;
		}
		
		if nameTextField.text == "" || phoneTextField.text == "" || codeTextField.text == "" || weixinNumTextField.text == "" || addressLab.text == "请选择您的代理区域地址"{
			 BFunction.shared.showToastMessge("请将信息填写完整");
			return
		}
		
		if areaType == "3" {
			
			if zhifubaoimgView == nil {
				BFunction.shared.showToastMessge("请上传支付宝收款码");
				return
			}
			
			if weixinImgView == nil {
				BFunction.shared.showToastMessge("请上传微信收款码");
				return
			}
		}
		var regionLevel = "0"
		if areaType == "1" {
			regionLevel = "2"
		}
		
		self.agentViewModel.writeRegionApply(uid:DDUDManager.share.getUserID(), realName: nameTextField.text!, phone: phoneTextField.text!, weixin: weixinNumTextField.text!, regionAdress: addressLab.text!, temporaryRegionLevel: regionLevel) {
			
			
		}
		
		
		
	}
	
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ALYAgentMsgInputVC:MMLAddressSelectVCDelegate,ALYProvinceSelectVCDelegate{
	func addressSelectFinish(address: String, vc: MMLAddressSelectVC) {
		
		vc.dismiss(animated: false) {[weak self] in
			
			self?.addressLab.text = address
			self?.addressLab.textColor = UIColor.black
		}
	}
	
	func provinceSelectFinish(address: String, vc: ALYProvinceSelectVC) {
		vc.dismiss(animated: false) {[weak self] in
			
			self?.addressLab.text = address
			self?.addressLab.textColor = UIColor.black
		}
	}
	
}

extension ALYAgentMsgInputVC:UIAlertViewDelegate{
	
	func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
		
		if buttonIndex == 1 {
			photoManger.browseFromLibrary();
		}else if buttonIndex == 2{
			photoManger.browseFromCamera();
		}
	}
}

extension ALYAgentMsgInputVC:DDPhotoLibraryManagerDelegate {
	
	func delegatePhotoLibraryManager(_ manager: DDPhotoLibraryManager, didPickedImage image: UIImage?) {
		
		if imageType == "1" {
			zhifubaoimgView.image = image;
		}else {
			weixinImgView.image = image;
		}
	}
	
	
}


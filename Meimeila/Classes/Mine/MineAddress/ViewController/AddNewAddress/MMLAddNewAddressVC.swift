//
//  MMLAddNewAddressVC.swift
//  Meimeila
//
//  Created by macos on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MMLAddNewAddressVCDelegate {
    func addNewAddressVCAddAddressSuccess(model: AddressModel?)
}

class MMLAddNewAddressVC: DDBaseViewController {

    weak var delegate: MMLAddNewAddressVCDelegate?
    
    @IBOutlet weak var nameTF: UITextField!
    
    
    @IBOutlet weak var phoneTF: UITextField!
   
    
    @IBOutlet weak var areaBt: UIButton!
    
    @IBOutlet weak var detailTF: UITextField!
   
    
    @IBOutlet weak var mailTF: UITextField!
    
    @IBOutlet weak var defaultSwitch: UISwitch!
    
    
    
    @IBOutlet weak var saveBt: UIButton!
    
    @IBAction func areaBtAction(_ sender: Any) {
       
        /*
        let vc = SelectAddressVC();
        vc.selectAddress = {(address) in
            self.areaBt.setTitle(address, for: .normal);
            print(address);
        }
        self.navigationController?.pushViewController(vc, animated: true);
        */
        
        let vc = MMLAddressSelectVC();
        vc.modalPresentationStyle = .overFullScreen;
        vc.delegate = self;
        self.present(vc, animated: false) {
            
        }
 }
    
    
    @IBAction func defaultSwitchAction_valueChange(_ sender: Any) {
        
        var isOn = 0;
        
        if defaultSwitch.isOn{
            isOn = 1
        }
        
        print(isOn);
        model.defaultAddress = "\(isOn)"
    }
    
    
    @IBAction func saveBtAction(_ sender: Any) {
        
        if verifyInput() {
            
            if isEditi{
                
                vm.modifiedAddress(consignee: model.consignee ?? "", localArea: model.localArea ?? "", detailedAddress: model.detailedAddress ?? "", defaultAddress: model.defaultAddress ?? "", addresseePhone: model.addresseePhone ?? "", adressID: model.addressID ?? "",postcode:model.postcode ?? "" ,succeeds: {
                    
                })
                
            }else{
            
                vm.addAddress(consignee: model.consignee ?? "", localArea: model.localArea ?? "" , detailedAddress: model.detailedAddress ?? "", defaultAddress: model.defaultAddress ?? "", addresseePhone: model.addresseePhone ?? "", postcode: model.postcode ?? "", succeeds: {[weak self] in
                    
                    if let _ = self?.delegate {
                        self?.delegate?.addNewAddressVCAddAddressSuccess(model: self?.vm.defaultAddressModel)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    
                })
            }
        }
    }
    
   
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLAddNewAddressVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()


        if isEditi {
            isEditiAddress();
        }
    
    }

    override func setupUI() {
        
        if isEditi{
            
            self.title = "编辑收货地址"

        }else{
            self.title = "添加收货地址"

        }
        
        saveBt.layer.cornerRadius = 22;
        
    }

    var model = AddressModel();
    
    lazy var vm:MSXAddressVM = {
        let vm = MSXAddressVM();
        return vm;
    }()
    
    var isEditi = false;
}


extension MMLAddNewAddressVC{

    ///编辑状态
    func isEditiAddress() {
        nameTF.text = model.consignee;
        phoneTF.text = model.addresseePhone;
        detailTF.text = model.detailedAddress;
        areaBt.setTitle(model.localArea, for: .normal);
        mailTF.text = model.postcode;
        if let on = model.defaultAddress {
            if on == "0"{
                
                defaultSwitch.isOn = false;
            }else{
                
                defaultSwitch.isOn = true;
            }
            
        }
        
    }
    
    
    func stopEdit() {
        nameTF.resignFirstResponder();
        phoneTF.resignFirstResponder();
        detailTF.resignFirstResponder();
        mailTF.resignFirstResponder();
        
        model.consignee = nameTF.text
        model.addresseePhone = phoneTF.text
        model.localArea = self.areaBt.titleLabel?.text
        model.postcode = mailTF.text
        model.detailedAddress = detailTF.text
        
        
        var isOn = 0;
        if defaultSwitch.isOn{
            isOn = 1
        }
        model.defaultAddress = "\(isOn)"
    }
    
    
    func verifyInput() -> Bool{
        stopEdit()
        
        if (nameTF.text?.isEmpty)! {
            
            BFunction.shared.showErrorMessage("收货人不能为空")
            return false;
        }
        
        if (phoneTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("手机号不能为空")
            return false;
        }
        
        if (detailTF.text?.isEmpty)!{
            BFunction.shared.showErrorMessage("详细地址不能为空")
            return false;
        }
        
        if (mailTF.text?.isEmpty)! {
            BFunction.shared.showErrorMessage("邮政编码不能为空")
            return false;
        }
        
        if (model.localArea?.isEmpty)!{
            
            BFunction.shared.showErrorMessage("区域不能为空")
            return false;
        }
        return true;
    }
}


extension MMLAddNewAddressVC:MMLAddressSelectVCDelegate{
    func addressSelectFinish(address: String, vc: MMLAddressSelectVC) {
        
        print("选择的地址为",address);
        self.areaBt.setTitle(address, for: UIControlState.normal);
        vc.dismiss(animated: false, completion: nil);
    }
    

}


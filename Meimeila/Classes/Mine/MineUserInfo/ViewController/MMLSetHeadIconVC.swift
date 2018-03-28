//
//  MMLSetHeadIconVC.swift
//  Meimeila
//
//  Created by macos on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLSetHeadIconVC: DDBaseViewController {

    
    @IBOutlet weak var headIconImageView: UIImageView!
    
    
    @IBOutlet weak var changeBt: UIButton!
    
    
    @IBAction func changeBtAction(_ sender: Any) {
        
        alter.show();
    }
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLSetHeadIconVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func setupUI() {
        self.title = "设置头像";
        changeBt.layer.cornerRadius = 5;
        headIconImageView.layer.cornerRadius = headIconImageView.bounds.width/2;
        headIconImageView.clipsToBounds = true;
        headIconImageView.jq_setImage(imageUrl: model?.picture, placeholder: "icon_defaultHeadIcon", isShowIndicator: false, isNeedForceRefresh: false);
    }
    
    lazy var photoManger:DDPhotoLibraryManager = {[weak self] in
        let manger = DDPhotoLibraryManager.shared;
        manger.delegate = self;
        return manger;
    }()
    
   lazy var alter:UIAlertView =  {[weak self] in
        let view = UIAlertView.init(title:"图片来源", message: "", delegate: self, cancelButtonTitle: "取消");
        view.addButton(withTitle: "图库");
        view.addButton(withTitle: "相机");
        return view;
    }()
    
    
    lazy var vm:MMLUserInfoViewModel = {[weak self] in
        let vm = MMLUserInfoViewModel.init();
        return vm;
        }()
    
    var model:UserInfoModel?
}


extension MMLSetHeadIconVC{
    
    func upLoadPic(image:UIImage) {
        vm.uploadImage(image) {
            
        }
    }
    
}

extension MMLSetHeadIconVC:UIAlertViewDelegate{
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        if buttonIndex == 1 {
            photoManger.browseFromLibrary();
        }else if buttonIndex == 2{
            photoManger.browseFromCamera();
        }
    }
}

extension MMLSetHeadIconVC:DDPhotoLibraryManagerDelegate {
    
    func delegatePhotoLibraryManager(_ manager: DDPhotoLibraryManager, didPickedImage image: UIImage?) {
       headIconImageView.image = image;
        upLoadPic(image: image!);
    }
    
    
}

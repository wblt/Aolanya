//
//  MakeCommentVC.swift
//  Mythsbears
//
//  Created by macos on 2017/10/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MakeCommentVC: DDBaseViewController {
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var submitBt: UIButton!
    
    @IBAction func submitBtAction(_ sender: Any) {
        
        if verifyCheck(){
            
            let shopInfoModel = shopModel.orderInfo![0]
            
            vm.upLoadCommentWithImage(shopingID: shopInfoModel.shopingID ?? "0", score: "90", fabulous: "100", evaluateMessage: "100", files: picArr, scueeds: {[weak self] in
                
                BFunction.shared.showSuccessMessage("发表成功");
                
                DDUtility.delay(1, closure: {
                    
                    self?.navigationController?.popViewController(animated: true);
                })
                
            }, errors: {
                
                
            });
        }
        
    }
    
   
    func verifyCheck() -> Bool{
        
        if textView.text.isEmpty{
           
        BFunction.shared.showErrorMessage("内容为空")
            
            return false
        }
    
        return true;
    }
    
    
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing:String.init(describing: MakeCommentVC.self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        DDPhotoLibraryManager.shared.delegate = self;
        
    }

    override func setupUI() {
        setCollectionView();
        submitBt.layer.cornerRadius = 5.0;
        textView.delegate = self;
        self.title = "发表评价";
    }

    func setCollectionView(){
        
        collectionView.dataSource = self;
        collectionView.isScrollEnabled = false;
        collectionView.bounces = false;
        collectionView.scrollsToTop = false;
        collectionView.delegate = self;
        collectionView.showsHorizontalScrollIndicator = false;
        
        
        collectionView.register(UINib.init(nibName: String.init(describing: TakePictureCell.self), bundle: nil), forCellWithReuseIdentifier: String.init(describing: TakePictureCell.self));
    }
    
    lazy var picArr:[UIImage] = {
        var arr = [UIImage]()
        return arr;
    }()
    
    lazy var vm:MakeCommentViewModel = {
        
        let vm = MakeCommentViewModel.shared;
        return vm
    }()
    
    var shopModel:ShopOrderModel!
    
    lazy var photoManger:DDPhotoLibraryManager = {[weak self] in
        
        let m = DDPhotoLibraryManager.shared;
        m.delegate = self;
        return m;
    }()
}



extension MakeCommentVC:UICollectionViewDataSource{
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0{
            
            return picArr.count;
        }
        
        return 1;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:TakePictureCell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: TakePictureCell.self), for: indexPath) as! TakePictureCell;
        if indexPath.section == 0{
            cell.containImageView.image = picArr[indexPath.row];
        }
        return cell;
    }
}

extension MakeCommentVC:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: collectionView.bounds.size.width/4, height: collectionView.bounds.size.width/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0;
    }
}

extension MakeCommentVC:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if picArr.count == 3 {
            BFunction.shared.showErrorMessage("最多选3张图片")
            return;
        }
        
        if indexPath.section == 1 {
            
            let vc = SelectPictureVC()
            vc.delegate = self;
            self.addChildViewController(vc);
            vc.view.frame = self.view.bounds;
            self.view.addSubview(vc.view);
            
        }
        
    }
}

extension MakeCommentVC:DDPhotoLibraryManagerDelegate{
    
    func delegatePhotoLibraryManager(_ manager: DDPhotoLibraryManager, didPickedImage image: UIImage?) {
        
        picArr.append(image!);
        collectionView.reloadData();
    }
    
}

extension MakeCommentVC:SelectPictureVCDelegate{
    
    func picSelectType(type: Int) {
        
        
        if type == 0{
            
            if photoManger.canLoadPhotoAlbum(){
            
                photoManger.browseFromCamera();
            }
            
        }else{
            
            photoManger.browseFromLibrary();
            
        }
    }
    
}

extension MakeCommentVC:UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        placeholderLabel.isHidden = true;
        return true;
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty{
            placeholderLabel.isHidden = false;
        }
    }
}

//
//  MMLPicturesPicker.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/22.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import TZImagePickerController


// 多图片选择器
class MMLPicturesPicker {
    
    static let shared = MMLPicturesPicker()
    private init() {}
    
    func takePhotoToAlbum(VC: UIViewController, maxImagesCount: Int, selectedFinishBlock: @escaping (_ images: [UIImage]) -> ()) {
        let imagePickerVC = TZImagePickerController.init(maxImagesCount: maxImagesCount, delegate: nil)
        imagePickerVC?.isSelectOriginalPhoto = true
        imagePickerVC?.showSelectBtn =  maxImagesCount == 1 ? false : true
        
        // 1.如果你需要将拍照按钮放在外面，不要传这个参数
        imagePickerVC?.selectedAssets = []
        // 在内部显示拍照按钮
        imagePickerVC?.allowTakePicture = true
        
        // 2. 在这里设置imagePickerVc的外观
        imagePickerVC?.navigationBar.barTintColor = DDGlobalNavBarColor()
        imagePickerVC?.oKButtonTitleColorNormal = UIColor.green
        imagePickerVC?.oKButtonTitleColorDisabled = UIColor.green
        
        // 3. 设置是否可以选择视频/图片/原图
        imagePickerVC?.allowPickingVideo = false
        imagePickerVC?.allowTakePicture = true
        imagePickerVC?.allowPickingOriginalPhoto = true
        
        // 4. 照片排列按修改时间升序
        imagePickerVC?.sortAscendingByModificationDate = true
        imagePickerVC?.didFinishPickingPhotosWithInfosHandle = {(photos, assets, isSelectOriginalPhoto, infos) in
            selectedFinishBlock(photos ?? [UIImage]())
        }
        VC.present(imagePickerVC!, animated: true, completion: nil)
    }
}

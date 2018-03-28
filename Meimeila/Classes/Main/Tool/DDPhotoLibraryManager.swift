//
//  DDPhotoLibraryManager.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos

@objc protocol DDPhotoLibraryManagerDelegate {
    func delegatePhotoLibraryManager(_ manager: DDPhotoLibraryManager, didPickedImage image: UIImage?)
}

class DDPhotoLibraryManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let shared = DDPhotoLibraryManager()
    weak var delegate: DDPhotoLibraryManagerDelegate?
    
    fileprivate override init() {
        
    }
    
    /// 通过相机加图片
    func browseFromCamera() {
        if canLoadPhotoAlbum() {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                imagePicker.sourceType = .camera
//                imagePicker.edgesForExtendedLayout = .init(rawValue: 0)
//                imagePicker.automaticallyAdjustsScrollViewInsets = false
                imagePicker.navigationBar.tintColor = UIColor.black
                let ctrl: UIViewController = self.delegate as! UIViewController
                ctrl.present(imagePicker, animated: true, completion: { () -> Void in
                })
            } else {
                BFunction.shared.showErrorMessage("抱歉！您的设备不支持拍照")
            }
            
        } else {
            
            var infoDictionary: [AnyHashable: Any] = Bundle.main.infoDictionary!
            let appName: String = (infoDictionary["CFBundleDisplayName"] as! String)

            let alertController = UIAlertController.init(title: "提示", message: "\(appName)没有权限读取您的相片。要赋予权限，请打开：设置>隐私>相机>\(appName)", preferredStyle: .alert)
            let cancelAction = UIAlertAction.init(title: "我知道了", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            let window = UIApplication.shared.keyWindow
            window?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        }
    }
    
    /// 通过照片库添加图片
    func browseFromLibrary() {
        
        if canLoadPhotoAlbum() {
            let imagePicker: UIImagePickerController = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
//            imagePicker.edgesForExtendedLayout = .init(rawValue: 0)
//            imagePicker.automaticallyAdjustsScrollViewInsets = false
            imagePicker.navigationBar.tintColor = UIColor.black
            imagePicker.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor.white), for: .default)
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) || UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                imagePicker.sourceType = .photoLibrary
                let ctrl: UIViewController = self.delegate as! UIViewController
                ctrl.present(imagePicker, animated: true, completion: { () -> Void in
                })
            } else {
                BFunction.shared.showErrorMessage("抱歉！您的相册内没有图片")
            }
            
        } else {
            var infoDictionary: [AnyHashable: Any] = Bundle.main.infoDictionary!
            let appName: String = (infoDictionary["CFBundleDisplayName"] as! String)
            let alertController = UIAlertController.init(title: "提示", message: "\(appName)没有权限读取您的相片。要赋予权限，请打开：设置>隐私>照片>\(appName)", preferredStyle: .alert)
            let cancelAction = UIAlertAction.init(title: "我知道了", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            let window = UIApplication.shared.keyWindow
            window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    /// 是否有打开相机相册的权限
    func canLoadPhotoAlbum() -> Bool {
        
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            return true
        case .denied:
            return false
        case .notDetermined:
            return true
        case .restricted:
            return false
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let img = info[UIImagePickerControllerEditedImage] as? UIImage
        self.delegate?.delegatePhotoLibraryManager(self, didPickedImage: img)
        
        let ctrl: UIViewController? = self.delegate as? UIViewController
        ctrl?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        let ctrl: UIViewController = self.delegate as! UIViewController
        ctrl.dismiss(animated: true, completion: nil)
    }
}



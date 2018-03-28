//
//  MMLPhotoViewer.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/24.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
// import LPPhotoViewer


class MMLPhotoViewer {
    
    static let shared = MMLPhotoViewer()
    private  init() {}
    
    private var datas = [String]()
    
    func viewImages(vc: UIViewController, images: [String], currentIndex: Int) {
        
        datas = images
        let photoBrowser = YLPhotoBrowser.init(currentIndex, self)
        // 用白色 遮挡 原来的图
        photoBrowser.originalCoverViewBG = UIColor.white
        
        // 非矩形图片需要实现(比如聊天界面带三角形的图片) 默认是矩形图片
        photoBrowser.getTransitionImageView = { (currentIndex: Int,image: UIImage?, isBack: Bool) -> UIView? in
            return nil
        }
        vc.present(photoBrowser, animated: true, completion: nil)
        
        //        let photoViewer = LPPhotoViewer.init()
        //        photoViewer.imgArr = images
        //        photoViewer.currentIndex = currentIndex
        //        photoViewer.indicatorType = .numLabel
        //        vc.present(photoViewer, animated: true, completion: nil)
    }
}

extension MMLPhotoViewer: YLPhotoBrowserDelegate {
    func epPhotoBrowserGetPhotoCount() -> Int {
        return datas.count
    }
    
    func epPhotoBrowserGetPhotoByCurrentIndex(_ currentIndex: Int) -> YLPhoto {
        let imageUrl = datas[currentIndex]
        let photo = YLPhoto()
        photo.imageUrl = imageUrl
        return photo
    }
    
}


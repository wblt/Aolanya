//
//  UIImage-Extension.swift
//  SwiftTest
//
//  Created by MAC on 2016/12/28.
//  Copyright © 2016年 MAC. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    // MARK: - 根据颜色创建Image
    class func createImage(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    // MARK: 拉伸图片做背景
    class func getStretchableImage(imageName: String) -> UIImage {
        var image = UIImage(named: imageName)
        image = image?.stretchableImage(withLeftCapWidth: Int((image?.size.width)! * 0.5), topCapHeight: Int((image?.size.height)! * 0.5))
        return image!
    }
    
    
    ///对指定图片进行拉伸
    class func resizableImage(name: String) -> UIImage {
        
        let normal: UIImage = UIImage(named: name)!
        let imageWidth = normal.size.width * 0.5
        let imageHeight = normal.size.height * 0.5
        let newImage: UIImage = normal.resizableImage(withCapInsets: UIEdgeInsetsMake(15, 10, imageHeight, imageWidth))
        return newImage
    }
    
    //调整图片大小
    class func  scaleToSize(img: UIImage, size: CGSize) -> UIImage{
        UIGraphicsBeginImageContext(size);
        img.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        let scaledImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return scaledImage;
    }
    
    
    /**
     生成纯色图片
     
     - parameter color: 颜色
     
     - returns: newUIImage
     */
    class func imageWithColor(_ color: UIColor) -> UIImage {
        // 描述矩形
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        // 开启位图上下文
        UIGraphicsBeginImageContext(rect.size)
        // 获取位图上下文
        let context = UIGraphicsGetCurrentContext()!
        // 使用color演示填充上下文
        context.setFillColor(color.cgColor)
        // 渲染上下文
        context.fill(rect)
        // 从上下文中获取图片
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        // 结束上下文
        UIGraphicsEndImageContext()
        return theImage!
    }
    
    /**
     根据传入的宽度生成一张图片
     按照图片的宽高比来压缩以前的图片
     
     :param: width 制定宽度
     */
    public func imageWithScale(width: CGFloat) -> UIImage {
        
        // 1.根据宽度计算高度
        let height = width *  size.height / size.width
        
        // 2.按照宽高比绘制一张新的图片
        let currentSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(currentSize)
        draw(in: CGRect(origin: CGPoint.zero, size: currentSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //判断图片是否达到一定尺寸,达到则做处理(主要用于发送图片到服务器时使用, 如店铺编辑, 上传图片)
    class func handleImageBySize(image: UIImage) -> NSData {
        let imageData: NSData = UIImageJPEGRepresentation(image, 1)! as NSData;
        let  imageSize: NSInteger = imageData.length / 1024 + 30; //KB
        if imageSize < 200 {
            return imageData
        }
        
        var handImage: UIImage = image;
            if (image.size.width > 1500 || image.size.height > 1500) {
                var imageW: CGFloat = 1500;
                var imageH: CGFloat = 1500;
                let scale: CGFloat = image.size.width / image.size.height; //比例
                
                if (image.size.width > image.size.height) {
                    //横向图片
                    imageH = imageW / scale;
                    handImage = self.scaleToSize(img: image, size: CGSize.init(width: imageW, height: imageH))
                } else {
                    imageW = imageH * scale;
                    handImage = self.scaleToSize(img: image, size: CGSize.init(width: imageW, height: imageH))
                }
            }
        return UIImageJPEGRepresentation(handImage, 0.3)! as NSData;
    }
    
    //返回裁剪区域图片,返回裁剪区域大小图片
    class func clipImage(with image: UIImage, in rect: CGRect) -> UIImage {
        
        let imageRef: CGImage? = image.cgImage?.cropping(to: rect)
        
        if imageRef == nil {
            return UIImage()
        }
        
        UIGraphicsBeginImageContext(image.size)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        context?.draw(imageRef!, in: rect)
        //context.draw(imageRef, image: rect)
        let clipImage = UIImage(cgImage: imageRef!)
        
        UIGraphicsEndImageContext()
        
        return clipImage
    }

}

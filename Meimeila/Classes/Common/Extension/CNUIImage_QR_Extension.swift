//
//  CNUIImage_QR_Extension.swift
//  Meimeila
//
//  Created by macos on 2017/12/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

extension UIImage {

   ///生成二维码
  fileprivate class func CIImageCreat(codeString:String) -> CIImage?{
        
        let filter = CIFilter.init(name: "CIQRCodeGenerator");
        filter?.setDefaults();
        
        let dataString = codeString.data(using: String.Encoding.utf8);
        filter?.setValue(dataString, forKey: "inputMessage");
    
        let outImage = filter?.outputImage;
        
        return outImage;
    }
    
   ///绘制二维码高清图
  fileprivate class  func QR_HUD_image(outImage:CIImage,sizes:CGFloat) -> UIImage {
        
        let extent = outImage.extent.integral;
        let scale = min(sizes/extent.width, sizes/extent.height)
        
        ///创建bitmap
        let with = extent.width * scale;
        let heigh = extent.height * scale;
        
        ///颜色通道
        let colorSpaceRef = CGColorSpaceCreateDeviceGray()
        let imageAlphaInfo = CGImageAlphaInfo.none.rawValue
        
        let bitmap = CGContext.init(data: nil, width: Int(with), height: Int(heigh), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpaceRef, bitmapInfo: imageAlphaInfo);
        
        let context = CIContext.init();
        let bitmapImage = context.createCGImage(outImage, from: extent)
    
        bitmap?.interpolationQuality = CGInterpolationQuality.none;
        
        bitmap?.scaleBy(x: scale, y: scale);
        
        bitmap?.draw(bitmapImage! , in: extent);
        
        let scalImage = bitmap?.makeImage();
        return UIImage.init(cgImage: scalImage!);
        
    }
    
    
  class func CN_creatQRImage(codeString:String,sizes:CGFloat) -> UIImage {
        
        let outImage = CIImageCreat(codeString: codeString);
        
        let image = QR_HUD_image(outImage: outImage!, sizes: sizes)
        
        return image;
    }
    
}

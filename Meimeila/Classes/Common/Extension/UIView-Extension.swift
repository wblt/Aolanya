//
//  UIView+Extension.swift
//  DanTang
//
//  Created by 杨蒙 on 2017/3/24.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import CoreGraphics

extension UIView {
    
    /// 裁剪 view 的圆角
    func clipRectCorner(direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    public var right: CGFloat{
        get{
            return self.x + self.width
        }
        set{
            var r = self.frame
            r.origin.x = newValue - frame.size.width
            self.frame = r
        }
    }
    
    /**
     设置圆角边框
     
     - parameter cornerRadius: 圆角
     - parameter width:        边框宽度
     - parameter color:        边框颜色
     */
    func setCornerBorderWithCornerRadii(_ cornerRadius: CGFloat, width: CGFloat, color: UIColor) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }

}

struct ImageConst{
    static let bytesPerPixel = 4
    static let bitsPerComponent = 8
}

//解压缩来提高效率
extension UIImage{
    func decodedImage()->UIImage?{
        guard let cgImage = self.cgImage else{
            return nil
        }
        guard let colorspace = cgImage.colorSpace else {
            return nil
        }
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerRow = ImageConst.bytesPerPixel * width
        let ctx = CGContext(data: nil,
                            width: width,
                            height: height,
                            bitsPerComponent: ImageConst.bitsPerComponent,
                            bytesPerRow: bytesPerRow,
                            space: colorspace,
                            bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        guard let context = ctx else {
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context.draw(cgImage, in: rect)
        guard let drawedImage = context.makeImage() else{
            return nil
        }
        let result = UIImage(cgImage: drawedImage, scale:self.scale , orientation: self.imageOrientation)
        return result
    }
}

extension UIImageView{
    // 异步设置图片
    func asyncSetImage(_ image:UIImage?){
        DispatchQueue.global(qos: .userInteractive).async {
            let decodeImage = image?.decodedImage()
            DispatchQueue.main.async {
                self.image = decodeImage
            }
        }
    }
}

extension UIButton{
    // 异步设置图片
    func asyncSetImage(_ image:UIImage,for state:UIControlState){
        DispatchQueue.global(qos: .userInteractive).async {
            let decodeImage = image.decodedImage()
            DispatchQueue.main.async {
                self.setImage(decodeImage, for: state)
            }
        }
    }
}

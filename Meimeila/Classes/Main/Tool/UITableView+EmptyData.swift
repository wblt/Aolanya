//
//  UITableView+EmptyData.swift
//  DanTang
//
//  Created by 杨蒙 on 2017/3/24.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit


typealias TableViewNodataBlock = () -> ()

public extension UITableView {
    
    
    // 在数据源方法 numberofRowsInsection方法中调用
    // 展示提示信息
    // 只针对没有headerView和footerview的情景
    @discardableResult
    func displayprompts(message: String, image: String, cellCount: Int) -> UIButton?{
        if cellCount == 0 {
            
            let view  = UIView.init()
            // 没有数据，显示图片
            let button = UIButton()
            let tempImage = UIImage.init(named: image)
            //let scale = UIScreen.main.scale
            if let _ = tempImage {
//                var imageW = tempImage?.size.width
//                var imageH = tempImage?.size.height
//                if Screen.width == 320 { // 小屏幕
//                    // 图片比例是1：1
//                    imageW = Screen.width * 320 / 375
//                    imageH = imageW
//                    button.imageView?.contentMode = .scaleAspectFit
//                }else {
//                    button.imageView?.contentMode = .center
//                }
                
                button.imageView?.contentMode = .scaleAspectFit
                //print(self.tableHeaderView ?? "")
                
                button.frame = CGRect.init(x: (self.bounds.width - 160)/2, y: (self.bounds.height - 160 - 5.0 - 21.0)/2.0, width: 160, height: 160)
                button.setImage(UIImage.init(named: image), for: .highlighted)
                button.setImage(UIImage(named: image), for: .normal)
               
            }
            
            var lableY = button.y + button.height + 5
            if button.height == 0 {
                lableY = (bounds.size.height - 21) / 2
            }

            let label = UILabel.init()
            label.frame = CGRect.init(x: 0.0, y: Double(lableY), width: Double(self.bounds.width), height: 21.0)
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.init(r: 200, g: 200, b: 200)
            label.text = message
            view.addSubview(button)
            view.addSubview(label)
            backgroundView = view
            separatorStyle = .none
            return button
        } else {
            backgroundView = nil
            separatorStyle = .singleLine
        }
        return nil
    }
    
    // 主要是针对有headerView的
    @discardableResult
    func displayprompts(startY: CGFloat, message: String, image: String, cellCount: Int) -> UIButton?{
        if cellCount == 0 {
            
            let view  = UIView.init()
            // 没有数据，显示图片
            let button = UIButton()
            let tempImage = UIImage.init(named: image)
            button.imageView?.contentMode = .scaleAspectFit
            //let scale = UIScreen.main.scale
            if let _ = tempImage {
                button.frame = CGRect.init(x: (self.bounds.width - 160)/2, y: startY, width: 160, height: 160)
                button.setImage(UIImage.init(named: image), for: .highlighted)
                button.setImage(UIImage(named: image), for: .normal)
                
            }
            
            var lableY = button.y + button.height + 15
            if button.height == 0 {
                lableY = (bounds.size.height - 21) / 2
            }
            
            let label = UILabel.init()
            label.frame = CGRect.init(x: 0.0, y: Double(lableY), width: Double(self.bounds.width), height: 21.0)
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.init(r: 200, g: 200, b: 200)
            label.text = message
            view.addSubview(button)
            view.addSubview(label)
            backgroundView = view
            separatorStyle = .none
            return button
        } else {
            backgroundView = nil
            separatorStyle = .singleLine
        }
        return nil
    }
    
}

extension UICollectionView {
    
    // 展示提示信息
    // 只针对没有headerView和footerview的情景
    @discardableResult
    func displayprompts(message: String, image: String, cellCount: Int) -> UIButton?{
        if cellCount == 0 {
            
            let view  = UIView.init()
            // 没有数据，显示图片
            let button = UIButton()
            let tempImage = UIImage.init(named: image)
            //let scale = UIScreen.main.scale
            if let _ = tempImage {
                var imageW = tempImage?.size.width
                var imageH = tempImage?.size.height
                if Screen.width == 320 { // 小屏幕
                    // 图片比例是1：1
                    imageW = Screen.width * 320 / 375
                    imageH = imageW
                    button.imageView?.contentMode = .scaleAspectFit
                }else {
                    button.imageView?.contentMode = .center
                }
                
                button.frame = CGRect.init(x: (self.bounds.width - imageW!)/2, y: (self.bounds.height - imageH! - 15.0 - 21.0)/2.0, width: imageW!, height: imageH!)
                button.setImage(UIImage.init(named: image), for: .highlighted)
                button.setImage(UIImage(named: image), for: .normal)
                
            }
            
            var lableY = button.y + button.height + 15
            if button.height == 0 {
                lableY = (bounds.size.height - 21) / 2
            }
            
            let label = UILabel.init()
            label.frame = CGRect.init(x: 0.0, y: Double(lableY), width: Double(self.bounds.width), height: 21.0)
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.init(r: 200, g: 200, b: 200)
            label.text = message
            view.addSubview(button)
            view.addSubview(label)
            backgroundView = view
            return button
        } else {
            backgroundView = nil
        }
        return nil
    }
}

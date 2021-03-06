//
//  MMLColor.swift
//  Meimeila
//
//  Created by macos on 2017/10/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

///橙红色
let RGB_orangeRed = UIColor.RGB_color(r: 255.0, g: 69.0, b: 0.0, alpha: 1.0);
///番茄红
let RGB_tomatoRed = UIColor.RGB_color(r: 255.0, g: 99.0, b: 71.0, alpha: 1.0);
///烟白
let RGB_somkeWhite = UIColor.RGB_color(r: 245.0, g: 245.0, b: 245.0, alpha: 1.0);
///亮灰
let RGB_gainsboro = UIColor.RGB_color(r: 220.0, g: 220.0, b: 220.0, alpha: 1.0);
///银白
let RGB_silverWhite = UIColor.RGB_color(r: 192.0, g: 192.0, b: 192.0, alpha: 1.0);
///深灰
let RGB_darkgray = UIColor.RGB_color(r: 169.0, g: 169.0, b: 169.0, alpha: 1.0);
///暗灰
let RGB_dimgray = UIColor.RGB_color(r: 105.0, g: 105.0, b: 105.0, alpha: 1.0);
///金色
let RGB_gold = UIColor.RGB_color(r: 255.0, g: 215.0, b: 0.0, alpha: 1.0);
///深天蓝
let RGB_deepSkyBlue = UIColor.RGB_color(r: 0.0, g: 191.0, b: 255.0, alpha: 1.0);
///天蓝
let RGB_skyBlue = UIColor.RGB_color(r: 135.0, g: 206.0, b: 235.0, alpha: 1.0);
///淡天蓝
let RGB_lightSkyBlue = UIColor.RGB_color(r: 135.0, g: 206.0, b: 250.0, alpha: 1.0);
///紫红
let RGB_fuchsia = UIColor.RGB_color(r: 255.0, g: 0.0, b: 255.0, alpha: 1.0);
///间海洋绿
let RGB_mediumSeaGreen = UIColor.RGB_color(r: 60.0, g: 179.0, b: 113.0, alpha: 1.0);
///间春绿
let RGB_mediumSpringGreen = UIColor.RGB_color(r: 192.0, g: 192.0, b: 192.0, alpha: 1.0);

///APP绿
let RGB_App_Green = UIColor.RGB_color(r: 60.0, g: 182.0, b: 74.0, alpha: 1.0);

extension UIColor{
	
	convenience init(hexString:String){
		//处理数值
		var cString = hexString.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		
		let length = (cString as NSString).length
		//错误处理
		if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){
			//返回whiteColor
			self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
			return
		}
		
		if cString.hasPrefix("#"){
			cString = (cString as NSString).substring(from: 1)
		}
		
		//字符chuan截取
		var range = NSRange()
		range.location = 0
		range.length = 2
		
		let rString = (cString as NSString).substring(with: range)
		
		range.location = 2
		let gString = (cString as NSString).substring(with: range)
		
		range.location = 4
		let bString = (cString as NSString).substring(with: range)
		
		//存储转换后的数值
		var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0
		//进行转换
		Scanner(string: rString).scanHexInt32(&r)
		Scanner(string: gString).scanHexInt32(&g)
		Scanner(string: bString).scanHexInt32(&b)
		//根据颜色值创建UIColor
		self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
	}
	
}


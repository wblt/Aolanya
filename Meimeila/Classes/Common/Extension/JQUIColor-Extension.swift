

import UIKit

extension UIColor {
    
    // 如果需要高频率使用一个实例对象，可以使用拓展
    static let myOwnColor = UIColor(red: 23_3.0/255, green: 23_4.0/255, blue: 23_5.0/255, alpha: 1)
    
    // 便利构造器
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    // 获取随机颜色
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    class func RGB_Float(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor? {
        return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    class func RGB(r:Int,g:Int,b:Int) -> UIColor? {
        return UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    
    func alpha(_ alpha: CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
    
   class func RGB_color(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat) -> UIColor{
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha);
    }
    
    // MARK: - 根据十六进制获取颜色
    class func RGB(_ rgbValue: String) -> UIColor? {
        
        ///  支持格式包括： #ff21af64   #21af64   0x21af64
        if (rgbValue.hasPrefix("#") || (rgbValue.hasPrefix("0x"))) {
            let mutStr = (rgbValue as NSString).mutableCopy() as! NSMutableString
            
            if (rgbValue.hasPrefix("#")) {
                mutStr.deleteCharacters(in: NSRange.init(location: 0, length: 1))
            } else {
                mutStr.deleteCharacters(in: NSRange.init(location: 0, length: 2))
            }
            
            if (mutStr.length == 6) {
                mutStr.insert("ff", at: 0)
            }
            
            
            let aStr = mutStr.substring(with: NSRange.init(location: 0, length: 2))
            let rStr = mutStr.substring(with: NSRange.init(location: 2, length: 2))
            let gStr = mutStr.substring(with: NSRange.init(location: 4, length: 2))
            let bStr = mutStr.substring(with: NSRange.init(location: 6, length: 2))
            
            let alpha = aStr.hexValue()
            let red = rStr.hexValue()
            let green = gStr.hexValue()
            let blue = bStr.hexValue()
            
            return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
        }else{
            assert(false, "16进制字符串转UIColor：格式不支持")
            return nil
        }
    }
    
}

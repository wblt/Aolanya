//
//  String-Extension.swift
//  SwiftTest
//
//  Created by MAC on 2016/12/31.
//  Copyright © 2016年 MAC. All rights reserved.
//

import UIKit

extension String{
    /**
     将当前字符串拼接到cache目录后面
     */
    func cacheDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!  as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到doc目录后面
     */
    func docDir() -> String
    {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!  as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到tmp目录后面
     */
    func tmpDir() -> String
    {
        let path = NSTemporaryDirectory() as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    
    /**
     去除空格
     
     - returns: newString
     */
    func stringByTrim() -> String {
        let set: CharacterSet = CharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: set)
    }
    
    //去空格
    func stringByWhiteSpace() -> String {
        
        var newString = self
        newString = newString.replacingOccurrences(of: "\r", with: "")
        newString = newString.replacingOccurrences(of: "\n", with: "")
        newString = newString.stringByTrim()
        newString = newString.replacingOccurrences(of: " ", with: "")
        return newString
    }
    
    // MARK: - 获取十六进制的值
    func hexValue() -> Int {
        let str = self.uppercased()
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum -= 7
            }
        }
        return sum
    }
    
    func size(withFont font: UIFont, maxWidth: CGFloat) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 5
        paragraphStyle.paragraphSpacing = 0
        let attributes = [NSAttributedStringKey.font.rawValue: font, NSAttributedStringKey.paragraphStyle: paragraphStyle as NSCopying] as [AnyHashable : NSCopying]
        
        let string = self as NSString
        let newSize = string.boundingRect(with: CGSize.init(width: maxWidth, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                          attributes: attributes as? [NSAttributedStringKey : Any],
                                          context: nil).size
        return CGSize.init(width: CGFloat(ceilf(Float(newSize.width))), height: newSize.height)
    }
    
    /// URL编码
    func stringByAddingPercentEncoding() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    // MARK: - 通过正则表达式查找相应字符串在内容字符串的位置
    // 构建正则表达式
    static func logResult(with regexRule: String, contentStr: NSString, resultsBlock:( (_location: Int, _length: Int)) -> ()) {
        let regex = try! NSRegularExpression(pattern: regexRule, options: .caseInsensitive)
        let results = regex.matches(in: contentStr as String, options: .withoutAnchoringBounds, range: NSMakeRange(0, contentStr.length))
        for matchResult in results {
            let matchStr = contentStr.substring(with: matchResult.range)
            print("result: \(matchStr), rang:(\(matchResult.range.location),\(matchResult.range.length))")
            resultsBlock((_location: matchResult.range.location,_length: matchResult.range.length))
        }
        /* 使用方式
        let contentStr = "how are you!"
        let regexEngRule = "o"
        contentStr.logResult(with: regexEngRule, contentStr: contentStr as NSString, resultsBlock: {(_location,_length) in
            print(NSMakeRange(_location, _length))
        })
        */
    }
    
    // MARK: - 16位md5加密
    var MD5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate(capacity: digestLen)
        return hash as String
    }
    
    // MARK: - 32位md5加密
    func mattress_MD5() -> String? {
        let cString = self.cString(using: String.Encoding.utf8)
        let length = CUnsignedInt(
            self.lengthOfBytes(using: String.Encoding.utf8)
        )
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(cString!, length, result)
        
        return String(format:
            "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15])
    }
    
    public func jq_heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }
    
    func getTexWidth(font: UIFont, height: CGFloat) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let stringSize = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context:nil).size
        return stringSize.width
        
    }
    
    func toData() -> Data? {
        
        let data = self.data(using: String.Encoding.utf8)
        
        return data
    }
    
    /// 字符串截取 截取是之前的字符串
    func substringToIndex(_ index: Int) -> String? {
        guard index > 0 else {
            return nil
        }
        if index >= self.count {
            return self
        }
        let startIndex = self.index(self.startIndex, offsetBy: index)
        return String(self[..<startIndex])
        //return self.substring(to: self.characters.index(self.startIndex, offsetBy: index))
    }
    
}


extension NSAttributedString {
    
    public func jq_heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
}

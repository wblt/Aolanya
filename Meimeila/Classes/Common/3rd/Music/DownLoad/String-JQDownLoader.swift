//
//  String-JQDownLoader.swift
//  AudioPlayerDemo
//
//  Created by HJQ on 2017/11/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation

extension String {
    
    // md5
    // MARK: - 32位md5加密
    func jqDownload_MD5() -> String? {
        let cString = self.cString(using: String.Encoding.utf8)
        let length = CUnsignedInt(
            self.lengthOfBytes(using: String.Encoding.utf8)
        )
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(cString!, length, result)
        //result.deallocate(capacity: Int(length))
        return String(format:
            "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15])
    }
}

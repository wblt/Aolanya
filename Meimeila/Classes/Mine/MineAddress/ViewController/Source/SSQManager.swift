//
//  SSQManager.swift
//  Mythsbears
//
//  Created by macos on 2017/10/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class SSQManager: NSObject {

  static let shared = SSQManager()
  private override init() {}
 
    var provinceArr = [String]()
    var cityArrs = [[String]]()
    var areaArrs = [[[String]]]()
    
    func plistSource() {
        
        let path = Bundle.main.path(forResource: "SSQ", ofType: "plist")
        let plistDic = NSDictionary.init(contentsOfFile: path!)!;

        let jsonDic = JSON.init(plistDic).dictionaryValue;
        
        for index in 0 ..< jsonDic.count {
            //省
            let provinceDic = jsonDic["\(index)"]?.dictionaryValue;
            let provice = (provinceDic?.keys.first)!;
            provinceArr.append(provice);
            
            //市
            let city_Dic = provinceDic![provice]?.dictionaryValue;
            var cityArr = [String]();
            var areaArr_0 = [[String]]()
            
            for index_c in 0 ..< (city_Dic?.count)! {
                let cityDic = city_Dic!["\(index_c)"]?.dictionaryValue;
                let city = (cityDic?.keys.first)!;
                cityArr.append(city)
                
                let jsonAreaArr = cityDic![city]?.arrayValue;
                var arreaArr = [String]()
                for json_area in jsonAreaArr! {

                    let area = json_area.stringValue;
                    
                    arreaArr.append(area);
                }
                
                areaArr_0.append(arreaArr);
            }
            
            cityArrs.append(cityArr);
            
            areaArrs.append(areaArr_0);
        }
        
        
        /*
        //省
        let dic0 = jsonDic["10"]?.dictionaryValue;
    
        let key0 = dic0?.keys.first;
        
        let shi = dic0![key0!]?.dictionaryValue;

        let qu = shi!["0"]?.dictionaryValue;
        
        let key1 = qu?.keys.first;

        let quArr = qu![key1!]?.arrayValue;
        
        print(quArr);
        */
        
        
    }
    
    
}

//
//  DayTaskViewModel.swift
//  Mythsbears
//
//  Created by macos on 2017/11/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON


typealias requestSucceeds = () -> ()
typealias requestFalse = () ->()

class DayTaskViewModel{

    static var shared = DayTaskViewModel()
    fileprivate init(){}
    

    var modelArr = [DayTaskModel]()
    var tableView:UITableView?
    var beans:String = "0"
}

extension DayTaskViewModel{
    
    func getDayTaskRequest(succeeds:@escaping requestSucceeds,falses:@escaping requestFalse) {
        
        let r = DayTaskAPI.dayTask
        DDHTTPRequest.requestWithJsonCoding(r: r, requestSuccess: {[weak self] (responds) in
            let json = JSON.init(responds);
            print(json)
            
            self?.beans = json["beans"].stringValue
            
            let data = json["data"].arrayValue
            self?.modelArr.removeAll();
            
            data.forEach({ (json) in
                
                let model = DayTaskModel.init(from: json);
                self?.modelArr.append(model);
            })
            
            succeeds();
            
        }, requestError: { (responds, errorModel) in
            
            BFunction.shared.showErrorMessage(errorModel.message)

            falses();
            
        }) { (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription)
            falses();
            
        }
        
    }
    
}

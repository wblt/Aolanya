//
//  MMLSystemMessageDetailVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLSystemMessageDetailVC: DDBaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    var data: MMLSystemMessageListData?
    
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLSystemMessageDetailVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "消息详情"
        titleLabel.text = data?.msgTitle
        timeLabel.text = (data?.msgAddTime)!
			//timestampToDate(format: "yyyy-mm-dd HH:mm", timestamp: (data?.msgAddTime)!)
        contentLabel.text = data?.msgBody

    }

    


}

//
//  MMLMessageCell.swift
//  Meimeila
//
//  Created by macos on 2017/11/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMessageCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    
    @IBOutlet weak var body: UILabel!
    
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var messageModel:MineMessageModel?{
        
        didSet{
            
            title.text = messageModel?.msgTitle;
            body.text = messageModel?.msgBody;
            time.text = messageModel?.msgAddTime ?? ""
				//timestampToDate(format: "YY-HH-dd HH:mm:ss", timestamp: messageModel?.msgAddTime ?? "");
        }
    }
}

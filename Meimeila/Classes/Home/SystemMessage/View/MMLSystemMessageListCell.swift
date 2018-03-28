//
//  MMLSystemMessageListCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLSystemMessageListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var data: MMLSystemMessageListData? {
        didSet {
            titleLabel.text = data?.msgTitle
            contentLabel.text = data?.msgBody
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  MMLMakeMoneyTableViewCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMakeMoneyTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

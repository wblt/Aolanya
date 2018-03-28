//
//  MMLSmartHardwareCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLSmartHardwareCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var dict: [String: String]! {
        didSet {
            iconImageView.image = UIImage.init(named: dict["icon"] ?? " ")
            nameLabel.text = dict["name"] ?? " "
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

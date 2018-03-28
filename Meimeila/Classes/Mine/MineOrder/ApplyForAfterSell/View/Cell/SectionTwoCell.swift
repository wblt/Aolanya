//
//  SectionTwoCell.swift
//  Mythsbears
//
//  Created by macos on 2017/9/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class SectionTwoCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var setPrice:String = "0.00"{
        didSet(newValue) {
            priceLabel.text = "￥\(newValue)"
        }
    }
    
    
}

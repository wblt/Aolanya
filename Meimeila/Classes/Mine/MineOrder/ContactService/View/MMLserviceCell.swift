//
//  MMLserviceCell.swift
//  Meimeila
//
//  Created by macos on 2017/12/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLserviceCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
   
    @IBOutlet weak var label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var setModel:MMLContactServiceModel?{
        
        didSet{
            label1.text = setModel?.name
            label2.text = setModel?.contact
        }
    }
}

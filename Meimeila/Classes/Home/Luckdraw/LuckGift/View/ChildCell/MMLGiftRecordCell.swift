//
//  MMLGiftRecordCell.swift
//  Meimeila
//
//  Created by macos on 2017/12/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLGiftRecordCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var typeLabel: UILabel!
    
   
    @IBOutlet weak var statueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var setModel:MMLExchangeModel?{
        
        didSet{
            
            nameLabel.text = setModel?.prizename;
            statueLabel.text = setModel?.statusTitle;
        }
    }
}

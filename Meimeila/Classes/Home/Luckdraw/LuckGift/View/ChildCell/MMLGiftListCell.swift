//
//  MMLGiftListCell.swift
//  Meimeila
//
//  Created by macos on 2017/12/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLGiftListCell: UITableViewCell {

    @IBOutlet weak var giftNameLabel: UILabel!
    
    @IBOutlet weak var exchangeBt: UIButton!
    
    @IBAction func exchangeBtAction(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()

        exchangeBt.layer.cornerRadius = exchangeBt.bounds.size.height/2;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var setModel:MMLLuckDrawModel?{
        
        didSet{
            giftNameLabel.text = setModel?.prizename;
            exchangeBt.setTitle(setModel?.statusTitle, for: UIControlState.normal);
            
        }
    }
}

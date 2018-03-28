//
//  payImmdiatelyCell.swift
//  Mythsbears
//
//  Created by macos on 2017/11/8.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class payImmdiatelyCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
   
    
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var selectBt: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var setUI = [String:String](){
        
        didSet{
            
            iconImageView.image = UIImage.init(named: setUI["icon"]!);
            titleLabel.text = setUI["title"];
            
        }
    }
    
}

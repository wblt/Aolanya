//
//  ProductCell.swift
//  Mythsbears
//
//  Created by macos on 2017/9/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    
    @IBOutlet weak var productIcon: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    
    @IBOutlet weak var productTitleLabel: UILabel!
    
    
    @IBOutlet weak var productLabel: UILabel!
    
    
    @IBOutlet weak var Lookwl: UIButton!
    
    
    @IBOutlet weak var verifyBt: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        Lookwl.layer.borderWidth = 1.0;
        
        Lookwl.layer.borderColor = UIColor.lightGray.cgColor;
        
        
        verifyBt.layer.borderWidth = 1.0;
        
        verifyBt.layer.borderColor = UIColor.lightGray.cgColor
        
        
    }

    
    
    
    
    @IBAction func lookWlBtAction(_ sender: Any) {
        
        print("查看物流");
    }
    
    
    
   
    @IBAction func verifyBtAction(_ sender: Any) {
        
        print("确认收货");
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

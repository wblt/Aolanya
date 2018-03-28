//
//  MMLOrderDetailSectionTwoCell.swift
//  Meimeila
//
//  Created by macos on 2017/11/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLOrderDetailSectionTwoCell: UITableViewCell {

    @IBOutlet weak var orderPrice: UILabel!
  
    @IBOutlet weak var realyPrice: UILabel!
    
    @IBOutlet weak var postPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var setModel:ShopOrderModel?{
        didSet{
            
            orderPrice.text = "￥\(setModel?.orderFinalPrice ?? "0")"
            realyPrice.text = "￥\(setModel?.orderPrice ?? "0")"
            postPrice.text  = "￥" + "\(setModel?.postage ?? "0")"
        }
    }
}

//
//  MMLOrderDetailSectionZeroCell.swift
//  Meimeila
//
//  Created by macos on 2017/11/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLOrderDetailSectionZeroCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
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
            name.text = setModel?.aeliveryAddressModel?.consignee;
           let ad = setModel?.aeliveryAddressModel?.localArea
           let add = setModel?.aeliveryAddressModel?.detailedAddress
            address.text = "\(ad ?? "") \(add ?? "")";
        }
    }
}

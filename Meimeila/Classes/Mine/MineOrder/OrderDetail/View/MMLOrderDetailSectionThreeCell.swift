//
//  MMLOrderDetailSectionThreeCell.swift
//  Meimeila
//
//  Created by macos on 2017/11/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MMLOrderDetailSectionThreeCellDelegate{
    
    func contactService()
    
}

class MMLOrderDetailSectionThreeCell: UITableViewCell {

    weak var delegate:MMLOrderDetailSectionThreeCellDelegate?
    
    @IBOutlet weak var orderTime: UILabel!
   
    @IBOutlet weak var orderNumber: UILabel!
   
    @IBOutlet weak var contactService: UIButton!
   
    
    @IBAction func contactServiceAction(_ sender: Any) {
        
        delegate?.contactService();
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contactService.layer.cornerRadius = 10;
        contactService.layer.borderColor = UIColor.lightGray.cgColor;
        contactService.layer.borderWidth = 1.0;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var setModel:ShopOrderModel?{
    
        didSet{
            
            let times = setModel?.orderTime ?? "0";
            
          //  let time = timestampToDate(format:  "yy-MM-dd HH:mm:ss", timestamp:times)
            
            orderTime.text = times;
            
            orderNumber.text = setModel?.orderID;
        }
    }
    
}

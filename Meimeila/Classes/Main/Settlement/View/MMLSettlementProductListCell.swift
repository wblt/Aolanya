//
//  MMLSettlementProductListCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLSettlementProductListCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var data: DDShoppingCarListData? {
        didSet {
            productImageView.jq_setImage(imageUrl: kPrefixLink + (data?.shopingImg)!,  placeholder: "http_error")
            productNameLabel.text = data?.shopingName
            countLabel.text = "x" + (data?.shoppingCartNumber)!
            priceLabel.text = "￥" + (data?.price)!
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

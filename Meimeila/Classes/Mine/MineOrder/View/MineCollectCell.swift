//
//  MineCollectCell.swift
//  Mythsbears
//
//  Created by macos on 2017/9/22.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MineCollectCell: UITableViewCell {

    @IBOutlet weak var iconBGView: UIView!
    
    @IBOutlet weak var iconView: UIImageView!
    
    
    @IBOutlet weak var titleText: UILabel!
    
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        iconBGView.layer.borderWidth = 0.5;
        iconBGView.layer.borderColor = UIColor.lightGray.cgColor;
        
    
    }

    
    
    var setHomeDataShopping:DDHomeDataShoping! {
        
        didSet {
            
            titleText.text = setHomeDataShopping.shopingMessage
            price.text = setHomeDataShopping.price
            count.text = setHomeDataShopping.discount
            iconView.jq_setImage(imageUrl:kPrefixLink  + setHomeDataShopping.shopingImg, placeholder: "http_error", isShowIndicator: false);
        }
        
    }
    
    ///商品信息
    var setOrderInfoData:ShopOrderInfoModel! {
        
        didSet{
            
            titleText.text = setOrderInfoData.shopingName
            price.text = "￥" + setOrderInfoData.price!
            count.text = "X" + setOrderInfoData.shoppingNumber!
            iconView.jq_setImage(imageUrl:kPrefixLink + setOrderInfoData.shopingImg!, placeholder: "http_error", isShowIndicator: false);
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

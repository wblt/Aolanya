//
//  MMHealthBeansCell.swift
//  Meimeila
//
//  Created by macos on 2017/12/11.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMHealthBeansCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
   
    
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var cellBt: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    var setDic = [String:String](){
        
        didSet{
            
            cellImage.image = UIImage.init(named: setDic["icon"] ?? "");
            cellTitle.text = setDic["name"]
            
        }
        
    }
    
    var setBtSelect = false{
        
        didSet{
            
            cellBt.isSelected = setBtSelect;
        }
    }
    
    
}

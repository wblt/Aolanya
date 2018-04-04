//
//  MMLDetailCellTableViewCell.swift
//  Meimeila
//
//  Created by macos on 2017/11/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLDetailCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var money: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var detailModel:MMLDetailModel?{
        
        didSet{
            
            //cellTitle.text = detailModel?.remarks;
			cellTitle.text = detailModel?.amountSource;
            
            time.text = detailModel?.createTime ?? "0"
				//timestampToDate(format: "yy-MM-dd HH:mm:ss", timestamp: detailModel?.createTime ?? "0");
            
            money.text = " + " + (detailModel?.amount)!;
            
            if detailModel?.isPay == 1 {
                
                money.textColor = UIColor.black;
            }else{
                
                money.textColor = APPgreenColor;
            }
        }
    }
    
    var beasnModel:MMLBeansDetailModel?{
        
        didSet{
            
            cellTitle.text = beasnModel?.remarks;
            
            time.text = beasnModel?.addtime ?? "0"
				
				//timestampToDate(format: "yy-MM-dd HH:mm:ss", timestamp: beasnModel?.addtime ?? "0");
            
            money.text = "总共" + (beasnModel?.banlance)!;

            money.textColor = APPgreenColor;
            
        }
    }
   
    var luckDrawModel:MMLLuckDrawModel?{
        
        didSet{
            
            cellTitle.text = luckDrawModel?.prizename
            
            time.text = timestampToDate(format: "yy-MM-dd HH:mm:ss", timestamp: luckDrawModel?.drawtime ?? "0");
            
            money.text = "";
            
            money.textColor = APPgreenColor;
        }
    }
}

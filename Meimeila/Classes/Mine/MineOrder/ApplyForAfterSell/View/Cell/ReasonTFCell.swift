//
//  ReasonTFCell.swift
//  Mythsbears
//
//  Created by macos on 2017/9/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol ReasonTFCellDelegate {
    
    func TFText(text:String)
}

class ReasonTFCell: UITableViewCell {

    weak var delegate:ReasonTFCellDelegate?
    
    @IBOutlet weak var reasonTF: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func TFEditing(_ sender: Any) {
        
        delegate?.TFText(text: reasonTF.text ?? "---")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

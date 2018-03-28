//
//  MMLAddressCell.swift
//  Meimeila
//
//  Created by macos on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MMLAddressCellDelegate{
    
    func longPressDeleteAddress(selectRow:Int)
    
}

class MMLAddressCell: UITableViewCell {

    weak var delegate: MMLAddressCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var detailAdressLabel: UILabel!
    
    var row:Int?{
        
        didSet{
            
            print(row ?? 11111);
            
        }
    }
    
    lazy var longPress:UILongPressGestureRecognizer = {
        
        let lp = UILongPressGestureRecognizer.init(target: self, action: #selector(longPress(guest:)))
        
        return lp;
        
    }()
    
    ///显示数据
    var addDataSource:AddressModel? {
        
        didSet{
            nameLabel.text = (addDataSource?.consignee!)!
            phoneLabel.text = addDataSource?.addresseePhone!
            addressLabel.text = (addDataSource?.localArea!)!
            detailAdressLabel.text = (addDataSource?.detailedAddress!)!
                //+ "(\(addDataSource?.postcode))"
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.addGestureRecognizer(longPress);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func longPress(guest:UILongPressGestureRecognizer){
        
        print("删除!");
        
        delegate?.longPressDeleteAddress(selectRow: row ?? 11111);
    }
    
}

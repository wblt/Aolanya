//
//  MMLWithdrawalRecordCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLWithdrawalRecordCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    var data: MMLWithdrawRecordData? {
        didSet {
            timeLabel.text = timestampToDate(format: "yyyy-mm-dd", timestamp: (data?.withdrawalsTime)!)
            methodLabel.text = data?.withdrawalsType == 0 ? "支付宝" : "微信"
            var statusStr = ""
            if data?.withdrawalsState == 0 {
                statusStr = "申请中"
            }else if data?.withdrawalsState == 1 {
                statusStr = "已提现"
            }else {
                statusStr = "提现失败"
            }
            statusLabel.text = statusStr
            moneyLabel.text = "￥" + (data?.withdrawalsMoney)!
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

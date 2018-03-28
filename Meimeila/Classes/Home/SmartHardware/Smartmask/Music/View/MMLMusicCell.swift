//
//  MMLMusicCell.swift
//  Meimeila
//
//  Created by macos on 2017/11/22.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMusicCell: UITableViewCell {

    @IBOutlet weak var musicTitle: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var rubbishBt: UIButton!
    
    
    @IBOutlet weak var playBt: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var musicListModel:MMLMusicModel?{
        didSet{
            musicTitle.text = musicListModel?.name;
            name.text = musicListModel?.singer;
            
        }
    }
}

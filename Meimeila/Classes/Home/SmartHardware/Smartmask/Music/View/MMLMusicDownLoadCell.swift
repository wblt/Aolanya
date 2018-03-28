//
//  MMLMusicDownLoadCell.swift
//  Meimeila
//
//  Created by macos on 2017/11/22.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMusicDownLoadCell: UITableViewCell {

    @IBOutlet weak var musicTitle: UILabel!
   
    
    @IBOutlet weak var playBt: UIButton!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var downBt: UIButton!
    
    @IBAction func playBtAction(_ sender: Any) {
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var musicListenModel:MMLMusicModel?{
        
        didSet{
            
            musicTitle.text = musicListenModel?.songdata ?? musicListenModel?.name;
            name.text = musicListenModel?.songdata ?? musicListenModel?.singer;
        }
    }
}

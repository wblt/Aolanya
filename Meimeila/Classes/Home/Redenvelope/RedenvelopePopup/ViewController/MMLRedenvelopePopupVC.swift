//
//  MMLRedenvelopePopupVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLRedenvelopePopupVC: UIViewController {

    @IBOutlet weak var moneyLabel: UILabel!
    var money: Double = 0.00
    
    init() {
        super.init(nibName: String.init(describing: MMLRedenvelopePopupVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyLabel.text = "\(money)"

    }
    
    // MARK: - Event respose
    @IBAction func dissmissButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    


}

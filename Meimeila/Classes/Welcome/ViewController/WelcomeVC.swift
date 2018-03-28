//
//  WelcomeVC.swift
//  Mythsbears
//
//  Created by macos on 2017/9/25.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

protocol WelcomeVCDelegate: class {
    func welcomeVCShowFinish()
}

class WelcomeVC: UIViewController {

    weak var delegate: WelcomeVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        setUI();
        
        
    }

    
    func  setUI() {
        
        self.view.addSubview(scrollerview);
        
        let image0 = addImageView(CGRect.init(x: 0, y: 0, width: Screen.width, height: Screen.height), "guidance_new1");
        
        let image1 = addImageView(CGRect.init(x: Screen.width, y: 0, width: Screen.width, height: Screen.height), "guidance_new2");
        
        let image2 = addImageView(CGRect.init(x: Screen.width * 2, y: 0, width: Screen.width, height: Screen.height), "guidance_new3");
        
        image2.addSubview(enterBt);
        
        scrollerview.addSubview(image0);
        scrollerview.addSubview(image1);
        scrollerview.addSubview(image2);

        
    }
    
    
    var window:UIWindow?;
    var tabbarVc:DDTabBarViewController?;
    
    fileprivate lazy var scrollerview:UIScrollView = {
    
        let sc = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: Screen.height));
    
        sc.contentSize = CGSize.init(width: Screen.width * 3, height: Screen.height);
        
        sc.showsHorizontalScrollIndicator = false;
        sc.bounces = false
        sc.isPagingEnabled = true;
        
        return sc;
    
    }()
    
    fileprivate lazy var enterBt:UIButton = {
        
        let bt = UIButton.init(type:UIButtonType.custom);
        bt.frame = CGRect.init(x: (Screen.width - 120) / 2.0, y: Screen.height - Screen.width/3, width: 120, height: 40);
        bt.backgroundColor = UIColor.init(r: 181, g: 144, b: 239);
        bt.setTitle("立即体验", for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        bt.layer.cornerRadius = 20
        bt.addTarget(self, action: #selector(btAcion), for: .touchUpInside);
        return bt;
    }()
    
    
  fileprivate  func addImageView(_ fram:CGRect ,_ imageName:String) -> UIImageView{
        
        let imageV = UIImageView.init(frame: fram);
        imageV.image = UIImage.init(named: imageName);
        imageV.isUserInteractionEnabled = true;
        
        return imageV;
    }
    
    
    @objc func btAcion() {
        

        
        DDDeviceManager.shared.saveFirstLoadStatus(isFirst: true)
        
        // 执行动画
        view.alpha = 1.0
        UIView.animate(withDuration: 0.80, animations: {
            self.view.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
            self.view.alpha = 0
        }) { (finish) in
            if let _ = self.delegate {
                self.delegate?.welcomeVCShowFinish()
            }
            self.view.transform = CGAffineTransform.identity
            self.view.removeFromSuperview()
        }
       
        if let win = window, let tab = tabbarVc{
            
            win.rootViewController = tab;
        }
        
    }
    
  }

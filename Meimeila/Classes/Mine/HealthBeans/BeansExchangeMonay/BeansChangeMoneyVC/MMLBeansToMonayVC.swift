//
//  MMLBeansToMonayVC.swift
//  Meimeila
//
//  Created by macos on 2017/12/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLBeansToMonayVC: DDBaseViewController {
	// 导航栏右边的按钮
	fileprivate var navBarRightButton: UIButton = UIButton()
	
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLBeansToMonayVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBOutlet weak var beansCountLabel: UILabel!
   
    
    @IBOutlet weak var exchangeCountLabel: UILabel!
    
    
    @IBAction func exchangeBtAction(_ sender: Any) {
        
        if let _ = popWin{
            
            return;
        }
        
        let pop = DDPopupWindowVC.init(message: "是否兑换\(num)颗健康豆", leftButtonTitle: "取消", rightButtonTitle: "兑换");
        pop.delegate = self;
        self.popWin = pop;
        
        self.addChildViewController(pop);
        pop.view.frame = self.view.bounds;
        
        self.view.addSubview(pop.view);
    }
    
    lazy var vm:MMLBeansViewModel = {
        let vm = MMLBeansViewModel.init();
        return vm;
    }()
    
    
    var num = 0;
    
    
    var popWin:DDPopupWindowVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setupNavBar()
		/*
		let vc = MMLPocketDetailVC();
		vc.isHealBeans = self.isHealthBean;
		navigationController?.pushViewController(vc, animated: true);
		*/
    }

	
	// MARK: - Private methods
	private func setupNavBar() {
		addNavBarRightButton(btnTitle: "明细", titleColor: UIColor.white) { [weak self](btn) in
			self?.navBarRightButton = btn
			let vc = MMLPocketDetailVC();
			vc.isHealBeans = true;
			self?.navigationController?.pushViewController(vc, animated: true);
		}
	}
	
    override func setupUI() {
        
        getCountRequest();
        
    }
    
    
}

extension MMLBeansToMonayVC{
    
    ///总豆数
    func getCountRequest() {
        
        vm.beansCount {[weak self] (count) in
            
            self?.beansCountLabel.text = count;
            
            let countNum = Int(count);
            
            let num = countNum! / 100;
            self?.num = num * 100;
            
            self?.exchangeCountLabel.text = "可兑换\(num * 100)颗"
            
        }
    }
    
    ///对换请求
    func exchangeRequest() {
        vm.beansToMonayExchange(num:"\(num)") {[weak self] in
            
            
            BFunction.shared.showMessage("兑换成功");
            
            self?.getCountRequest();
        }
    }
    

    
}


extension MMLBeansToMonayVC:DDPopupWindowVCDelegate{
    func popupWindowVCLeftButtonAction(button: UIButton) {
        
        popWin?.view.removeFromSuperview();
        popWin = nil;
    }
    
    func popupWindowRightVCButtonActtion(button: UIButton) {
            popWin?.view.removeFromSuperview();
            self.exchangeRequest();
            popWin = nil;

    }
    
    
    
}

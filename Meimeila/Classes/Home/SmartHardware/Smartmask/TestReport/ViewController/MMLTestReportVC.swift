//
//  MMLTestReportVC.swift
//  Meimeila
//
//  Created by macos on 2017/11/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLTestReportVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLTestReportVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    fileprivate lazy var productDetailsViewModel: DDProductDetailsViewModel = {
        let viewModel = DDProductDetailsViewModel()
        return viewModel
    }()
    
    
    override func setupUI() {
        self.title = "测试结果";
        
        setTableView();
        
        addNavBarRightButton(imageName: "productdetails_shopping_message") {[weak self] (bt) in
            
            let VC = MMLShareVC()
            VC.delegate = self
            VC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self?.present(VC, animated: false, completion: nil)        }
    }
    
    var resultArr:[[String : Int]]!;
    
    var titleArr = ["皮肤水分","皮肤油分"];
}


extension MMLTestReportVC:MMLShareVCDelegate{
    
    func shareModule(moduleType: UMShareType) {
        
        debugLog(moduleType)
        if moduleType == .wechat || moduleType == .wechatLine {
            if !DDWechatShare.shared.isWXAppInstalled() {
                BFunction.shared.showToastMessge("需安装微信客户端，才能使用该功能！")
                return
            }
        }
        // 分享
        var title = ""
        var content = ""
        var imageURL: String = "img"
        var downloadUrl = "http://ml.nnddkj.com/meimeila/API/download/appDownload.php"
        
        if let _ = self.productDetailsViewModel.productDetailsModel {
            if let data = self.productDetailsViewModel.productDetailsModel?.shoppingData {
                title = data.shopingName
                content = data.shopingMessage
                imageURL = kPrefixLink + data.shopingImg
                downloadUrl = "http://ml.nnddkj.com/meimeila/API/download/appDownload.php?shopingID=" + data.shopingID
            }
        }
        
        let imageData = NSData.init(contentsOf: URL.init(string: imageURL)!)
        var image = UIImage.init(named: "1024")
        if let _ = imageData {
            image = UIImage.init(data: imageData! as Data)!
            if let _ = image  {
            }else {
                image = UIImage.init(named: "1024")
            }
        }
        let model = MMLShareWebpageObject()
        model.title = "奥蓝雅面膜测试"
        model.desStr = "智能面膜"
        model.webpageUrl = downloadUrl
       ////////
        model.image = screenShot()!
        
        MMLUMengShareTool.shared.showShareType(type: moduleType, object: model, currentViewController: self, shareSuccessBlock: {
            self.shareSuccess()
        }) {
            
        }
    }
}


// MARK: - 分享成功
extension MMLTestReportVC {
    
    private func shareSuccess() {
        let request = ShareAPI.shareSuccess()
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            
        }, requestError: { (result, errorModel) in
            
        }) { (error) in
            
        }
    }
    
    
    
    // 使用上下文截图,并使用指定的区域裁剪,模板代码
    private func screenShot() -> UIImage?{
        guard let window = UIApplication.shared.keyWindow else { return nil }
        
        // 用下面这行而不是UIGraphicsBeginImageContext()，因为前者支持Retina
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0.0)
        
        window.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
}


extension MMLTestReportVC{
    
    func setTableView() {
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = footBt();
        tableView.backgroundColor = DDGlobalBGColor()
        tableView.showsVerticalScrollIndicator = false;
        tableView.separatorStyle = .none;
        tableView.register(UINib.init(nibName: String.init(describing: MineCollectCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MineCollectCell.self));
        
    }
    
    
    func footBt() -> UIButton {
        
        let bt = UIButton.init(type: .custom);
        bt.frame = CGRect.init(x: 0, y: 0, width: Screen.width, height: 44);
        bt.setTitle("分享", for: UIControlState.normal);
        bt.setTitleColor(UIColor.white, for: UIControlState.normal);
        bt.backgroundColor = DDGlobalNavBarColor();
        bt.addTarget(self, action: #selector(btAction), for: UIControlEvents.touchUpInside);
        return bt;
    }
    
    @objc func btAction(){
        
        let VC = MMLShareVC()
        VC.delegate = self
        VC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(VC, animated: false, completion: nil)
        
    }
    
}
extension MMLTestReportVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            var cell:MMLReportWaterAndOilCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLReportWaterAndOilCell.self)) as? MMLReportWaterAndOilCell;
            cell?.selectionStyle = .none;
            if let _ = cell {
                
            }else{
                
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLReportWaterAndOilCell.self), owner: nil, options: nil)?.last as? MMLReportWaterAndOilCell;
            }
            cell?.selectionStyle = .none;
            
            cell?.cellTitle.text = titleArr[indexPath.row];
            
            let dic = resultArr[indexPath.row]
            
            cell?.setCycle(beforePrecent: dic["before"] ?? 0, afterPrecent: dic["after"] ?? 0);
            
            return cell!;
        }else if indexPath.section == 1 {
            
            var cell:MMLReportTitleCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLReportTitleCell.self)) as? MMLReportTitleCell;
            cell?.selectionStyle = .none;
            if let _ = cell {
                
            }else{
                
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLReportTitleCell.self), owner: nil, options: nil)?.last as? MMLReportTitleCell;
            }
            cell?.selectionStyle = .none;

            return cell!;
        }else if indexPath.section == 2 {
            
            var cell:MMLReportDouCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLReportDouCell.self)) as? MMLReportDouCell;
            cell?.separatorInset.left = 0;
            cell?.selectionStyle = .none;
            if let _ = cell {
                
            }else{
                
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLReportDouCell.self), owner: nil, options: nil)?.last as? MMLReportDouCell;
            }
            cell?.selectionStyle = .none;

            return cell!;
        }else{
            
            var cell:MMLReportShareCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLReportShareCell.self)) as? MMLReportShareCell;
            cell?.separatorInset.left = 0;
            cell?.selectionStyle = .none;
            if let _ = cell {
                
            }else{
                
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLReportShareCell.self), owner: nil, options: nil)?.last as? MMLReportShareCell;
            }
            cell?.selectionStyle = .none;

            return cell!;
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 220
        }else if indexPath.section == 1 {
            return 74;
        }else if indexPath.section == 2{
            return 84;
        }else{
            return 49;
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 2;
        }
        return 1;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4;
    }
}


extension MMLTestReportVC:UITableViewDelegate{
    
}

//
//  SelectAddressVC.swift
//  Mythsbears
//
//  Created by macos on 2017/9/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class SelectAddressVC: DDBaseViewController {

    
    var selectAddress:((_ address:String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "地址选择-省"
        
        setUI();
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing:String.init(describing: SelectAddressVC.self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet weak var tableView: UITableView!
    
    
    func  setUI() {
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 54;
        tableView.tableFooterView = UIView.init();
    }
    
    lazy var ssqManger : SSQManager = {
        let manger = SSQManager.shared;
        manger.plistSource();
        return manger ;
    }()
    
    
    var provice :String?
    var city :String?
    var area :String?
    
    var selectProviceIndex:Int = 0;
    var selectCityIndex:Int = 0;
    var selectAreaIndex:Int = 0;

}


extension SelectAddressVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if provice == nil {
        
            selectProviceIndex = indexPath.row
            
            provice = ssqManger.provinceArr[indexPath.row];
            
            self.title = "地址选择-市"

        }else if city == nil {
            
            selectCityIndex = indexPath.row
            let arr = ssqManger.cityArrs[selectProviceIndex];
            city = arr[selectCityIndex];
            
            self.title = "地址选择-区"

        }else{
            
            selectAreaIndex = indexPath.row
            
            let arr0 = ssqManger.areaArrs[selectProviceIndex];
            let arr1 = arr0[selectCityIndex];
            area = arr1[selectAreaIndex];
            
            var address = provice!
            
            if provice! != city!{
                
                address += "/" + city!
            }

            if city! != area!{
                
                address += "/" + area!;
            }
            
            selectAddress!(address);
            navigationController?.popViewController(animated: true);
        }
    
        tableView.reloadData();
    }
}


extension SelectAddressVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: UITableViewCell.self))
        
        if let _ = cell {
            
        }else{
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: String.init(describing: UITableViewCell.self))
        }
        
        
        if provice == nil {
            cell?.textLabel?.text = ssqManger.provinceArr[indexPath.row]
        }else if city == nil {
            let arr = ssqManger.cityArrs[selectProviceIndex];
            cell?.textLabel?.text = arr[indexPath.row];
        }else{
            let arr0 = ssqManger.areaArrs[selectProviceIndex];
            let arr1 = arr0[selectCityIndex];
            cell?.textLabel?.text = arr1[indexPath.row];
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if provice == nil{
            return ssqManger.provinceArr.count;
            
        }else if  city == nil {
            
            let arr = ssqManger.cityArrs[selectProviceIndex];
            
            return arr.count;
        }else {
            
            let arr0 = ssqManger.areaArrs[selectProviceIndex];
            
            let arr1 = arr0[selectCityIndex];
            
            return arr1.count;
        }
        
    
    
    }
}

//
//  SmartmaskDateVC.swift
//  Mythsbears
//
//  Created by macos on 2017/11/10.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class SmartmaskDateVC: DDBaseViewController {

    @IBOutlet weak var waterView: UIView!
    
    
    @IBOutlet weak var iolView: UIView!
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: SmartmaskDateVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getDataList();
    }

    override func setupUI() {
        
        waterView.addSubview(waterChart);
        iolView.addSubview(oilChart);
        adjustlayout();
    }
    
    
    func adjustlayout() {
        waterChart.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        oilChart.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
    
    lazy var waterChart:SmartmaskChartsDataView = {
        
        let view = SmartmaskChartsDataView.init(frame: CGRect.zero);
        return view;
    }()
    
    lazy var oilChart:SmartmaskChartsDataView = {
        
        let view = SmartmaskChartsDataView.init(frame: CGRect.zero);
        return view;
    }()
    
    lazy var vm:SmartmaskViewModel = {
        let vm = SmartmaskViewModel.shared
        return vm;
    }()
   
}

//MARK 折线图
extension SmartmaskDateVC {
    
    func lineChartConfigure(){
        
        waterLine();
        oilLine();
        
        addData(water: vm.waterArr, oil: vm.oilArr);
    }

    
    
    func waterLine() {
        waterChart.setX(xAxisDatas: []);
        
        waterChart.setLeftY(yAxisDatas: ["0","20","40","60","80","100"], axisMaximum: 100, axisMinimum: 0)
        
        waterChart.setRightY(yAxisDatas: ["0","20","40","60","80","100"], axisMaximum: 100, axisMinimum: 0)
        
//        waterChart.addLimitLine(position: 90, dashStyle: [8,8], lineColor: UIColor.red, lineTitle: "及格线", linetTitleColor: UIColor.orange, addLeftY: true);
        
    }
    
    func oilLine() {
        oilChart.setX(xAxisDatas: []);
        
        oilChart.setLeftY(yAxisDatas: ["0","20","40","60","80","100"], axisMaximum: 100, axisMinimum: 0)
        
        oilChart.setRightY(yAxisDatas: ["0","20","40","60","80","100"], axisMaximum: 100, axisMinimum: 0)
        
//        oilChart.addLimitLine(position: 90, dashStyle: [8,8], lineColor: UIColor.red, lineTitle: "及格线", linetTitleColor: UIColor.orange, addLeftY: true);
        
    }
    
    
    func addData(water:[Double],oil:[Double]) {
        
        waterChart.upDatas(dataArr: [water], circleColorArr: [DDGlobalNavBarColor()], circleHoleColorArr: [UIColor.white], lineColorArr: [DDGlobalNavBarColor()]);

        oilChart.upDatas(dataArr: [oil], circleColorArr: [DDGlobalNavBarColor()], circleHoleColorArr: [UIColor.white], lineColorArr: [DDGlobalNavBarColor()]);

    }
    
}


//MARK 网络请求

extension SmartmaskDateVC{
    
    func getDataList() {
        
        ///数据请求
        vm.getMaskListData(suceeds: {[weak self] in
            self?.lineChartConfigure();
        }) {
            
        }
    }
}


//
//  DDLineChartView.swift
//  Mythsbears
//
//  Created by macos on 2017/11/8.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Charts
class DDLineChartView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        
        addSubview(lineChart);
        
        lineChart.snp.makeConstraints { (make) in
            make.edges.equalToSuperview();
        }
    }
    
    lazy var  lineChart:LineChartView = {
        let view = LineChartView.init(frame: CGRect.zero);
        view.delegate = self;
        return view;
    }()
}



extension DDLineChartView:ChartViewDelegate{
    
    // 点击选中柱形图时的代理方法
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
    }
    
    // 没有选中柱形图时的代理方法
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
    }
    
    // 捏合放大或缩小柱形图时的代理方法
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        
    }
    
    // 拖拽图表时的代理方法
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        
    }
}

//
//  SmartmaskChartsDataView.swift
//  Mythsbears
//
//  Created by macos on 2017/11/10.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Charts
class SmartmaskChartsDataView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        
        self.addSubview(lineChartView);
        
        lineChartView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview();
        }
    }
    
    
    lazy var lineChartView:JQLineChartView = {
        let line = JQLineChartView.init(frame: CGRect.zero);
        return line;
    }()
    
}

extension SmartmaskChartsDataView{
    
    
    func setX(xAxisDatas:[String]) {
        
        // 基本配置
        lineChartView.setupBaseConfig(config: DDLineChartBaseConfig())
       
        let xAxisStyle = DDLineChartXAxisStyle()
      
        let valueFormatter = DDLineChartXAxisValueFormatter.init()
        valueFormatter.xAxisDatas = xAxisDatas
    
        xAxisStyle.xvalueFormatter = valueFormatter
        lineChartView.setupXAxis(xAxisStyle: xAxisStyle)
        
    }
    
    
    func setLeftY(yAxisDatas:[String],axisMaximum:Double,axisMinimum:Double) {
        
        // 左边Y轴
        let leftYAxisStyle = DDLineChartLeftYAxisStyle()
    
        leftYAxisStyle.axisMaximum = axisMaximum;
        leftYAxisStyle.axisMinimum = axisMinimum;
        
        let yvalueFormatter = DDLineChartYAxisValueFormatter.init()
        yvalueFormatter.yAxisDatas = yAxisDatas;
        leftYAxisStyle.yvalueFormatter = yvalueFormatter
        lineChartView.setupLeftYAxis(leftYAxisStyle: leftYAxisStyle)

    }
    
    
    func setRightY(yAxisDatas:[String],axisMaximum:Double,axisMinimum:Double) {
        
        // 右边Y轴
        let rightYAxisStyle = DDLineChartRightYAxisStyle()
        rightYAxisStyle.labelTextColor = UIColor.black;
        rightYAxisStyle.axisMaximum = axisMaximum;
        rightYAxisStyle.axisMinimum = axisMinimum;
        
        let yvalueFormatter = DDLineChartYAxisValueFormatter.init()
        yvalueFormatter.yAxisDatas = yAxisDatas
        rightYAxisStyle.yvalueFormatter = yvalueFormatter
        lineChartView.setupRightYAxis()

    }
    
    ///添加限制线
    func addLimitLine(position Y:Double,dashStyle:[CGFloat],lineColor:UIColor,lineTitle:String,linetTitleColor:UIColor,addLeftY:Bool){
        
     
        let limitLineStyle = DDLineChartLimitLineStyle()
        limitLineStyle.y = Y
        limitLineStyle.lineDashLengths = dashStyle
        limitLineStyle.text = lineTitle
        limitLineStyle.textColor = linetTitleColor
        let limitLine = lineChartView.getLimitLine(style: limitLineStyle)
        
        if addLeftY {
            let leftAxis = lineChartView.getLeftYAxis()
            leftAxis.addLimitLine(limitLine)
        }else {
            let rightAxis = lineChartView.getRightYAxis()
            rightAxis.addLimitLine(limitLine)
        }
    }
    
    
    func dateSet(data:[Double],circleColor:UIColor,circleHoleColor:UIColor,lineColor:UIColor) -> LineChartDataSet{
        let lineChartDataEntry = lineChartView.setupChartDataEntry(xVals_count: data.count, datas: data)
        let lineDataSetStyle = setLineChartLineDataSetStyle(circleColor: circleColor, circleHoleColor: circleHoleColor,lineColor: lineColor);
        
        let dataSet = lineChartView.setupLineDataSet(lineDataSetStyle: lineDataSetStyle, yVals: lineChartDataEntry)
        return dataSet;
    }
    
    ///设置折现样式
    func setLineChartLineDataSetStyle(circleColor:UIColor,circleHoleColor:UIColor,lineColor:UIColor) -> DDLineChartLineDataSetStyle{
        let lineDataSetStyle = DDLineChartLineDataSetStyle()
        lineDataSetStyle.circleColor = circleColor
        lineDataSetStyle.circleHoleColor = circleHoleColor
        lineDataSetStyle.lineColor = lineColor
        return lineDataSetStyle;
    }
    
    ///刷新数据
    func upDatas(dataArr:[[Double]],circleColorArr:[UIColor],circleHoleColorArr:[UIColor],lineColorArr:[UIColor]) {
        
        var dataSetArr = [LineChartDataSet]()
        
        for index in 0 ..< dataArr.count {
            
            let dataSet = dateSet(data: dataArr[index], circleColor: circleColorArr[index], circleHoleColor:circleHoleColorArr[index],lineColor: lineColorArr[index]);

            dataSetArr.append(dataSet);
        }
        
        let data = lineChartView.setupLineChartData(data: dataSetArr)
    
        lineChartView.lineChartView.data = data;
    }
    
    
    
   
    // 设置折线图数据
    func setLineChartData() {
        // 基本配置
        lineChartView.setupBaseConfig(config: DDLineChartBaseConfig())
        
        //  x轴
        let xAxisStyle = DDLineChartXAxisStyle()
        let valueFormatter = DDLineChartXAxisValueFormatter.init()
        valueFormatter.xAxisDatas = []
        xAxisStyle.xvalueFormatter = valueFormatter
        lineChartView.setupXAxis(xAxisStyle: xAxisStyle)
        
        // 左边Y轴
        let leftYAxisStyle = DDLineChartLeftYAxisStyle()
        let yvalueFormatter = DDLineChartYAxisValueFormatter.init()
        yvalueFormatter.yAxisDatas = ["0ml","20ml", "40ml","60ml","80ml","100ml"]
        leftYAxisStyle.yvalueFormatter = yvalueFormatter
        lineChartView.setupLeftYAxis(leftYAxisStyle: leftYAxisStyle)
        
        
        // 右边Y轴
        let rightYAxisStyle = DDLineChartRightYAxisStyle()
        let ryvalueFormatter = DDLineChartYAxisValueFormatter.init()
        ryvalueFormatter.yAxisDatas = ["0ml","20ml", "40ml","60ml","80ml","100ml"]
        rightYAxisStyle.yvalueFormatter = ryvalueFormatter
        lineChartView.setupRightYAxis(rightYAxisStyle: rightYAxisStyle)
        
        // 红色的限制线
        let leftAxis = lineChartView.getLeftYAxis()
        let redLimitLineStyle = DDLineChartLimitLineStyle()
        redLimitLineStyle.y = 80
        redLimitLineStyle.lineDashLengths = [8, 8]
        redLimitLineStyle.text = "限制线"
        redLimitLineStyle.textColor = UIColor.red
        let redLimitLine = lineChartView.getLimitLine(style: redLimitLineStyle)
        leftAxis.addLimitLine(redLimitLine)
        
        // 数据相关
        // 第一组测试数据
        let dataArray = [90.0, 50, 80]
        let lineChartDataEntry = lineChartView.setupChartDataEntry(xVals_count: dataArray.count, datas: dataArray)
        let lineDataSetStyle = DDLineChartLineDataSetStyle()
        let dataSet = lineChartView.setupLineDataSet(lineDataSetStyle: lineDataSetStyle, yVals: lineChartDataEntry)
        
        // 第二组测试数据
        let data2 = [88, 67, 90.0]
        let lineChartDataEntry2 = lineChartView.setupChartDataEntry(xVals_count: dataArray.count, datas: data2)
        let dataSet2 = lineChartView.setupLineDataSet(lineDataSetStyle: lineDataSetStyle, yVals: lineChartDataEntry2)
        
        let data = lineChartView.setupLineChartData(data: [dataSet, dataSet2])
        
        lineChartView.lineChartView.data = data
        
        
    }

}




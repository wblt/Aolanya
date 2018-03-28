//
//  DDLineChartsView.swift
//  ChartDemo
//
//  Created by HJQ on 2017/10/22.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Charts
import SnapKit

// 折线图
class JQLineChartView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Public method
    // 提供方法获取左边的y坐标轴（主要用来绘制限制线）
    func getLeftYAxis() -> YAxis{
        return lineChartView.leftAxis
    }
    
    // 获取右边的y轴
    func getRightYAxis() -> YAxis{
        return lineChartView.leftAxis
    }
    
    // 获取x轴
    func getXAxis() -> XAxis {
        return lineChartView.xAxis
    }
    
    
    // 基本属性配置
    func setupBaseConfig(config: DDLineChartBaseConfig = DDLineChartBaseConfig()) {
        // 没有数据提示
        lineChartView.noDataFont = config.noDataFont
        lineChartView.noDataTextColor = config.noDataTextColor
        lineChartView.noDataText = config.noDataText
        
        // 图例说明
        lineChartView.chartDescription?.enabled = config.chartDescriptionEnabled
        lineChartView.chartDescription?.text = config.chartDescriptionText
        lineChartView.chartDescription?.font = config.chartDescriptionFont
        lineChartView.chartDescription?.textColor = config.chartDescriptionTextColor
        lineChartView.chartDescription?.textAlign = config.chartDescriptionTextAlign
        lineChartView.legend.enabled = config.legendEnabled
        
        // 取消XY轴缩放
        lineChartView.scaleYEnabled = config.scaleXEnabled
        lineChartView.scaleXEnabled = config.scaleYEnabled
        
        //启用拖拽图标
        lineChartView.dragEnabled = config.dragEnabled
        //拖拽后是否有惯性效果
        lineChartView.dragDecelerationEnabled = config.dragDecelerationEnabled
        //拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        lineChartView.dragDecelerationFrictionCoef = config.dragDecelerationFrictionCoef
        
        // 设置动画时间（每条轴都可以设置）
        //lineChartView.animate(xAxisDuration: config.xAnimationTime)
        lineChartView.animate(xAxisDuration: config.xAnimationTime, easingOption: ChartEasingOption.linear)
        
    }
    
    // 设置左边的Y轴
    func setupLeftYAxis(leftYAxisStyle: DDLineChartLeftYAxisStyle = DDLineChartLeftYAxisStyle()) {
        // 不绘制右边轴
        lineChartView.rightAxis.enabled = leftYAxisStyle.rightAxisEnable
        // 获取左边的Y轴
        let leftYAxis = lineChartView.leftAxis
        // //Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
        leftYAxis.labelCount = leftYAxisStyle.labelCount
        leftYAxis.forceLabelsEnabled = leftYAxisStyle.forceLabelsEnabled
        // 最大最小值
        leftYAxis.axisMinimum = leftYAxisStyle.axisMinimum
        leftYAxis.axisMaximum = leftYAxisStyle.axisMaximum
        
        leftYAxis.valueFormatter = leftYAxisStyle.yvalueFormatter
        
        // 是否将Y轴进行上下翻转
        leftYAxis.inverted = leftYAxisStyle.inverted
        // Y轴颜色
        leftYAxis.axisLineColor = leftYAxisStyle.axisLineColor
        leftYAxis.drawGridLinesEnabled = leftYAxisStyle.drawGridLinesEnabled
        // label位置
        leftYAxis.labelPosition = leftYAxisStyle.labelPosition
        // 显示文字的颜色
        leftYAxis.labelTextColor = leftYAxisStyle.labelTextColor
        // 网格线
        leftYAxis.gridLineWidth = leftYAxisStyle.gridLineWidth
        leftYAxis.gridColor = leftYAxisStyle.gridColor
        // 开启抗锯齿
        leftYAxis.gridAntialiasEnabled = leftYAxisStyle.gridAntialiasEnabled
        // 设置数值样式
        //leftYAxis.valueFormatter
        
    }
    
    // 设置右边的Y轴
    func setupRightYAxis(rightYAxisStyle: DDLineChartRightYAxisStyle = DDLineChartRightYAxisStyle()) {
        // 不绘制右边轴
        lineChartView.rightAxis.enabled = rightYAxisStyle.rightAxisEnable
        // 获取左边的Y轴
        let rightYAxis = lineChartView.rightAxis
        // //Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
        rightYAxis.labelCount = rightYAxisStyle.labelCount
        rightYAxis.forceLabelsEnabled = rightYAxisStyle.forceLabelsEnabled
        // 最大最小值
        rightYAxis.axisMinimum = rightYAxisStyle.axisMinimum
        rightYAxis.axisMaximum = rightYAxisStyle.axisMaximum
        
        rightYAxis.valueFormatter = rightYAxisStyle.yvalueFormatter
        
        // 是否将Y轴进行上下翻转
        rightYAxis.inverted = rightYAxisStyle.inverted
        // Y轴颜色
        rightYAxis.axisLineColor = rightYAxisStyle.axisLineColor
        // label位置
        rightYAxis.labelPosition = rightYAxisStyle.labelPosition
        // 显示文字的颜色
        rightYAxis.labelTextColor = rightYAxisStyle.labelTextColor
        // 网格线
        rightYAxis.drawGridLinesEnabled = rightYAxisStyle.drawGridLinesEnabled
        rightYAxis.gridLineWidth = rightYAxisStyle.gridLineWidth
        rightYAxis.gridColor = rightYAxisStyle.gridColor
        // 开启抗锯齿
        rightYAxis.gridAntialiasEnabled = rightYAxisStyle.gridAntialiasEnabled
        
    }
    
    // 设置X轴
    func setupXAxis(xAxisStyle: DDLineChartXAxisStyle = DDLineChartXAxisStyle()) {
        let xAxis = lineChartView.xAxis
        // 设置重复的数值不显示
        xAxis.granularityEnabled = xAxisStyle.granularityEnabled
        // 设置数值显示在底部
        xAxis.labelPosition = xAxisStyle.labelPosition
        // 设置网格线
        xAxis.gridColor = xAxisStyle.gridColor
        xAxis.gridLineWidth = xAxisStyle.gridLineWidth
        xAxis.labelFont = xAxisStyle.labelFont
        xAxis.labelTextColor = xAxisStyle.labelTextColor
        xAxis.valueFormatter = xAxisStyle.xvalueFormatter
    
        // x轴的颜色
        xAxis.axisLineColor = xAxisStyle.axisLineColor
        // 设置能够显示的数据数量
//        xAxis.spaceMax = 999
    }
    
    /// 限制线
    func getLimitLine(style: DDLineChartLimitLineStyle) ->  ChartLimitLine {
        // 用来做顶部的封口线
        let limitLine = ChartLimitLine.init(limit: style.y, label: style.text)
        limitLine.lineWidth = style.lineWidth
        limitLine.lineColor = style.lineColor
        
        limitLine.valueTextColor = style.textColor
        // 设置限制线提示文字的大小
        limitLine.valueFont = style.font
        //虚线样式
        limitLine.lineDashLengths = style.lineDashLengths
        // 位置
        limitLine.labelPosition = style.labelPosition
        return limitLine
    }
    
    func setupChartDataEntry(xVals_count: Int, datas: [Double]) -> [ChartDataEntry] {
        var yVals = [ChartDataEntry]()
        for i in 0..<xVals_count {
            let data = ChartDataEntry.init(x: Double(i), y: datas[i])
            yVals.append(data)
        }
        return yVals
    }
    
    // 设置dataSet 可以设置显示
    func setupLineDataSet(lineDataSetStyle: DDLineChartLineDataSetStyle = DDLineChartLineDataSetStyle(), yVals: [ChartDataEntry]) -> LineChartDataSet {
        let lineDataSet = LineChartDataSet.init(values: yVals, label: "")
        // 设置折线的宽度
        lineDataSet.lineWidth = lineDataSetStyle.lineWidth
        // 折线的颜色
        lineDataSet.setColor(lineDataSetStyle.lineColor)
        lineDataSet.highlightColor = lineDataSetStyle.highlightColor
        
        // 是否在拐点显示数值
        lineDataSet.drawValuesEnabled = lineDataSetStyle.drawValuesEnabled
        // 拐点样式设置
        // 是否设置拐点
        lineDataSet.drawCirclesEnabled = lineDataSetStyle.drawCirclesEnabled
        
        lineDataSet.drawCircleHoleEnabled = lineDataSetStyle.drawCircleHoleEnabled
        lineDataSet.circleHoleColor = lineDataSetStyle.circleHoleColor
        lineDataSet.circleHoleRadius = lineDataSetStyle.circleHoleRadius
        
        lineDataSet.setCircleColor(lineDataSetStyle.circleColor)
        lineDataSet.circleRadius = lineDataSetStyle.circleRadius
        
        
        // 是否填充颜色
        lineDataSet.drawFilledEnabled = lineDataSetStyle.drawFilledEnabled
        // 设置拐点显示的值
        //lineDataSet.valueFormatter
        
        return lineDataSet
    }
    
    // 设置数据源
    func setupLineChartData(data: [LineChartDataSet]) -> LineChartData {
        let data = LineChartData.init(dataSets: data)
        // 可以设置显示的字体和颜色
        //data.setValueFont(UIFont.systemFont(ofSize: 12))
        //data.setValueTextColor(UIColor.clear)
        return data
    }
    
    // MARK: - Private method
    private func setupUI() {
        addSubview(lineChartView)
        lineChartView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // mark: - lazy load
    lazy var lineChartView: LineChartView = {[weak self] in
        let view = LineChartView()
        view.backgroundColor = UIColor.clear
        view.delegate = self
        return view
    }()

}

extension JQLineChartView: ChartViewDelegate {
    
    // 点击选中的代理方法
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
    }
    
    // 没有选中时的代理方法
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
    }
    
    // 捏合放大或缩小图时的代理方法
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        
    }
    
    // 拖拽图表时的代理方法
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        
    }
 
}

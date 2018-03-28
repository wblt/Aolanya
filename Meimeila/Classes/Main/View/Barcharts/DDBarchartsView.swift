//
//  DDBarchartsView.swift
//  ChartDemo
//
//  Created by HJQ on 2017/9/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Charts


class DDBarchartsView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        
    }
    
    // MARK: - public methods
    // 提供方法获取左边的y坐标轴（主要用来绘制限制线）
    func getLeftYAxis() -> YAxis{
        return barChartView.leftAxis
    }
    
    // 获取右边的y轴
    func getRightYAxis() -> YAxis{
        return barChartView.leftAxis
    }
    
    // 获取x轴
    func getXAxis() -> XAxis {
        return barChartView.xAxis
    }
    
    // 设置x轴
    func setXAxis(style: DDXAxisStyle) {
        
        let xAxis = barChartView.xAxis
        // 设置X轴线宽
        xAxis.axisLineWidth = style.xaxisLineWidth
        // 设置字体大小
        xAxis.labelFont = style.xlabelFont
        // 坐标轴的颜色
        xAxis.axisLineColor = style.axisLineColor
        // X轴的显示位置，默认是显示在上面的
        xAxis.labelPosition = Charts.XAxis.LabelPosition.bottom
        // 不绘制网格线
        xAxis.drawGridLinesEnabled = style.xdrawGridLinesEnabled
        // 左边偏离Y轴
        xAxis.spaceMin = style.xspaceMin
        // 最大的刻度值
        xAxis.axisMaximum = style.xaxisMaximum
        xAxis.setLabelCount(style.xlabelCount, force: style.forceLabelsEnabled)
        //label文字颜色
        xAxis.labelTextColor = style.xlabelTextColor
        xAxis.valueFormatter = style.xvalueFormatter
    }
    
    func setLeftYAxis(style: DDLeftYAxisStyle) {
        
        //不绘制右边轴
        barChartView.rightAxis.enabled = style.isShowRightAxis
        
        // 获取左边Y轴
        let leftAxis = barChartView.leftAxis
        
        //坐标数值的位置
        leftAxis.labelPosition = Charts.YAxis.LabelPosition.outsideChart
        
        //不强制绘制制定数量的label
        leftAxis.forceLabelsEnabled = style.forceLabelsEnabled
        // 刻度的数目
        leftAxis.labelCount = style.yLabelCount
        //是否只显示最大值和最小值
        //leftAxis.showOnlyMinMaxEnabled = false
        //设置Y轴的最小值
        leftAxis.axisMinimum = style.yAxisMinimum
        //从0开始绘制
        leftAxis.drawZeroLineEnabled = style.drawZeroLineEnabled
        //设置Y轴的最大值
        leftAxis.axisMaximum = style.yAxisMaximum
        //是否将Y轴进行上下翻转
        leftAxis.inverted = style.inverted
        //Y轴线宽
        leftAxis.axisLineWidth = style.yAxisLineWidth
        //Y轴颜色
        leftAxis.axisLineColor = style.yAxisLineColor
        
        leftAxis.drawGridLinesEnabled = style.YdrawGridLines;
        
        //设置虚线样式的网格线(数组中至少有一个不为0)
        leftAxis.gridLineDashLengths = style.ygridLineDashLengths
        // 网格线的大小
        leftAxis.gridLineWidth = style.gridLineWidth
        //网格线颜色
        leftAxis.gridColor = style.ygridColor
        //开启抗锯齿
        leftAxis.gridAntialiasEnabled = style.yDrawLimitLinesBehindDataEnabled
    }
    
    func setRightYAxis(style: DDRightYAxisStyle) {
        
        // 左边Y轴
        //barChartView.leftAxis.enabled
        // 获取左边Y轴
        let rightAxis = barChartView.rightAxis
        
        //坐标数值的位置
        rightAxis.labelPosition = Charts.YAxis.LabelPosition.outsideChart
        
        //不强制绘制制定数量的label
        rightAxis.forceLabelsEnabled = style.forceLabelsEnabled
        // 刻度的数目
        rightAxis.labelCount = style.yLabelCount
        //设置Y轴的最小值
        rightAxis.axisMinimum = style.yAxisMinimum
        //从0开始绘制
        rightAxis.drawZeroLineEnabled = style.drawZeroLineEnabled
        //设置Y轴的最大值
        rightAxis.axisMaximum = style.yAxisMaximum
        //是否将Y轴进行上下翻转
        rightAxis.inverted = style.inverted
        //Y轴线宽
        rightAxis.axisLineWidth = style.yAxisLineWidth
        //Y轴颜色
        rightAxis.axisLineColor = style.yAxisLineColor
        
        rightAxis.drawGridLinesEnabled = style.YdrawGridLines
        
        //设置虚线样式的网格线(数组中至少有一个不为0)
        rightAxis.gridLineDashLengths = style.ygridLineDashLengths
        // 网格线的大小
        rightAxis.gridLineWidth = style.gridLineWidth
        //网格线颜色
        rightAxis.gridColor = style.ygridColor
        //开启抗锯齿
        rightAxis.gridAntialiasEnabled = style.yDrawLimitLinesBehindDataEnabled
    }
    
    
    // 获取到要显示的[BarChartDataEntry]
    func getYValues(startx: CGFloat, xVals_count: Int, space: CGFloat, yvalues:[Double]) -> [BarChartDataEntry]{
        // Y轴需要显示的数据
        var starX = startx
        var yValues = [BarChartDataEntry]()
        for i in 0..<xVals_count {
            let entry = BarChartDataEntry.init(x: Double(starX), y: yvalues[i])
            yValues.append(entry)
            starX += space
        }
        return yValues
    }
    
    // 柱形图显示相关
    func setupBarChartDataSet(style: DDBarChartDataSetStyle, colors: [UIColor], yValues: [BarChartDataEntry]) -> BarChartDataSet{
        let set = BarChartDataSet.init(values: yValues, label: nil)
        set.barBorderColor = style.barBorderColor
        set.barBorderWidth = style.barBorderWidth
        //是否在柱形图上面显示数值
        set.drawValuesEnabled = style.drawValuesEnabled
        //点击选中柱形图是否有高亮效果，（双击空白处取消选中）
        set.highlightEnabled = style.highlightEnabled
        set.highlightAlpha = style.highlightAlpha
        //设置柱形图颜色
        set.setColors(colors, alpha: style.setAlpha)
        return set
    }
    
    // 真实显示的数据
    func setupBarChartData(style: DDBarChartDataStyle, dataSets: [BarChartDataSet]) -> BarChartData{
        // 创建BarChartData对象, 此对象就是barChartView需要最终数据对象
        let data = BarChartData.init(dataSets: dataSets)
        // 不在bar上显示数值
        data.setDrawValues(style.isDrawValues)
        //文字字体
        data.setValueFont(style.valueFont)
        // //文字颜色
        data.setValueTextColor(style.valueTextColor)
        //自定义数据显示格式
        data.setValueFormatter(style.valueFormatter)
        return data
    }
    
    // 将数据展示出来
    func showBarchartsViewData(data: BarChartData) {
        // 设置数据和动画
        barChartView.data = data
        barChartView.data?.notifyDataChanged()
        barChartView.notifyDataSetChanged()
        barChartView.animate(yAxisDuration: 1.0, easingOption: ChartEasingOption.easeInBounce)
    }
    
    /// 限制线
    func getLimitLine(style: DDLimitLineStyle) ->  ChartLimitLine {
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
    
    
    // MARK: - private method
    private func setupUI() {
        addSubview(barChartView)
        barChartView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // 基本配置
    func setupConfig(config: DDBarchartsViewBaseConfig) {
        /// 基本样式设置
        // 隐藏描述文字不显示，就设为空字符串即可
        barChartView.chartDescription?.text = config.chartDescriptionText
        // 不显示图例说明
        barChartView.legend.enabled = config.legend
        
        // 没有数据显示的文字
        barChartView.noDataText = config.noDataText
        // 数值显示在柱形的上面还是下面
        barChartView.drawValueAboveBarEnabled = config.drawValueAboveBarEnabled
        // 点击柱形图是否显示箭头(没有这个属性了)
        //barChartView.drawHighlightArrowEnabled = false
        //是否绘制柱形的阴影背景
        barChartView.drawBarShadowEnabled = config.drawBarShadowEnabled
        
        /// 交互设置
        // 取消Y轴缩放
        barChartView.scaleYEnabled = config.scaleYEnabled
        // 取消双击缩放
        barChartView.doubleTapToZoomEnabled = config.doubleTapToZoomEnabled
        // 启用拖拽图表
        barChartView.dragDecelerationEnabled = config.dragDecelerationEnabled
        //拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        barChartView.dragDecelerationFrictionCoef = config.dragDecelerationFrictionCoef
    }
    
    
    // MARK: - lazy load
    lazy var barChartView: BarChartView = {
        let view = BarChartView.init()
        view.delegate = self
        return view
    }()
    

}


// MARK: - ChartViewDelegate
extension DDBarchartsView: ChartViewDelegate {
    
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

//
//  SmartmaskViewModel.swift
//  Mythsbears
//
//  Created by macos on 2017/10/25.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
import CryptoSwift

class SmartmaskViewModel{

    static let shared = SmartmaskViewModel()
    fileprivate init(){}
    
    var dataModerArr = [SmartmaskListModel]()
   
    var waterArr = [Double]()
    var oilArr = [Double]()
    var lastwaterArr = [Double]()
    var lastoilArr = [Double]()
    
    
    var min:UInt8 = 0
    var sec:UInt8 = 0
    var waterValue:UInt8 = 0
    var oilValue:UInt8 = 0
    var countdownFlag:UInt8 = 0
    var workStatus:UInt8 = 0
    var surplus:UInt8 = 0
    var timeString:String = "00:00"
    var isPush = false
    
    var waterValue_100: Int = 0
    var oilValue_100:Int = 0
    
    var beforeWater:Int = 0
    var beroreOil:Int = 0 
    
    func vm_read_analyzeData(fromData data:Data) -> Void {
        
        let byteArr = data.bytes
        print(byteArr);
        if byteArr.count > 0{
            let hour = byteArr[7];
            let min = byteArr[8];
            let sec = byteArr[9];
            
            let waterValue = byteArr[10];
            let oilValue = byteArr[11];
            
            let countdownFlag = byteArr[12];
            let workStatus = byteArr[13];
            ///剩余使用次数
            let surplus = byteArr[14];
            
            
            print("[","时 = ",hour);
            print("分 = ",min);
            print("秒 = ",sec);
            print("水分 = ",waterValue);
            print("油分 = ",oilValue);
            print("倒计时标志 = ",countdownFlag);
            print("工作状态 = ",workStatus);
            print("剩余次数 = ",surplus,"]");
            
            var minString = "\(min)"
            var secString = "\(sec)"
        
            if min < 10 {
                minString = "0" + minString;
            }
            
            if sec < 10 {
                secString = "0" + secString;
            }
        
            let timeString = minString + ":" + secString;
        
            self.min = min;
            self.sec = sec;
            self.waterValue = waterValue;
            self.oilValue = oilValue;
            self.countdownFlag = countdownFlag;
            self.workStatus = workStatus;
            self.surplus = surplus;
            self.timeString = timeString;
            
            
            let temp_water = Int(waterValue)
            self.waterValue_100 = temp_water
            
            let temp_oil = Int(oilValue)
            self.oilValue_100 = temp_oil;
        }
    }
    
    ///开始运行
    func vm_write_start(peripheral:CBPeripheral, characteristic:CBCharacteristic,sliderValu value:UInt8){
    
        if Int(workStatus) == 0{
            let data = Data.init(bytes:[
                0x01,0xfe,0x00,0x00,
                0x23,0x33,0x10,0x00,
                value,0x00,0x00,0x00,
                0x00,0x00,0x00,0x00])
            peripheral.writeValue(data, for: characteristic, type: CBCharacteristicWriteType.withResponse);
        }
    }
    
    
    ///强弱变化
    func vm_write_strong_weak(peripheral:CBPeripheral, characteristic:CBCharacteristic,sliderValu value:UInt8){
        
        if Int(workStatus) != 0{
            
            var statusValue:UInt8 = 0;
            
            if Int(workStatus) == 1{
                statusValue = 33;
            }
            else if Int(workStatus) == 2 {
                statusValue = 35;
            }
            else if Int(workStatus) == 3 {
                statusValue = 37;
            }

            let data = Data.init(bytes:[
                0x01,0xfe,0x00,0x00,
                0x23,statusValue,0x10,0x00,
                value,0x00,0x00,0x00,
                0x00,0x00,0x00,0x00])
            peripheral.writeValue(data, for: characteristic, type: CBCharacteristicWriteType.withResponse);
        }
    }
    
    ///滑条值改变
    func vm_write_sliderValueChange(sliderValue value:UInt8) ->Data{
        
        let fudu = value;
        
        var statue = UInt8(33);
        if self.workStatus == 2 {
            statue = UInt8(35);
        }
        
        if self.workStatus == 3 {
            statue = UInt8(37);
        }
        
        let data = Data(bytes: [
            0x01,0xfe,0x00,0x00,
            0x23,statue,0x10,0x00,
            fudu,0x00,0x00,0x00,
            0x00,0x00,0x00,0x00])
        
        return data;
    }
    
    ///水，油高度图片剪裁
    func vm_setWaterAndOilValueImage(water waterImageView:UIImageView,oil oilImageView:UIImageView,waterProgress:UIImageView,oilProgress:UIImageView){
        
        imageSet(value: waterValue_100, valueImageView: waterImageView, progressImageView: waterProgress, imageName: "face_water");
        
        imageSet(value: oilValue_100, valueImageView: oilImageView, progressImageView: oilProgress, imageName: "face_oil");
    }
    
    fileprivate func imageSet(value:Int,valueImageView:UIImageView,progressImageView:UIImageView,imageName:String) {
        
        print(valueImageView.frame);
        
        let image = UIImage.init(named: imageName);
        let image_with = image?.size.width;
        let image_heigh = image?.size.height;
        
        let shuifenClipY = CGFloat(100 - CGFloat(value))
        
        let percent = shuifenClipY * 0.01;
        let clipValue = percent * image_heigh!*2;
        
        let newImage = UIImage.clipImage(with: image!, in: CGRect(x: 0, y:clipValue, width: image_with!*2, height:image_heigh!*2))
        
        valueImageView.image = newImage
        valueImageView.frame = CGRect(x: progressImageView.frame.origin.x + 0, y: progressImageView.frame.maxY - (progressImageView.frame.size.height*(1 - percent)), width: 20, height:progressImageView.frame.size.height*(1 - percent))
    
        print(valueImageView.frame);
    
    }
    
    
    ///本次数据采集
    func vm_dataCollection(water waterValue:Int ,oil oilValue:Int){
        
        
        
    }
    
}


//MARK:网络请求
extension SmartmaskViewModel{
    ///获取面膜数据
    func getMaskListData(suceeds:@escaping ()->(),error:@escaping ()->()) {
        let r = MaskAPI.getMaskDataList
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
         
            let json = JSON.init(responds);
            
            print(json);
            
            let dataArr = json["data"].arrayValue
            
            
            self?.dataModerArr.removeAll();
            self?.waterArr.removeAll();
            self?.oilArr.removeAll();
            self?.lastoilArr.removeAll();
            self?.lastwaterArr.removeAll();

            dataArr.forEach({(json) in
                let model = SmartmaskListModel.init(from: json)
                self?.dataModerArr.append(model);
        
                self?.waterArr.append(model.water);
                self?.oilArr.append(model.oily);
                self?.lastwaterArr.append(model.lastwater);
                self?.lastoilArr.append(model.lastoily);
                
            })
            
            
            suceeds()
            
        }, requestError: { (responds, errorModel) in
            
            BFunction.shared.showErrorMessage(errorModel.message);
            
            error();
            
        }) {(error) in
           BFunction.shared.showErrorMessage(error.localizedDescription);
        }
    }
    
    ///上传本次测试数据
    func  maskDataUpLoad(water:String,oily:String,succeeds:@escaping (_ code:String)->(),error:@escaping ()->()) {
        
        let r = MaskAPI.addMaskData(water: water, oily: oily)
        
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            
            let json = JSON.init(responds);

            let code  = json["code"].stringValue;
            
            succeeds(code);
            
            }, requestError: { (responds, errorModel) in
                BFunction.shared.showErrorMessage(errorModel.message);
                error()
        }) {(error) in
            BFunction.shared.showErrorMessage(error.localizedDescription);
        }
    }
    
}



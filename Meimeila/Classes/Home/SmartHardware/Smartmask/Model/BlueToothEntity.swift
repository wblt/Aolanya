//
//  BlueToothEntity.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/13.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
// import CoreBluetooth

class BlueToothEntity {
    var peripheral: CBPeripheral?
    var RSSI: NSNumber?
    var advertisementData: Dictionary<String, Any>?
}

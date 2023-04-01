//
//  BluetoothDeviceInfo.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/26.
//

import Foundation
import IOBluetooth

class BluetoothDeviceInfo: ObservableObject {
    
    @Published var isConnecting: Bool
    @Published var battery: Int
    
    let device: IOBluetoothDevice
    var deviceType: DeviceType
    
    init(device: IOBluetoothDevice,deviceType: DeviceType, isConnecting: Bool, battery: Int) {
        self.device = device
        self.deviceType = deviceType
        self.isConnecting = isConnecting
        self.battery = battery
    }
}

//
//  PairedDevicesManager.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/26.
//

import SwiftUI
import IOBluetooth

class PairedDevicesManager: ObservableObject {
    
    @Published var pairedDevices: [IOBluetoothDevice] = []

    func getPairedDevices() {
        if let devices = IOBluetoothDevice.pairedDevices() as? [IOBluetoothDevice] {
            pairedDevices = devices
        } else {
            pairedDevices = []
        }
    }
}


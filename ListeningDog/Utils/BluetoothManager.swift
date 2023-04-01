//
//  BluetoothManager.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/25.
//

import CoreBluetooth
import IOBluetooth
import Combine

class BluetoothManager: NSObject, ObservableObject {
    static let shared = BluetoothManager()
    
    private var centralManager: CBCentralManager!
    private var discoveredDevices: [CBPeripheral] = []
    @Published var isBluetoothOn: Bool = false
    
    private override init() {
        
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScanning() {
        
        guard centralManager.state == .poweredOn else {
            print("Bluetooth is not powered on.")
            return
        }
        discoveredDevices = []
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func stopScanning() {
        
        centralManager.stopScan()
    }
}

extension BluetoothManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state {
        case .poweredOn:
            print("Bluetooth is powered on.")
            isBluetoothOn = true
        case .poweredOff:
            print("Bluetooth is powered off.")
            isBluetoothOn = false
        case .resetting:
            print("Bluetooth is resetting.")
        case .unauthorized:
            print("Bluetooth is unauthorized.")
        case .unsupported:
            print("Bluetooth is not supported.")
        case .unknown:
            print("Bluetooth state is unknown.")
        @unknown default:
            print("Unknown Bluetooth state.")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        
        guard let name = peripheral.name else {
            return
        }
        
        if !discoveredDevices.contains(peripheral) {
            discoveredDevices.append(peripheral)
            print("Discovered device: \(name)")
        }
    }
}

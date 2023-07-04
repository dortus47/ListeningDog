//
//  BluetoothManager.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/25.
//

import CoreBluetooth
import IOBluetooth
import Combine


/**
 - Note: BluetoothManager는 싱글톤 인스턴스로서, 앱 내에서 중앙 블루투스 관리자로 작동합니다.
 *
 */
class BluetoothManager: NSObject, ObservableObject {
    
    // MARK: - Properties -
    
    
    static let shared = BluetoothManager()
    
    private var centralManager: CBCentralManager!
    private var discoveredDevices: [CBPeripheral] = []
    @Published var isBluetoothOn: Bool = false
    
    // MARK: - Life cycle -
    
    
    private override init() {
        
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    // MARK: - public func -
    
    
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

// MARK: - CBCentralManagerDelegate -


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
    
    // 기기가 검색될 때마다 호출되는 메서드입니다.
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        
        guard let name = peripheral.name else { return }
        
        if !discoveredDevices.contains(peripheral) {
            discoveredDevices.append(peripheral)
            print("Discovered device: \(name)")
        }
    }
}

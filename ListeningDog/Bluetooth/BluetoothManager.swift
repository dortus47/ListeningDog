//
//  BluetoothManager.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/25.
//

import CoreBluetooth
import Foundation
import IOBluetooth

class BluetoothManager: NSObject, CBCentralManagerDelegate {
    static let shared = BluetoothManager()
    
    private var centralManager: CBCentralManager!
    private(set) var discoveredDevices: [CBPeripheral] = []
    
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
    
    func getPairedDevices() {
        let pairedDevices = IOBluetoothDevice.pairedDevices() as? [IOBluetoothDevice]
        
        for device in pairedDevices ?? [] {
            print("Name: \(device.name ?? "Unknown"), Address: \(device.addressString)")
        }
    }
    
    func getBatteryLevel() -> Double? {
        guard let powerSources = IOPSCopyPowerSourcesInfo()?.takeRetainedValue() else {
            return nil
        }

        guard let powerSourceArray = IOPSCopyPowerSourcesList(powerSources)?.takeRetainedValue() as? NSArray else {
            return nil
        }

        for powerSource in powerSourceArray {
            if let powerSourceDict = IOPSGetPowerSourceDescription(powerSources, powerSource as CFTypeRef)?.takeUnretainedValue() as? NSDictionary {
                if let currentCapacity = powerSourceDict[kIOPSCurrentCapacityKey] as? Double,
                   let maxCapacity = powerSourceDict[kIOPSMaxCapacityKey] as? Double {
                    let batteryLevel = (currentCapacity / maxCapacity) * 100
                    return batteryLevel
                }
            }
        }
        return nil
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Bluetooth is powered on.")
        case .poweredOff:
            print("Bluetooth is powered off.")
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

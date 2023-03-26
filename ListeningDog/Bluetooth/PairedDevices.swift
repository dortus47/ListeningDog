//
//  PairedDevicesManager.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/26.
//

import SwiftUI
import IOBluetooth
import Combine

enum DeviceType {
    case magicKeyboard
    case magicMouse
    case magicTrackpad
    case airPods
    case thirdParty
    
    static let allAppleDevices: [DeviceType] = [.magicKeyboard, .magicMouse, .magicTrackpad, .airPods]
}

class PairedDevices: ObservableObject {
    
    @Published var pairedDevices: [BluetoothDeviceInfo] = []
    private var timerCancellable: AnyCancellable?
    
    init() {
        timerCancellable = Timer.publish(every: 3, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.getPairedDevices()
            }
        
        getPairedDevices()
    }
    
    func getPairedDevices() {
        var devicesList: [BluetoothDeviceInfo] = []
        
        if let devices = IOBluetoothDevice.pairedDevices() as? [IOBluetoothDevice] {
            for device in devices {
                
                let isConnected = device.isConnected()
                let deviceType: DeviceType = isAppleDevice(device: device) ? .airPods : .thirdParty
                let batteryLevel = getBatteryLevel(for: device) ?? 0
                
                print("BluetoothDeviceInfo \(device.name) \(isConnected) \(isAirPodsDevice(device))")
                let bluetoothDeviceInfo = BluetoothDeviceInfo(device: device, deviceType: deviceType, isConnecting: isConnected, battery: batteryLevel)
                devicesList.append(bluetoothDeviceInfo)
            }
        }
        pairedDevices = devicesList
    }
    
    private func isAppleDevice(device: IOBluetoothDevice) -> Bool {
        if let deviceName = device.name {
            return deviceName.contains("Magic")
        } else {
            return false
        }
    }
    
    private func isAirPodsDevice(_ device: IOBluetoothDevice) -> Bool {
        let deviceName = device.name ?? ""
        
//        if deviceName.contains("AirPods") || deviceName.contains("AirPod") {
//            return true
//        }
        
        let serviceUUIDs = device.services?.compactMap { ($0 as AnyObject).uuidString }
        if let uuids = serviceUUIDs, uuids.contains("0x1801") || uuids.contains("0x180f") {
            return true
        }
        
        return false
    }

    
    func getBatteryLevel(for device: IOBluetoothDevice) -> Int? {
        var rssi = device.rawRSSI()
        let value = NSValue(bytes: &rssi, objCType: "{BluetoothHCIRSSIValue=i8}")
        let dict = value.dictionaryWithValues(forKeys: ["BatteryPercent"])
        if let batteryLevel = dict["BatteryPercent"] as? Int {
            return batteryLevel
        } else if let output = executeIORegCommand(), let batteryLevel = parseBatteryInfo(from: output, for: device) {
            return batteryLevel
        } else {
            var rssi = BluetoothHCIRSSIValue(0)
            let value = NSValue(bytes: &rssi, objCType: "{BluetoothHCIRSSIValue=i8}")
            let dict = value.dictionaryWithValues(forKeys: ["BatteryPercent"])
            if let batteryLevel = dict["BatteryPercent"] as? Int {
                return batteryLevel
            } else {
                return nil
            }
        }
    }
    
    private func executeIORegCommand() -> String? {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/sbin/ioreg")
        task.arguments = ["-r", "-l", "-n", "AppleHSBluetoothDevice"]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        
        do {
            try task.run()
            let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
            let outputString = String(data: outputData, encoding: .utf8)
            return outputString
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func parseBatteryInfo(from output: String?, for device: IOBluetoothDevice) -> Int? {
        guard let output = output else { return nil }
        let lines = output.components(separatedBy: .newlines)
        var foundDevice = false
        
        for line in lines {
            if line.contains(device.addressString) {
                foundDevice = true
            }
            if foundDevice, let batteryPercentage = parseBatteryPercentage(from: line) {
                return batteryPercentage
            }
        }
        
        return nil
    }
    
    private func parseBatteryPercentage(from line: String) -> Int? {
        if line.contains("BatteryPercent") {
            let components = line.components(separatedBy: "=")
            if let percentageString = components.last?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
                return Int(percentageString)
            }
        }
        return nil
    }
}


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

class PairedDevicesObject: ObservableObject {
    
    @Published var pairedDevices: [BluetoothDeviceInfoObject] = []
    private var timerCancellable: AnyCancellable?
    
    init() {
        
    // FIXME: 해당 부분으로 인해 열리고 닫힐 때마다 렉이 발생. 추후 수정.
//        timerCancellable = Timer.publish(every: 30, on: .main, in: .common)
//            .autoconnect()
//            .sink { [weak self] _ in
//                self?.getPairedDevices()
//            }
        
        getPairedDevices()
    }
    
    func getPairedDevices() {
        var devicesList: [BluetoothDeviceInfoObject] = []
        
        if let devices = IOBluetoothDevice.pairedDevices() as? [IOBluetoothDevice] {
            for device in devices {
                
                let isConnected = device.isConnected()
                let deviceType: DeviceType = isAppleDevice(device: device) ? .airPods : .thirdParty
                let batteryLevel = getBatteryLevel(for: device) ?? 0
                
                let bluetoothDeviceInfo = BluetoothDeviceInfoObject(device: device, deviceType: deviceType, isConnecting: isConnected, battery: batteryLevel)
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

//PairedDevicesObject 내에서 Timer를 사용하여 주기적으로 getPairedDevices 함수를 호출하고 있네요. 이러한 방식은 일반적으로 사용되는 패턴이지만, 함수 내에서 많은 작업을 수행하거나 호출 빈도가 너무 높을 경우 앱의 성능에 영향을 미칠 수 있습니다.
//
//MenuBarExtraView가 열리고 닫힐 때마다 렉이 생기는 문제는 아마도 MenuBarExtraView가 렌더링되거나 업데이트될 때마다 getPairedDevices 함수가 호출되기 때문일 가능성이 높습니다. MenuBarExtraView의 렌더링 또는 업데이트가 발생하면 PairedDevicesObject의 ObservableObject 속성인 pairedDevices가 변경되므로, 이를 사용하는 모든 뷰가 렌더링되거나 업데이트됩니다.
//
//이 문제를 해결하려면 getPairedDevices 함수가 너무 자주 호출되지 않도록 조절하거나, 함수가 호출되어도 뷰의 업데이트를 유발하지 않도록 수정해야 할 수 있습니다.
//
//다음은 이러한 문제를 해결하는 몇 가지 방법입니다:
//
//타이머의 간격을 늘립니다. 현재 타이머는 매 30초마다 getPairedDevices를 호출하고 있습니다. 이 간격이 너무 짧으면 앱의 성능에 영향을 미칠 수 있습니다. 이 간격을 늘리면 getPairedDevices 함수 호출 빈도를 줄일 수 있습니다.
//
//뷰의 업데이트를 최적화합니다. getPairedDevices 함수가 호출되면 pairedDevices가 변경되고, 이로 인해 뷰가 업데이트됩니다. 이 때, 뷰의 전체가 아니라 변경된 부분만 업데이트되도록 최적화하면 성능을 향상시킬 수 있습니다.
//
//데이터 획득을 비동기로 처리합니다. getPairedDevices 함수에서 IOBluetoothDevice.pairedDevices() 함수를 호출하여 데이터를 획득하고 있는데, 이 함수가 많은 시간을 소요하거나, 블로킹되는 경우 앱의 성능에 영향을 미칠 수 있습니다. 가능하다면 이 작업을 비동기로 처리하거나 백그라운드 스레드에서 실행하도록 고려해 볼 수 있습니다.
//
//MenuBarExtraView의 상태 변경을 최소화합니다. MenuBarExtraView가 열리고 닫힐 때마다 렉이 생기는 문제를 해결하기 위해, 해당 뷰가 불필요하게 상태 변경이 일어나지 않도록 코드를 최적화하는 것도 방법입니다. 예를 들어, 뷰가 닫힐 때는 데이터를 업데이트하지 않도록 조건을 추가하거나, 뷰가 열릴 때만 데이터를 업데이트하도록 할 수 있습니다.

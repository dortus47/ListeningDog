//
//  BatteryManager.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/25.
//

import Foundation
import Combine
import IOKit.ps
import IOKit.pwr_mgt


class BatteryManager: ObservableObject {

    @Published var batteryLevel: Int?
    @Published var isCharging: Bool = false // 추가된 변수

    private var timer: AnyCancellable?

    init() {
        timer = Timer.publish(every: 3, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateBatteryLevel()
            }
        updateBatteryLevel()
    }

    private func updateBatteryLevel() {
        
        guard let powerSources = IOPSCopyPowerSourcesInfo()?.takeRetainedValue() else {
            batteryLevel = nil
            return
        }

        guard let powerSourceArray = IOPSCopyPowerSourcesList(powerSources)?.takeRetainedValue() as? NSArray else {
            batteryLevel = nil
            return
        }

        for powerSource in powerSourceArray {
            
            if let powerSourceDict = IOPSGetPowerSourceDescription(powerSources, powerSource as CFTypeRef)?.takeUnretainedValue() as? NSDictionary {
                
                if let currentCapacity = powerSourceDict[kIOPSCurrentCapacityKey] as? Double,
                   let maxCapacity = powerSourceDict[kIOPSMaxCapacityKey] as? Double {
                    let newBatteryLevel = (currentCapacity / maxCapacity) * 100
                    batteryLevel = Int(newBatteryLevel)

                    if let powerSourceState = powerSourceDict[kIOPSPowerSourceStateKey] as? String {
                        print("Power source state: \(powerSourceState)")
                        isCharging = powerSourceState == kIOPSACPowerValue
                    }

                    return
                }
            }
        }

        batteryLevel = nil
        isCharging = false
    }
}

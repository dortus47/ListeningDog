//
//  GlobalFunctions.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/27.
//

import Foundation


func batteryImageName(batteryLevel: Int? = 0, isCharging: Bool = false) -> String {
    
    guard let batteryLevel else {
        return "battery.0"
    }
    
    if batteryLevel >= 100 {
        return "battery.100"
    } else if batteryLevel >= 75 {
        return "battery.75"
    } else if batteryLevel >= 50 {
        return "battery.50"
    } else if batteryLevel >= 25 {
        return "battery.25"
    } else {
        return "battery.0"
    }
}

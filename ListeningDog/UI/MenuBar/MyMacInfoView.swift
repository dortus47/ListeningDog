//
//  MyMacInfoView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/26.
//

import SwiftUI

struct MyMacInfoView: View {
    
    @ObservedObject var batteryManager = BatteryManager()
    
    private var batteryImageName: String {
        print("hhh \(batteryManager.batteryLevel) \(batteryManager.isCharging)")
        guard let battery = batteryManager.batteryLevel else {
            return "battery.0"
        }
        
        if battery >= 100 {
            return"battery.100"
        } else if battery >= 75 {
            return "battery.75"
        } else if battery >= 50 {
            return "battery.50"
        } else if battery >= 25 {
            return "battery.25"
        } else {
            return "battery.0"
        }
    }
    
    var body: some View {
        
        Section(header: SectionHeaderView(title: "나의 Mac"), footer: Divider()) {
            HStack(spacing: 3) {
                
                Text(batteryManager.batteryLevel != nil ? "\(batteryManager.batteryLevel!)%" : "???")
                Image(systemName: batteryImageName)
                    .overlay(
                        batteryManager.isCharging ?
                        Image(systemName: "bolt")
                        : nil
                    )
            }
        }
    }
}

struct MyMacInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyMacInfoView()
    }
}

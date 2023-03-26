//
//  MyMacInfoView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/26.
//

import SwiftUI

struct MyMacInfoView: View {
    
    @ObservedObject var myMacManager = MyMacManager()
    
    private var batteryImageName: String {
        
        guard let battery = myMacManager.batteryLevel else {
            return "battery.0"
        }
        print("hhh \(battery) \(myMacManager.isCharging)")
        
        if battery >= 100 {
            return myMacManager.isCharging ? "battery.100.bolt" : "battery.100"
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
                
                Image(systemName: "laptopcomputer")
                
                Spacer()
                
                Text(myMacManager.batteryLevel != nil ? "\(myMacManager.batteryLevel!)%" : "???")
                Image(systemName: batteryImageName)
                    .overlay(
                        myMacManager.isCharging && myMacManager.batteryLevel == 100 ?
                        nil
                        : Image(systemName: "bolt")
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

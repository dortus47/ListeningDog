//
//  MyMacInfoView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/26.
//

import SwiftUI

struct MyMacInfoView: View {
    
    @ObservedObject var batteryManager = BatteryManager()
    
    var body: some View {
        HStack(spacing: 3) {
            
            Text(batteryManager.batteryLevel != nil ? "\(batteryManager.batteryLevel!)%" : "???")
            Image(systemName: "battery.100")
        }
    }
}

struct MyMacInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyMacInfoView()
    }
}

//
//  DeviceInfoView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/26.
//

import SwiftUI
import IOBluetooth

struct DeviceInfoView: View {
    
    @Binding var bluetoothDeviceInfo: BluetoothDeviceInfo
    @State private var isHovered = false
    
    var body: some View {
        
        HStack(spacing: 7) {
            
            Image(systemName: bluetoothDeviceInfo.isConnecting ? "personalhotspot.circle.fill" : "personalhotspot.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)
                .foregroundColor(bluetoothDeviceInfo.isConnecting ? Color.accentColor : Color.primary)
            
            Text(bluetoothDeviceInfo.device.name)
            Spacer()
            
            if bluetoothDeviceInfo.isConnecting {
                Text("\(bluetoothDeviceInfo.battery)%")
                Image(systemName: batteryImageName(batteryLevel: bluetoothDeviceInfo.battery, isCharging: false))
            }
        }
        .frame(height: 35)
        .padding(.horizontal, 5)
        .background(isHovered ? Color.gray.opacity(0.2) : Color.clear)
        .cornerRadius(8)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

struct DeviceInfoView_Previews: PreviewProvider {
    
    @State static var bluetoothDeviceInfo = BluetoothDeviceInfo(device: IOBluetoothDevice(), deviceType: .airPods, isConnecting: true, battery: 78)
    
    static var previews: some View {
        DeviceInfoView(bluetoothDeviceInfo: $bluetoothDeviceInfo)
    }
}

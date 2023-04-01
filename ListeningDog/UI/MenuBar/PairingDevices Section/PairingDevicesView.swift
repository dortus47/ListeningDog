//
//  PairingDevicesView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/25.
//

import SwiftUI

struct PairingDevicesView: View {
    @EnvironmentObject var pairedDevicesObject: PairedDevicesObject
    
    var body: some View {
        
        Section(header: SectionHeaderView(title: "페어링 기기"), footer: Divider()) {
            ForEach(pairedDevicesObject.pairedDevices.sorted(by: { $0.isConnecting && !$1.isConnecting }), id: \.device.addressString) { bluetoothDeviceInfo in
                
                let infoBinding = Binding<BluetoothDeviceInfoObject>(get: {
                    return bluetoothDeviceInfo
                }, set: {_ in
                })
                
                DeviceInfoView(bleDeviceInfoObject: infoBinding)
            }
        }
    }
    
    struct DeviceInfoView: View {
        
        @Binding var bleDeviceInfoObject: BluetoothDeviceInfoObject
        @State private var isHovered = false
        
        var body: some View {
            
            Button {
                
            } label: {
                HStack(spacing: 7) {
                    
                    Image(systemName: bleDeviceInfoObject.isConnecting ? "personalhotspot.circle.fill" : "personalhotspot.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                        .foregroundColor(bleDeviceInfoObject.isConnecting ? Color.accentColor : Color.primary)
                    
                    Text(bleDeviceInfoObject.device.name)
                    Spacer()
                    
                    if bleDeviceInfoObject.isConnecting {
                        Text("\(bleDeviceInfoObject.battery)%")
                        Image(systemName: batteryImageName(batteryLevel: bleDeviceInfoObject.battery, isCharging: false))
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
            .buttonStyle(.plain)
        }
    }
}

struct PairingDevicesView_Previews: PreviewProvider {
    static var previews: some View {
        PairingDevicesView()
            .environmentObject(PairedDevicesObject())
    }
}

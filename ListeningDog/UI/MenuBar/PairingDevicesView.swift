//
//  PairingDevicesView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/25.
//

import SwiftUI

struct PairingDevicesView: View {
    @EnvironmentObject var pairedDevices: PairedDevices
    
    var body: some View {
        
        Section(header: SectionHeaderView(title: "페어링 기기"), footer: Divider()) {
            ForEach(pairedDevices.pairedDevices.sorted(by: { $0.isConnecting && !$1.isConnecting }), id: \.device.addressString) { bluetoothDeviceInfo in
                
                let infoBinding = Binding<BluetoothDeviceInfo>(get: {
                    return bluetoothDeviceInfo
                }, set: {_ in
                })
                
                DeviceInfoView(bluetoothDeviceInfo: infoBinding)
            }
        }
    }
}


struct PairingDevicesView_Previews: PreviewProvider {
    static var previews: some View {
        PairingDevicesView()
            .environmentObject(PairedDevices())
    }
}

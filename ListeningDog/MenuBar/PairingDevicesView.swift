//
//  PairingDevicesView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/25.
//

import SwiftUI

struct PairingDevicesView: View {
    @EnvironmentObject var pairedDevicesManager: PairedDevicesManager
    
    var body: some View {
        
        
        
        Section(header: SectionHeader(title: "페어링 기기"), footer: Divider()) {
            ForEach(pairedDevicesManager.pairedDevices, id: \.addressString) { device in
                Text("\(device.name ?? "Unknown")")
            }
        }.onAppear {
            pairedDevicesManager.getPairedDevices()
        }
    }
    
    struct SectionHeader: View {
        let title: String

        var body: some View {
            Text(title)
                .padding(.top)
        }
    }
}


struct PairingDevicesView_Previews: PreviewProvider {
    static var previews: some View {
        PairingDevicesView()
            .environmentObject(PairedDevicesManager())
    }
}

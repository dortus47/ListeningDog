//
//  BluetoothInfoView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/31.
//

import SwiftUI

struct BluetoothInfoView: View {
    
    @ObservedObject private var bluetoothManager = BluetoothManager.shared
    
    var body: some View {
        Section(header: SectionHeaderView(title: "Bluetooth"), footer: Divider()) {
            Toggle("Bluetooth", isOn: $bluetoothManager.isBluetoothOn)
                .toggleStyle(SwitchToggleStyle())
        }
    }
}

struct BluetoothInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothInfoView()
    }
}

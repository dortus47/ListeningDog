//
//  MenuBarExtraView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/25.
//

import SwiftUI

struct MenuBarExtraView: View {
    
    
    
    @Binding var currentNumber: String
    @State private var BluetoothIsOn: Bool = false
    
    var body: some View {
        
        List {

            Text("ListeningDog")
                .fontWeight(.bold)

            MyMacInfoView()

            PairingDevicesView()

            Section(header: SectionHeaderView(title: "Bluetooth"), footer: Divider()) {
                Toggle("Bluetooth", isOn: $BluetoothIsOn)
                    .toggleStyle(SwitchToggleStyle())
            }

            Section(content: {
                Button("One") {
                    currentNumber = "1"
                    BluetoothManager.shared.startScanning()
                }
                Button("Two") {
                    currentNumber = "2"
                    BluetoothManager.shared.stopScanning()
                }
                Button("Three") {
                    currentNumber = "3"
                }

                Button("Quit") {
                    NSApp.terminate(nil)
                }
            })
        }
        .listStyle(.plain)
    }
    
    private func matchingDeviceImageName(name: String?) -> String {
        
        
        
        return "default"
    }
}

struct MenuBarExtraView_Previews: PreviewProvider {
    @State static var currentNumber: String = "1"
    
    static var previews: some View {
        MenuBarExtraView(currentNumber: $currentNumber)
            .environmentObject(PairedDevices())
    }
}


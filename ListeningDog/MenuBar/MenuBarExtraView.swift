//
//  MenuBarExtraView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/25.
//

import SwiftUI

struct MenuBarExtraView: View {
    
    @ObservedObject var batteryManager = BatteryManager()
    
    @Binding var currentNumber: String
    @State private var BluetoothIsOn: Bool = false
    
    var body: some View {
        List {
            
            Image("girl")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Section(header: SectionHeader(title: "Bluetooth"), footer: Divider()) {
                Toggle("Bluetooth", isOn: $BluetoothIsOn)
                    .toggleStyle(SwitchToggleStyle())
                
                HStack {
                    
                    Image(systemName: "battery.100")
                    
                    Text(batteryManager.batteryLevel != nil ? "\(batteryManager.batteryLevel!)" : "???")
                }
            }
            
            
            PairingDevicesView()
            
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
        }.padding(.all)
            .listStyle(.plain)
    }
    
    struct SectionHeader: View {
        let title: String

        var body: some View {
            Text(title)
//                .padding(.top)
        }
    }
}

struct MenuBarExtraView_Previews: PreviewProvider {
    @State static var currentNumber: String = "1"
    
    static var previews: some View {
        MenuBarExtraView(currentNumber: $currentNumber)
            .environmentObject(PairedDevicesManager())
    }
}


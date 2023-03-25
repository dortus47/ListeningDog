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
            
            Section(content: {
                Toggle("Bluetooth", isOn: $BluetoothIsOn)
                    .toggleStyle(SwitchToggleStyle())
                
                HStack {
                    
                    Image(systemName: "battery.100")
                    
                    Text(batteryManager.batteryLevel != nil ? "\(batteryManager.batteryLevel!)" : "???")
                }
            })
            
            Divider()
            
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
                    BluetoothManager.shared.getPairedDevices()
                }
                
                Button("Quit") {
                        NSApp.terminate(nil)
                    }
            })

        }.padding()
    }
}

struct MenuBarExtraView_Previews: PreviewProvider {
    @State static var currentNumber: String = "1"

    static var previews: some View {
        MenuBarExtraView(currentNumber: $currentNumber)
    }
}


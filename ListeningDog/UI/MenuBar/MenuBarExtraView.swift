//
//  MenuBarExtraView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/25.
//

import SwiftUI
import Combine

struct MenuBarExtraView: View {
    
    @State private var BluetoothIsOn: Bool = false
    @State private var isHovered = false
    
    var body: some View {
        
        List {

            Text("ListeningDog")
                .fontWeight(.bold)
                .padding(.top, 5)

            MyMacInfoView()

            PairingDevicesView()
            
            HStack(spacing: 7) {
                
                Button("Preferences...") {
                    NSApp.terminate(nil)
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
            .frame(height: 25)
            .padding(.horizontal, 5)
            .background(isHovered ? Color.gray.opacity(0.2) : Color.clear)
            .cornerRadius(8)
            .onHover { hovering in
                isHovered = hovering
            }
            
            HStack(spacing: 7) {
                
                Button("Quit") {
                    NSApp.terminate(nil)
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
            .frame(height: 25)
            .padding(.horizontal, 5)
            .background(isHovered ? Color.gray.opacity(0.2) : Color.clear)
            .cornerRadius(8)
            .onHover { hovering in
                isHovered = hovering
            }
            
            Spacer()
                .frame(height: 5)
            

        }
        .frame(minHeight: 450)
        .listStyle(.plain)
    }
    
    private func matchingDeviceImageName(name: String?) -> String {
        
        
        
        return "default"
    }
}

struct MenuBarExtraView_Previews: PreviewProvider {
    
    static var previews: some View {
        MenuBarExtraView()
            .environmentObject(PairedDevicesObject())
    }
}


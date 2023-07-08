//
//  MenuBarExtraView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/25.
//

import SwiftUI
import Combine


struct MenuBarExtraView: View {
    
    @EnvironmentObject var appDelegate: AppDelegate
    
    @State private var BluetoothIsOn: Bool = false
    @State private var isHovered = false
    
    var body: some View {
        
        List {
            
            Text("ListeningDog")
                .fontWeight(.bold)
                .padding(.top, 5)
            
            MyMacInfoView()
            
            PairingDevicesView()
            
            PreferencesView()
            
            QuitView()
            
            Spacer()
                .frame(height: 5)
        }
        .frame(minHeight: 450)
        .listStyle(.plain)
    }
    
    struct PreferencesView: View {
        
        @EnvironmentObject var appDelegate: AppDelegate
        @EnvironmentObject var listengDogAppState: ListengDogAppState
        @State private var isHovered = false
        
        var body: some View {
            
            Button {
                
                listengDogAppState.isMenuPresented.toggle()
                appDelegate.showMainWindow()
            } label: {
                HStack {
                    Text("Preferences...")
                    Spacer()
                }
                .frame(height: 30)
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
    
    struct QuitView: View {
        
        @State private var isHovered = false
        
        var body: some View {
            
            Button {
                NSApp.terminate(nil)
            } label: {
                HStack(spacing: 7) {
                    
                    Text("Quit")
                    
                    Spacer()
                }
                .frame(height: 30)
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

struct MenuBarExtraView_Previews: PreviewProvider {
    
    static var previews: some View {
        MenuBarExtraView()
            .environmentObject(PairedDevicesObject())
    }
}


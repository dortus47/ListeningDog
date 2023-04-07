//
//  MyMacInfoView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/26.
//

import SwiftUI
import AppKit


struct MyMacInfoView: View {
    
    @ObservedObject var myMacManager = MyMacManager()
    
    var batteryLevel: Int? {
        return myMacManager.batteryLevel
    }
    
    var isCharging: Bool {
        return myMacManager.isCharging
    }
    
    @State private var isHovered = false

    var body: some View {
        
        Section(header: SectionHeaderView(title: "나의 Mac"), footer: Divider()) {
            
            Button {
                openAboutThisMac()
//                NSApp.orderFrontStandardAboutPanel(nil)
            } label: {
                HStack(spacing: 7) {
                    
                    Image(systemName: "laptopcomputer")
                    Text(myMacManager.macModel)
                    
                    Spacer()
                    
                    Text(batteryLevel != nil ? "\(batteryLevel!)%" : "???")
                    Image(systemName: batteryImageName(batteryLevel: batteryLevel, isCharging: isCharging))
                        .overlay(
                            isCharging ? Image(systemName: "bolt") : nil
                        )
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
    
    private func openAboutThisMac() {
        
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = ["open", "/System/Library/CoreServices/Applications/About This Mac.app"]
        task.launch()
    }
}

struct MyMacInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyMacInfoView()
    }
}

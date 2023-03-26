//
//  MyMacInfoView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/26.
//

import SwiftUI

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
            HStack(spacing: 3) {
                
                Image(systemName: "laptopcomputer")
                Text(myMacManager.macModel)
                
                Spacer()
                
                Text(batteryLevel != nil ? "\(batteryLevel!)%" : "???")
                Image(systemName: batteryImageName(batteryLevel: batteryLevel, isCharging: isCharging))
                    .overlay(
                        isCharging && batteryLevel == 100 ?
                        nil
                        : Image(systemName: "bolt")
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
    }
}

struct MyMacInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyMacInfoView()
    }
}

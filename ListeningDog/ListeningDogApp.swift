//
//  ListeningDogApp.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/22.
//

import SwiftUI
import Cocoa


@main
struct ListeningDogApp: App {

    var body: some Scene {
        
        MenuBarExtra("ListeningDogApp", image: "dog") {
            let pairedDevicesObject = PairedDevicesObject()
            MenuBarExtraView()
                .environmentObject(pairedDevicesObject)
        }
        .menuBarExtraStyle(.window)
    }
}

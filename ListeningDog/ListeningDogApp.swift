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
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        
        WindowGroup {
            HomeView()
        }
        
        MenuBarExtra("ListeningDogApp", image: "dog") {
            let pairedDevicesObject = PairedDevicesObject()
            MenuBarExtraView()
                .environmentObject(appDelegate)
                .environmentObject(pairedDevicesObject)
        }
        .menuBarExtraStyle(.window)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    @Published var mainWindow: NSWindow?
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        mainWindow = NSApp.windows.first
        mainWindow?.orderOut(nil)
    }
    
    func showMainWindow() {
        mainWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}

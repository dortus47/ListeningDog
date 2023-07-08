//
//  ListeningDogApp.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/22.
//

import MenuBarExtraAccess
import SwiftUI
import Cocoa


@main
struct ListeningDogApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var listengDogAppState = ListengDogAppState()
    
    var body: some Scene {
        
        WindowGroup {
            HomeView()
        }
        
        MenuBarExtra("ListeningDogApp", image: "dog") {
            let pairedDevicesObject = PairedDevicesObject()
            MenuBarExtraView()
                .environmentObject(appDelegate)
                .environmentObject(pairedDevicesObject)
                .environmentObject(listengDogAppState)
        }
        .menuBarExtraStyle(.window)
        .menuBarExtraAccess(isPresented: $listengDogAppState.isMenuPresented) { statusItem in // <-- the magic ✨
            // access status item or store it in a @State var
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    @Published var mainWindow: NSWindow?
    
    //    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    //        return false
    //    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        mainWindow = NSApp.windows.first
        mainWindow?.orderOut(nil)
    }
    
    func showMainWindow() {
        mainWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}

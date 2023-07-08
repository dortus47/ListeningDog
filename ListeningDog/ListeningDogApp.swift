//
//  ListeningDogApp.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/22.
//

import SwiftUI
import MenuBarExtraAccess
import Cocoa


@main
struct ListeningDogApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @StateObject var listengDogAppState = ListengDogAppState()
    @State var isMenuPresented: Bool = false
    
    var body: some Scene {
        
        WindowGroup {
            HomeView()
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        
//        MenuBarExtra("ListeningDogApp", image: "dog") {
//            let pairedDevicesObject = PairedDevicesObject()
//            MenuBarExtraView(isMenuPresented: $isMenuPresented)
//                .environmentObject(appDelegate)
//                .environmentObject(pairedDevicesObject)
////                .environmentObject(listengDogAppState)
//        }
//        .menuBarExtraStyle(.window)
//        .menuBarExtraAccess(isPresented: $isMenuPresented) { statusItem in // <-- the magic ✨
//            // access status item or store it in a @State var
//        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    @Published var mainWindow: NSWindow?
    
        func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
            return true
        }
    
//    func applicationDidFinishLaunching(_ notification: Notification) {
//        if let window = NSApp.windows.first {
//            mainWindow = window
//            window.orderOut(nil)
//        }
//    }

    func showMainWindow() {
        mainWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}

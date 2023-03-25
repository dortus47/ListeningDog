//
//  ListeningDogApp.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/22.
//

import Cocoa
import SwiftUI

@main
struct ListeningDogApp: App {
    
    @State var currentNumber: String = "1"

    var body: some Scene {
        
        MenuBarExtra(currentNumber, systemImage: "\(currentNumber).circle") {
            MenuBarExtraView(currentNumber: $currentNumber)
                .environmentObject(PairedDevicesManager())
        }
        .menuBarExtraStyle(.window)
    }
}

// MARK: init
//class AppDelegate: NSObject, NSApplicationDelegate {
//
//    // 상태바 인스턴스 변수
//    var statusBar: StatusBarController?
//
//    var popover = NSPopover.init()
//
//    func applicationDidFinishLaunching(_ aNotification: Notification) {
//
//        popover.contentSize = NSSize(width: 360, height: 360)
//        popover.contentViewController = NSHostingController(rootView: ContentView())
//
//        // 상태바 인스턴스 초기화
//        statusBar = StatusBarController.init(popover)
//    }
//
//    func applicationWillTerminate(_ aNotification: Notification) {
//        // Insert code here to tear down your application
//    }
//}

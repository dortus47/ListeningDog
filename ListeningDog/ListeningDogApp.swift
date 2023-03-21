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
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: init
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    
    // 상태바 인스턴스 변수
    var statusBar: StatusBarController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
//        let contentView = ContentView()

        // Create the window and set the content view.
//        window = NSWindow(
//            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
//            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
//            backing: .buffered, defer: false)
//        window.isReleasedWhenClosed = false
//        window.center()
//        window.setFrameAutosaveName("Main Window")
//        window.contentView = NSHostingView(rootView: contentView)
//        window.makeKeyAndOrderFront(nil)
        
        // 상태바 인스턴스 초기화
        statusBar = StatusBarController.init()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

//
//  StatusBarController.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/22.
//

import Foundation
import AppKit

class StatusBarController {
    
    private var statusBar: NSStatusBar
    private var statusItem: NSStatusItem
    private var popover: NSPopover
    private var eventMonitor: EventMonitor?
    
    init(_ popover: NSPopover) {
        
        self.popover = popover
        statusBar = NSStatusBar.init()
        
        // 메뉴바의 길이를 고정값으로 설정합니다.
        statusItem = statusBar.statusItem(withLength: 30.0)
        
        // 컨텐츠 길이에 맞게 길이가 달라집니다.
        //statusItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        
        // 상태바에 맞게 컨텐츠가 조정됩니다.
        // statusItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        
        if let statusBarButton = statusItem.button {
            statusBarButton.image = NSImage(systemSymbolName: "highlighter", accessibilityDescription: nil)
            statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
            statusBarButton.image?.isTemplate = true
            
            statusBarButton.action = #selector(togglePopover(sender:))
            statusBarButton.target = self
        }
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown], handler: mouseEventHandler)
    }
    
    func mouseEventHandler(_ event: NSEvent?) {
        if popover.isShown {
            hidePopover(event!)
        }
    }
    
    // MARK: PopOver
    
    @objc func togglePopover(sender: AnyObject) {
        if popover.isShown {
            hidePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    private func showPopover(_ sender: AnyObject) {
        if let statusBarButton = statusItem.button {
            popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
            eventMonitor?.start()
        }
    }
    
    private func hidePopover(_ sender: AnyObject) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
}

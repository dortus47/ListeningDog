//
//  EventMonitor.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/22.
//

import Cocoa

class EventMonitor {
    
    private var monitor: Any?
    private let mask: NSEvent.EventTypeMask
    private let handler: (NSEvent?) -> Void
    
    public init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> Void) {
        
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        
        stop()
    }
    
    public func start() {
        
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler) as! NSObject
    }
    
    public func stop() {
        
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
}

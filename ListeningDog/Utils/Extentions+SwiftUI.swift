//
//  Extentions+SwiftUI.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/31.
//

import Foundation
import SwiftUI


extension Binding {
    
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

//
//  MenuBarExtraView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/25.
//

import SwiftUI

struct MenuBarExtraView: View {
    
    @Binding var currentNumber: String

    var body: some View {
        VStack {
            Button("One1") {
                currentNumber = "1"
            }
            Button("Two2") {
                currentNumber = "2"
            }
            Button("Three3") {
                currentNumber = "3"
            }
        }
    }
}

struct MenuBarExtraView_Previews: PreviewProvider {
    
    @State static var currentNumber: String = "1"
    
    static var previews: some View {
        MenuBarExtraView(currentNumber: $currentNumber)
    }
}

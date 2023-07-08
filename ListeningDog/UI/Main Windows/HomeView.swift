//
//  HomeView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/04/08.
//

import SwiftUI

struct HomeView: View {
    @State private var seletedIndex = 1
    
    var body: some View {
        
        NavigationView {
            List(1..<5) { index in
                WindowTitle(seletedIndex: $seletedIndex)
            }
            .listStyle(.sidebar)
            
            switch seletedIndex {
            case 1:
                MainWindowView() // replace with your own view
            case 2:
                View2() // replace with your own view
            case 3:
                View3() // replace with your own view
            case 4:
                View4() // replace with your own view
            default:
                Text("Select a menu item")
            }
        }
    }
    
    enum WindowTitleText: String {
        
        case home = "메인"
        case store = "스토어"
        case setting = "설정"
    }
    
//    enum WindowTitleImage: Image {
//        
//        case home = Image(systemName: "")
//        case store = Image(systemName: "")
//        case setting = Image(systemName: "")
//    }
    
    struct WindowTitle: View {
        
        @Binding var seletedIndex: Int
        
        var body: some View {
            Text("Item \(seletedIndex)")
                .tag(seletedIndex)
        }
    }
}

// Temporary view placeholders
struct MainWindowView: View {
    var body: some View {
        Text("View 1")
    }
}

struct View2: View {
    var body: some View { Text("View 2") }
}

struct View3: View {
    var body: some View { Text("View 3") }
}

struct View4: View {
    var body: some View { Text("View 4") }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

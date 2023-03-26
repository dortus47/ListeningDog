//
//  SectionHeaderView.swift
//  ListeningDog
//
//  Created by 장은석 on 2023/03/26.
//

import SwiftUI

struct SectionHeaderView: View {
    
    let title: String
    
    var body: some View {
        Text(title)
    }
}

struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderView(title: "나의 기기")
    }
}

//
//  HeaderView.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 21.01.2021.
//

import SwiftUI

struct HeaderView : View {
    var themeName: String
    var scores: Int
    var body: some View {
        HStack {
            Text("Theme: \(themeName)")
                .font(.subheadline)
            Spacer()
            Text("Scores: \(scores)")
                .font(.subheadline)
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

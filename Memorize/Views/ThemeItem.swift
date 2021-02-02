//
//  ThemeItemView.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 01.02.2021.
//

import SwiftUI

struct ThemeItem: View {
    @State var theme: GameTheme
    var isEditing: Bool
    
    @EnvironmentObject var themesStore: ThemeViewModel
    @State private var showThemeEditor = false
    
    var body: some View {
        HStack {
            if self.isEditing {
                Image(systemName: "pencil.circle").imageScale(.large)
                .onTapGesture {
                    self.showThemeEditor = true
                }
                .sheet(isPresented: $showThemeEditor) {
                    ThemeEditor(themesStore: themesStore, chosenTheme: self.$theme, isShowing: $showThemeEditor)
                }
            }
            VStack(alignment: .leading) {
                Text(theme.name)
                    .font(.title2)
                Text(theme.cards.joined())
            }
            Spacer()
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(theme.color))
                .frame(width: 30, height: 30)
        }
    }
}

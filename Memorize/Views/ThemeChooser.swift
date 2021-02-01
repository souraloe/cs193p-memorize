//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 01.02.2021.
//

import SwiftUI

struct ThemeChooser: View {
    @ObservedObject var themesStore: ThemeViewModel
    
    @State private var editMode: EditMode = .inactive
    
    init() {
        self.themesStore = ThemeViewModel()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach (self.themesStore.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme), theme: theme)
                                    .navigationTitle(theme.name)) {
                        ThemeItem(theme: theme, editMode: self.$editMode)
                    }
                }
            }
            .navigationBarTitle("Memorize")
            .navigationBarItems(
                leading: Button(action: {
                    
                }, label: {
                    Image(systemName: "plus").imageScale(.large)
                }),
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
        }
    }
}

struct ThemeItem: View {
    var theme: GameTheme
    @Binding var editMode: EditMode
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(theme.name)
                    .font(.title2)
                Text(theme.cards.joined())
            }
            Spacer()
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(theme.color))
                .frame(width: 40, height: 40)
        }
    }
}

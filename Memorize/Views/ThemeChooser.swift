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
                        ThemeItem(theme: theme, isEditing: self.editMode.isEditing)
                            .environmentObject(self.themesStore)
                    }
                }
            }
            .navigationBarTitle("Memorize")
            .navigationBarItems(
                leading: Button(action: {
                    self.themesStore.themes.append(GameTheme(
                        name: "New Theme",
                        cards: ["😀", "🙁", "😱"],
                        numberOfPairsOfCards: 3,
                        color: UIColor.gray.rgb
                    ))
                }, label: {
                    Image(systemName: "plus").imageScale(.large)
                }),
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
        }
    }
}

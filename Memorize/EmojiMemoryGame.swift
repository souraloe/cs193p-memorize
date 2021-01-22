//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 15.01.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private(set) var model: MemoryGame<String>
    private var themeSwitcher = ThemeSwitcher()
    var theme: GameTheme<String> {
        themeSwitcher.currentTheme
    }
    
    internal init() {
        self.themeSwitcher = ThemeSwitcher()
        self.model = EmojiMemoryGame.createMemoryGame(theme: themeSwitcher.currentTheme)
    }
    
    func startNewGame(style: ThemeStyle) {
        self.themeSwitcher.currentStyle = style
        self.model = EmojiMemoryGame.createMemoryGame(theme: themeSwitcher.currentTheme)
    }
    
    static private func createMemoryGame(theme: GameTheme<String>) -> MemoryGame<String> {
        let emojis = theme.cards
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var scores: Int {
        model.scores
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card: card)
    }
}

//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 15.01.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private(set) var model: MemoryGame<String>
    
    internal init(theme: GameTheme) {
        self.model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func startNewGame(theme: GameTheme) {
        self.model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    static private func createMemoryGame(theme: GameTheme) -> MemoryGame<String> {
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

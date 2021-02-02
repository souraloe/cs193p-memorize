//
//  GameTheme.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 20.01.2021.
//

import SwiftUI

struct GameTheme: Codable, Identifiable {
    let id: UUID
    var name: String
    var cards: [String]
    var numberOfPairsOfCards: Int
    var color: UIColor.RGB
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init(name: String, cards: [String], numberOfPairsOfCards: Int, color: UIColor.RGB, id: UUID? = nil) {
        self.id = id ?? UUID()
        self.name = name
        self.cards = cards
        self.numberOfPairsOfCards = cards.count
        self.color = color
    }
    
    init?(json: Data?) {
        if json != nil, let gameTheme = try? JSONDecoder().decode(GameTheme.self, from: json!) {
            self = gameTheme
        } else {
            return nil
        }
    }
}

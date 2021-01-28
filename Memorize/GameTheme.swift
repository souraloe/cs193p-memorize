//
//  GameTheme.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 20.01.2021.
//

import SwiftUI

struct GameTheme<CardContent>: Codable where CardContent: Codable {
    var name: String
    var cards: [CardContent]
    var numberOfPairsOfCards: Int
    var color: UIColor.RGB
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
}

enum ThemeStyle: String, CaseIterable {
    case halloween
    case animals
    case flags
    case travel
    case food
    
    static func cardsFor(_ style: ThemeStyle) -> [String] {
        switch style {
        case .halloween: return ["👻", "🎃", "🕷", "👁", "👹"]
        case .animals: return ["🐶", "🐒", "🐢", "🦍", "🦥"]
        case .flags: return ["🏁", "🇫🇴", "🇺🇦", "🇨🇰", "🇯🇵"]
        case .travel: return ["🚊", "⛵️", "🛵", "🚖", "🚂"]
        case .food: return ["🍉", "🍌", "🥐", "🥟", "🍔"]
        }
    }
    
    static func colorFor(_ style: ThemeStyle) -> UIColor.RGB {
        switch style {
        case .halloween: return UIColor.orange.rgb
        case .animals: return UIColor.purple.rgb
        case .flags: return UIColor.blue.rgb
        case .travel: return UIColor.yellow.rgb
        case .food: return UIColor.red.rgb
        }
    }
}

enum ThemeColor: String, Codable {
    case orange, purple, blue, yellow, red
}

//
//  GameTheme.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 20.01.2021.
//

import Foundation
import SwiftUI

struct GameTheme<CardContent> {
    var name: String
    var cards: [CardContent]
    var numberOfPairsOfCards: Int
    var color: Color
}

enum ThemeStyle: String, CaseIterable {
    case halloween
    case animals
    case flags
    case travel
    case food
    
    static func cardsFor(_ style: ThemeStyle) -> [String] {
        switch style {
        case .halloween:
            return ["👻", "🎃", "🕷", "👁", "👹"]
        case .animals:
            return ["🐶", "🐒", "🐢", "🦍", "🦥"]
        case .flags:
            return ["🏁", "🇫🇴", "🇺🇦", "🇨🇰", "🇯🇵"]
        case .travel:
            return ["🚊", "⛵️", "🛵", "🚖", "🚂"]
        case .food:
            return ["🍉", "🍌", "🥐", "🥟", "🍔"]
        }
    }
    
    static func colorFor(_ style: ThemeStyle) -> Color {
        switch style {
        case .halloween:
            return .orange
        case .animals:
            return .purple
        case .flags:
            return .blue
        case .travel:
            return .yellow
        case .food:
            return .red
        }
    }
}

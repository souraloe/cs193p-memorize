//
//  ThemeSwitcher.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 20.01.2021.
//

import Foundation

struct ThemeSwitcher {
    private var allThemes: [GameTheme<String>] = []
    var currentStyle: ThemeStyle
    var currentTheme: GameTheme<String>! {
        allThemes.first { theme in
            theme.name == currentStyle.rawValue
        }
    }
    
    init() {
        for style in ThemeStyle.allCases {
            let content = ThemeStyle.cardsFor(style)
            allThemes.append(GameTheme<String>(name: style.rawValue, cards: content, numberOfPairsOfCards: content.count, color: ThemeStyle.colorFor(style)))
        }
        currentStyle = .animals
    }
}

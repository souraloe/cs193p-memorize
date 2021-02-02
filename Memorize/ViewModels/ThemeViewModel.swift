//
//  ThemeViewModel.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 01.02.2021.
//

import Foundation
import Combine
import SwiftUI

final class ThemeViewModel: ObservableObject {
    @Published var themes: [GameTheme]
        
    private var autosaveCancellable: AnyCancellable?
    
    init() {
        let defaultKey = "Memorize.Themes"
        if let storedThemesJSON = UserDefaults.standard.object(forKey: defaultKey),
           let decodedThemes = try? JSONDecoder().decode([GameTheme].self, from: storedThemesJSON as! Data) {
            self.themes = decodedThemes
        } else {
            self.themes = ThemeViewModel.defaultThemes()
        }
        self.autosaveCancellable = self.$themes.sink(receiveValue: { themes in
            let dataToSave = try? JSONEncoder().encode(themes)
            UserDefaults.standard.set(dataToSave!, forKey: defaultKey)
        })
    }
    
    func update(theme: GameTheme) {
        if let index = self.themes.firstIndex(where: {$0.id == theme.id}) {
            self.themes[index] = theme
        }
    }
    
    private static func defaultThemes() -> [GameTheme] {
        var themes: [GameTheme] = []
        themes.append(GameTheme(
                        name: "Halloween",
                        cards: ["👻", "🎃", "🕷", "👁", "👹"],
                        numberOfPairsOfCards: 5,
                        color: UIColor.orange.rgb
        ))
        themes.append(GameTheme(
                        name: "Animals",
                        cards: ["🐶", "🐒", "🐢", "🦍", "🦥"],
                        numberOfPairsOfCards: 5,
                        color: UIColor.purple.rgb
        ))
        themes.append(GameTheme(
                        name: "Flags",
                        cards: ["🏁", "🇫🇴", "🇺🇦", "🇨🇰", "🇯🇵"],
                        numberOfPairsOfCards: 5,
                        color: UIColor.blue.rgb
        ))
        themes.append(GameTheme(
                        name: "Travel",
                        cards: ["🚊", "⛵️", "🛵", "🚖", "🚂"],
                        numberOfPairsOfCards: 5,
                        color: UIColor.yellow.rgb
        ))
        themes.append(GameTheme(
                        name: "Food",
                        cards: ["🍉", "🍌", "🥐", "🥟", "🍔"],
                        numberOfPairsOfCards: 5,
                        color: UIColor.red.rgb
        ))
        return themes
    }
}

extension Array {
    var json: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}

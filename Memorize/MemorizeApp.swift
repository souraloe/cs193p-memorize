//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 12.01.2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: EmojiMemoryGame())
        }
    }
}

//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 12.01.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HeaderView(themeName: viewModel.theme.name, scores: viewModel.scores)
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        viewModel.choose(card: card)
                    }
                }
                .padding(self.cardsPadding)
            }
            .padding()
            .foregroundColor(viewModel.theme.color)
            Button(newGameTitle, action: onNewGame)
                .font(Font.system(size: newGameFontSize))
        }
    }
    
    private func onNewGame() {
        withAnimation(.easeInOut) {
            viewModel.startNewGame(style: randomStyle())
        }
    }
    
    private func randomStyle() -> ThemeStyle {
        let randomIndex = Int.random(in: 0..<ThemeStyle.allCases.count)
        return ThemeStyle.allCases[randomIndex]
    }
    
    // MARK: - Drawing Constants
    
    private let newGameFontSize: CGFloat = 20
    private let cardsPadding: CGFloat = 5
    private let newGameTitle = "New Game"
}












struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}

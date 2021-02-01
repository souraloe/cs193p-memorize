//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Vlad Ovcharov on 12.01.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var theme: GameTheme
    
    var body: some View {
        VStack {
            HStack {
                Text("Scores: \(viewModel.scores)")
                Spacer()
            }
            .padding(.horizontal, scoresPadding)
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        viewModel.choose(card: card)
                    }
                }
                .padding(self.cardsPadding)
            }
            .padding()
            .foregroundColor(Color(self.theme.color))
            Button(newGameTitle, action: onNewGame)
                .font(Font.system(size: newGameFontSize))
        }
        .onAppear {
            viewModel.startNewGame(theme: theme)
        }
    }
    
    private func onNewGame() {
        withAnimation(.easeInOut) {
            viewModel.startNewGame(theme: theme)
        }
    }
    
    // MARK: - Drawing Constants
    
    private let newGameFontSize: CGFloat = 20
    private let cardsPadding: CGFloat = 5
    private let newGameTitle = "New Game"
    private let scoresPadding: CGFloat = 20
}

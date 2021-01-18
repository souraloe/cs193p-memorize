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
        HStack() {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
            .padding()
            .foregroundColor(.orange)
    }
}

struct CardView : View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
            .font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
        }
    }
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}

//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Nolan Kyhl on 11/23/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame // redraw me if object sends change. Should never be set equal to anything.
    
    var body: some View { // Computed property: recomputed every time someone asks for this
        VStack {
            ScrollView {
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding() // Some modifiers are applied to the VStack, and not to each item inside
    }
    
    var cards: some View { // This is a normal function, not a ViewBuilder. Has an implicit return
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) { // This is a ViewBuilder
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.green)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack { // Equal to ZStack(content: { ... }). Trailing closure syntax possible because it is the last argument and a closure/function
            let base = RoundedRectangle(cornerRadius: 12) // Type Inference
            Group {
                base.fill(colorScheme == .dark ? .black : .white)
                base.strokeBorder(lineWidth: 2)     // View modifier (function(view) --> view)
                Text(card.content)
                    .font(.system(size:200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}

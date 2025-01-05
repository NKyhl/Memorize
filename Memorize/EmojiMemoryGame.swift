//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Nolan Kyhl on 1/5/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻", "🎃", "🕷", "😈", "💀", "☠️", "🕸", "🧙‍♀️", "🙀", "👹", "🍭"]

    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "‼️"
            }
        } // MemoryGame infers the type of game by createCardContent's return type surprisingly
    }
    
    @Published private var model = createMemoryGame() // private so View can't directly access Model. @Published marks that our observable object will send "something changed" if this variable is changed. Works even though variable is directly private 
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents

    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) { // intent function
        model.choose(card)
    }
}

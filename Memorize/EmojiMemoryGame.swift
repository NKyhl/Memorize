//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Nolan Kyhl on 1/5/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static var theme = themes.randomElement()!

    private static func createMemoryGame(_ theme: Theme) -> MemoryGame<String> {
        let count = max(min(theme.numberOfPairs, theme.emoji.count), 2)
        let emojiSubset = theme.emoji.shuffled().prefix(count)
        var game = MemoryGame(numberOfPairsOfCards: emojiSubset.count) { pairIndex in
            if emojiSubset.indices.contains(pairIndex) {
                return emojiSubset[pairIndex]
            } else {
                return "‼️"
            }
        } // MemoryGame infers the type of game by createCardContent's return type surprisingly
        game.shuffle()
        return game
    }
    
    @Published private var model = createMemoryGame(theme) // private so View can't directly access Model. @Published marks that our observable object will send "something changed" if this variable is changed. Works even though variable is directly private
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var themeColor: Color {
        switch EmojiMemoryGame.theme.color {
        case "pink":
            return Color.pink
        case "red":
            return Color.red
        case "orange":
            return Color.orange
        case "yellow":
            return Color.yellow
        case "green":
            return Color.green
        case "blue":
            return Color.blue
        case "purple":
            return Color.purple
        case "brown":
            return Color.brown
        case "black":
            return Color.black
        case "white":
            return Color.white
        case "gray":
            return Color.gray
        default:
            return Color.gray
        }
    }
    
    var themeName: String {
        EmojiMemoryGame.theme.name
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intents

    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) { // intent function
        model.choose(card)
    }
    
    func reset() {
        EmojiMemoryGame.theme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(EmojiMemoryGame.theme)
    }
}

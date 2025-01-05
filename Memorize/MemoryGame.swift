//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Nolan Kyhl on 12/29/24.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card> // viewing is allowed, but setting is private. called access control
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [] // or Array<Card>() or [Card]()
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() { // Swift does copy-on-write, so mutating identifies this.
        cards.shuffle()
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
    }
}

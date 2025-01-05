//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Nolan Kyhl on 11/23/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}

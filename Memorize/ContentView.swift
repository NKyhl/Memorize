//
//  ContentView.swift
//  Memorize
//
//  Created by Nolan Kyhl on 11/23/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷", "😈", "💀", "🕸", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"] // Type [String] or Array<String>
    
    @State var cardCount: Int = 4
    
    var body: some View { // Computed property: recomputed every time someone asks for this
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding() // Some modifiers are applied to the VStack, and not to each item inside
    }
    
    var cards: some View { // This is a normal function, not a ViewBuilder. Has an implicit return
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) { // This is a ViewBuilder
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.green)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View { // callers use "by", inside the function we use "offset". symbol is both the internal and external parameter name.
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView: View {
    let content: String;
    @State var isFaceUp = false // Type Inference. @State creates immutable pointer that allows mutable value it points to to change. Otherwise .onTapGesture could not flip card because Views are immutable. Only used for small things. Normally our game logic would change our state.
    
    var body: some View {
        ZStack { // Equal to ZStack(content: { ... }). Trailing closure syntax possible because it is the last argument and a closure/function
            let base = RoundedRectangle(cornerRadius: 12) // Type Inference
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)     // View modifier (function(view) --> view)
                Text(content).font(.largeTitle)     // Creating instances of structs
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture { // Equal to onTapGesture(perform: {...}). Can also do (count: N) for number of taps to trigger this. Within brackets is not a ViewBuilder. Normal closure.
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

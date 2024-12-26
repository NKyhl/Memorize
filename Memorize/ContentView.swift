//
//  ContentView.swift
//  Memorize
//
//  Created by Nolan Kyhl on 11/23/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = [
        ["👻", "🎃", "🕷", "😈", "👻", "🎃", "🕷", "😈"],
        ["🎉", "🎅🏼", "🎄", "🎁", "🎊", "🎉", "🎅🏼", "🎄", "🎁", "🎊"],
        ["🌅", "🌁", "🌄", "🏞", "🌁", "🌅", "🏞", "🌄"]
    ]
    
    @State var theme: Int = 0
    
    var body: some View { // Computed property: recomputed every time someone asks for this
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Spacer()
            ScrollView {
                cards
            }
            Spacer()
            themeButtons
        }
        .padding() // Some modifiers are applied to the VStack, and not to each item inside
    }
    
    var cards: some View { // This is a normal function, not a ViewBuilder. Has an implicit return
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) { // This is a ViewBuilder
            ForEach(emojis[theme].indices.shuffled(), id: \.self) { index in
                CardView(content: emojis[theme][index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.green)
    }
    
    var themeButtons : some View {
        HStack(alignment: .bottom) {
            Button(action: {
                theme = 0
            }, label: {
                VStack {
                    Image(systemName: "eyes")
                    Text("Halloween").font(.body)
                }
            })
            Spacer()
            Button(action: {
                theme = 1
            }, label: {
                VStack {
                    Image(systemName: "star")
                    Text("Christmas").font(.body)
                }
            })
            Spacer()
            Button(action: {
                theme = 2
            }, label: {
                VStack {
                    Image(systemName: "sun.and.horizon")
                    Text("Landscapes").font(.body)
                }
            })
        }
        .font(.largeTitle)
        .padding()
    }
}

struct CardView: View {
    let content: String;
    @State var isFaceUp = false // Type Inference. @State creates immutable pointer that allows mutable value it points to to change. Otherwise .onTapGesture could not flip card because Views are immutable. Only used for small things. Normally our game logic would change our state.
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack { // Equal to ZStack(content: { ... }). Trailing closure syntax possible because it is the last argument and a closure/function
            let base = RoundedRectangle(cornerRadius: 12) // Type Inference
            Group {
                base.fill(colorScheme == .dark ? .black : .white)
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

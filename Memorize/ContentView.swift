//
//  ContentView.swift
//  Memorize
//
//  Created by Nolan Kyhl on 11/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {           // Computed property: recomputed every time someone asks for this
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.green)    // some view modifiers are passed to everything inside
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {                                    // equal to ZStack(content: { ... })
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)  // shape
                    .strokeBorder(lineWidth: 2)     // view modifier (function(view) --> view)
                Text("👻").font(.largeTitle)        // creating instances of structs
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

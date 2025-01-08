//
//  Theme.swift
//  Memorize
//
//  Created by Nolan Kyhl on 1/8/25.
//

struct Theme {
    var name: String
    var emoji: [String]
    var numberOfPairs: Int
    var color: String
}

let themes: [Theme] = [
    Theme(name: "Halloween",
          emoji: ["👻", "🎃", "🕷", "😈", "💀", "☠️", "🕸", "🧙‍♀️", "🙀", "👹", "🍭"],
          numberOfPairs: 8,
          color: "orange"),
    Theme(name: "Christmas",
          emoji: ["🎅🏼", "🎄", "🎁", "🌟"],
          numberOfPairs: 4,
          color: "green"),
    Theme(name: "4th of July",
          emoji: ["🎇", "🎆", "🧨", "🇺🇸", "🍔", "🌭"],
          numberOfPairs: 6,
          color: "red"),
    Theme(name: "Valentine's",
          emoji: ["💌", "💘", "💝", "❤️", "💕", "🌹", "💐"],
          numberOfPairs: 7,
          color: "pink"),
    Theme(name: "Thanksgiving",
          emoji: ["🦃", "🥔", "🌽", "⛵️", "🙏"],
          numberOfPairs: 5,
          color: "brown"),
    Theme(name: "New Year's",
          emoji: ["🎉", "🥳", "🎊", "🎇", "🗓️"],
          numberOfPairs: 5,
          color: "yellow"),
]

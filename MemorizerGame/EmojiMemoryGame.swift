//
//  EmojiMemoryGame.swift
//  MemorizerGame
//
//  Created by Wajih Rizvi on 2022-08-18.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let memoryGameThemes = [
        "halloween": ["content": ["👻", "👹", "😈", "☠️", "🤡", "🎃", "👽", "🤖", "🥷", "🦹🏿‍♀️", "🧝‍♀️", "🧙‍♀️", "🧟‍♂️", "🧚‍♂️", "🧜🏿‍♂️", "🧛‍♂️", "🦸🏾‍♂️", "👨🏼‍🎨"], "color": "orange", "label": "👻"],
        "food": ["content": ["🍔", "🍎", "🍊", "🧀", "🌭", "🧆", "🍟", "🍕", "🥐", "🦴", "🍖", "🥪", "🥗", "🍥", "🍿", "🍩", "🍪"], "color": "red", "label": "🍔"],
        "animals": ["content": ["🐍", "🐴", "🦆", "🙉", "🐶", "🦊", "🐷", "🐔", "🪳", "🐙", "🦑", "🐟", "🐄", "🐩", "🐉", "🦔", "🦉"], "color": "green", "label": "🐴"],
        "sports": ["content": ["🏈", "⚽️", "🏀", "🏓", "🏸", "🎾", "🥊", "🏒", "🥌", "🤼‍♂️", "🏀", "🛼", "🥍", "🏉", "⛳️", "🚴🏿‍♀️", "⛷"], "color": "blue", "label": "🏈"],
        "countries": ["content": ["🇨🇦", "🇮🇴", "🇦🇿", "🇧🇧", "🇦🇺", "🇹🇩", "🇩🇪", "🇪🇸", "🇧🇸", "🇧🇳", "🇧🇮", "🇨🇼", "🇨🇮", "🇫🇴", "🇲🇨", "🇰🇷", "🇲🇻"], "color": "yellow", "label": "🇨🇦"],
        "people": ["content": ["👩‍🦰", "🧑‍🔬", "👨‍🦰", "👮🏿‍♂️", "👷‍♂️", "🧑🏿‍🎤", "🧕🏻", "👨🏼‍🎨", "🧑🏿‍🦯", "👩‍🦽", "💇🏻‍♂️", "🧏🏾‍♂️", "👨‍🏫", "🕵️‍♂️", "👳🏿‍♂️", "💂", "🤴🏻"], "color": "pink", "label": "👩‍🦰"]
    ]
    
    static func createEmojiCardContent(index: Int, theme: String) -> String {
        let chosenTheme = memoryGameThemes[theme]
        let themeEmojis = chosenTheme!["content"] as? [String]
        print(index)
        let emoji = themeEmojis![index]
        return emoji
    }
    
    static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: 8, themes: memoryGameThemes, createCardContent: EmojiMemoryGame.createEmojiCardContent)
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var themes: Array<MemoryGame<String>.Theme> {
        return model.gameThemes
    }
    
    var theme: MemoryGame<String>.Theme {
        return model.currentTheme
    }
    
    var score: Int {
        return model.score
    }
    
    var currentColor: Color {
        let themeColor = model.currentTheme.color
        switch themeColor {
        case "orange":
            return Color.orange
        case "red":
            return Color.red
        case "green":
            return Color.green
        case "blue":
            return Color.blue
        case "yellow":
            return Color.yellow
        case "pink":
            return Color.pink
        default:
            return Color.red
        }
    }
    
    // MARK: - INTENTS
    func choose(_ chosen: MemoryGame<String>.Card) {
        model.choose(card: chosen)
    }
    
    func selectTheme(_ chosen: MemoryGame<String>.Theme) {
        model.chooseTheme(theme: chosen, createCardContent: EmojiMemoryGame.createEmojiCardContent)
    }
    
    func newGame() {
        model.newGame(createCardContent: EmojiMemoryGame.createEmojiCardContent)
    }
}

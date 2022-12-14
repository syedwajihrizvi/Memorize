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
        "halloween": ["content": ["ðŧ", "ðđ", "ð", "â ïļ", "ðĪĄ", "ð", "ð―", "ðĪ", "ðĨ·", "ðĶđðŋââïļ", "ð§ââïļ", "ð§ââïļ", "ð§ââïļ", "ð§ââïļ", "ð§ðŋââïļ", "ð§ââïļ", "ðĶļðūââïļ", "ðĻðžâðĻ"], "color": "orange", "label": "ðŧ"],
        "food": ["content": ["ð", "ð", "ð", "ð§", "ð­", "ð§", "ð", "ð", "ðĨ", "ðĶī", "ð", "ðĨŠ", "ðĨ", "ðĨ", "ðŋ", "ðĐ", "ðŠ"], "color": "red", "label": "ð"],
        "animals": ["content": ["ð", "ðī", "ðĶ", "ð", "ðķ", "ðĶ", "ð·", "ð", "ðŠģ", "ð", "ðĶ", "ð", "ð", "ðĐ", "ð", "ðĶ", "ðĶ"], "color": "green", "label": "ðī"],
        "sports": ["content": ["ð", "â―ïļ", "ð", "ð", "ðļ", "ðū", "ðĨ", "ð", "ðĨ", "ðĪžââïļ", "ð", "ðž", "ðĨ", "ð", "âģïļ", "ðīðŋââïļ", "â·"], "color": "blue", "label": "ð"],
        "countries": ["content": ["ðĻðĶ", "ðŪðī", "ðĶðŋ", "ð§ð§", "ðĶðš", "ðđðĐ", "ðĐðŠ", "ðŠðļ", "ð§ðļ", "ð§ðģ", "ð§ðŪ", "ðĻðž", "ðĻðŪ", "ðŦðī", "ðēðĻ", "ð°ð·", "ðēðŧ"], "color": "yellow", "label": "ðĻðĶ"],
        "people": ["content": ["ðĐâðĶ°", "ð§âðŽ", "ðĻâðĶ°", "ðŪðŋââïļ", "ð·ââïļ", "ð§ðŋâðĪ", "ð§ðŧ", "ðĻðžâðĻ", "ð§ðŋâðĶŊ", "ðĐâðĶ―", "ððŧââïļ", "ð§ðūââïļ", "ðĻâðŦ", "ðĩïļââïļ", "ðģðŋââïļ", "ð", "ðĪīðŧ"], "color": "pink", "label": "ðĐâðĶ°"]
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

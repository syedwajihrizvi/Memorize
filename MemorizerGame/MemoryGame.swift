//
//  MemoryGame.swift
//  MemorizerGame
//
//  Created by Wajih Rizvi on 2022-08-18.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var indexOfCurrentCard: Int?
    
    private(set) var gameThemes: Array<Theme>
    private(set) var currentTheme: Theme
    private(set) var score: Int
    
    mutating func choose(card chosen: Card) {
        if let indexOfChosenCard = cards.firstIndex(where: {$0.id == chosen.id}),
            !cards[indexOfChosenCard].isFaceUp,
            !cards[indexOfChosenCard].isMatched {
            if let potentialMatchIndex = indexOfCurrentCard {
                if cards[potentialMatchIndex].content == cards[indexOfChosenCard].content {
                    cards[potentialMatchIndex].isMatched = true
                    cards[indexOfChosenCard].isMatched = true
                    score += 5
                } else {
                    score -= 3
                }
                indexOfCurrentCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfCurrentCard = indexOfChosenCard
            }
            cards[indexOfChosenCard].isFaceUp.toggle()
        }
    }
    
    mutating func chooseTheme(theme chosen: Theme, createCardContent: (Int, String) -> CardContent) {
        if let indexOfChosenTheme = gameThemes.firstIndex(where: {$0.id == chosen.id}) {
            currentTheme = gameThemes[indexOfChosenTheme]
            let firstCardIndexes = Array(0..<cards.count).filter {n in return n%2 == 0}
            for pairIndex in firstCardIndexes {
                let newContent: CardContent = createCardContent(pairIndex, currentTheme.name)
                for index in pairIndex...(pairIndex+1) {
                    cards[index].content = newContent
                }
            }
        }
    }
    
    mutating func newGame(createCardContent: (Int, String) -> CardContent) {
        currentTheme = gameThemes.randomElement()!
        let firstCardIndexes = Array(0..<cards.count).filter {n in return n%2 == 0}
        for pairIndex in firstCardIndexes {
            let newContent: CardContent = createCardContent(pairIndex, currentTheme.name)
            for index in pairIndex...(pairIndex+1) {
                cards[index].isMatched = false
                cards[index].isFaceUp = false
                cards[index].content = newContent
            }
        }
        indexOfCurrentCard = nil
        score = 0
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int, themes: [String : [String : Any]], createCardContent: (Int, String) -> CardContent) {
        cards =  Array<Card>()
        gameThemes = Array<Theme>()
        score = 0
        for (key, value) in themes {
            gameThemes.append(Theme(name: key,
                                    content: value["content"] as! [CardContent],
                                    label: value["label"] as! String,
                                    color: value["color"] as! String,
                                    id: key))
        }
        
        currentTheme = gameThemes.randomElement()!
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex, currentTheme.name)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var content: CardContent
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var id: Int
    }
    
    struct Theme: Identifiable {
        var name: String
        var content: [CardContent]
        var label: String
        var color: String
        var id: String
    }
}

//
//  Concentration.swift
//  Concentration
//
//  Created by John Lee on 2018/9/20.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var emojiArray: Array<String> = []
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index:Int) {
        if !cards[index].isMatch {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatch = true
                    cards[index].isMatch = true
                }
                
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].lastIsFaceUp = false
                }
                
                cards[index].lastIsFaceUp = cards[index].isFaceUp
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].lastIsFaceUp = cards[flipDownIndex].isFaceUp
                    cards[flipDownIndex].isFaceUp = false
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}

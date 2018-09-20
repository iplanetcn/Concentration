//
//  Card.swift
//  Concentration
//
//  Created by John Lee on 2018/9/20.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatch = false
    var lastIsFaceUp = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    func isNeedFlip() -> Bool {
        return isFaceUp != lastIsFaceUp
    }
}

//
//  Card.swift
//  Concetration
//
//  Created by Marat on 31/01/2020.
//  Copyright © 2020 ASU. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    private(set) var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

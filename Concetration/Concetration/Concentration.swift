//
//  Concentration.swift
//  Concetration
//
//  Created by Marat on 31/01/2020.
//  Copyright © 2020 ASU. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    private var usingCards = [Int]()
    private(set) var score = 0
    private(set) var count = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in self.cards.indices {
                if self.cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else  {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in self.cards.indices {
                self.cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        
        assert(self.cards.indices.contains(index), "Выбранный индекс не совпадает с картами")
        
        // если уже не совпавшие
        if !self.cards[index].isMatched {
            if !self.cards[index].isFaceUp {
                self.count += 1
            }
            // если есть предыдущи индекс и он не равен новому
            if let matchIndex = self.indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // если индексы перевернутой и текущей совпадают, матчим их
                if self.cards[matchIndex].identifier == self.cards[index].identifier {
                    self.cards[matchIndex].isMatched = true
                    self.cards[index].isMatched = true
                    self.score += 2
                }
                else{
                    if self.usingCards.contains(self.cards[matchIndex].identifier){
                        self.score -= 1
                    }
                    else{
                        self.usingCards+=[self.cards[matchIndex].identifier]
                    }
                    if !self.usingCards.contains(self.cards[index].identifier){
                        self.usingCards+=[self.cards[index].identifier]
                    }
                }
                // текущую переварачиваем
                self.cards[index].isFaceUp = true
                
            } else {
                self.indexOfOneAndOnlyFaceUpCard = index
            }
            
        }

    }
    
    init(numberOfPairsCard: Int) {
        
        assert(numberOfPairsCard > 0, "Количество пар карт должно быть больше 0")
        
        for _ in 0..<numberOfPairsCard {
            let card = Card()
            self.cards += [card, card]
            cards = cards.shuffled()
        }
    }
    
}

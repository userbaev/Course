//
//  ViewController.swift
//  Concetration
//
//  Created by Marat on 31/01/2020.
//  Copyright © 2020 ASU. All rights reserved.
//

import UIKit


var themes = [["😭","😀","😱","😇","😛","😍","😎","🤓"],
    ["🍭","🥘","🍰","🍕","🍱","🍩","🍫","🥜"],
    ["💚","❤️","🧡","💛","💙","💜","🖤","💔"],
    ["🇻🇬","🇬🇪","🇨🇦","🇩🇰","🇷🇺","🇵🇼","🇺🇦","🇲🇹"],
    ["👐","🙌","👏","🤝","🤲","🤟","👌","🖖"],
    ["🐺","🐞","🐔","🐧","🦉","🐛","🐍","🐵"]
]

class ViewController: UIViewController {
    
    private let countLabelText = "Счетчик нажатий:"
    
    private let scoreLabelText = "Количество очков:"
    
    
    private var numberOfTheme = Int(arc4random_uniform(UInt32(themes.count)))
    
    private lazy var game = Concentration(numberOfPairsCard: self.numberOfPairsCard)
    
    var numberOfPairsCard: Int {
        return (self.cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private lazy var emojiArray = themes[self.numberOfTheme]
    private var emoji: [Int: String] = [:]
    
    @IBOutlet private weak var countLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func emojiButtonAction(_ sender: UIButton) {
        print("emojiButtonAction")
        if let index = self.cardButtons.firstIndex(of: sender) {
            self.game.chooseCard(at: index)
            self.updateViewModel()
        } else {
            print("Unhandled Error!!!")
        }
    }
    
    @IBAction func NewGame(_ sender: Any) {
        self.game = Concentration(numberOfPairsCard: self.numberOfPairsCard)
        self.numberOfTheme = Int(arc4random_uniform(UInt32(themes.count)))
        self.emojiArray = themes[self.numberOfTheme]
        self.emoji = [:]
        self.updateViewModel()
    }
    
    private func update(){
        self.countLabel.text = "\(countLabelText) \(self.game.count)"
        self.scoreLabel.text = "\(scoreLabelText) \(self.game.score)"
    }
    
    private func updateViewModel() {
        for index in self.cardButtons.indices {
            let button = self.cardButtons[index]
            let card = self.game.cards[index]
            if card.isFaceUp {
                button.setTitle(self.emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1) : #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            }
        }
        self.update()
    }
    
    private func emoji(for card: Card) -> String {
        if self.emoji[card.identifier] == nil, self.emojiArray.count > 0 {
            self.emoji[card.identifier] = self.emojiArray.remove(at: self.emojiArray.count.arc4random)
        }
        return self.emoji[card.identifier] ?? "?"
    }
    
}

//
//  ViewController.swift
//  Concentration
//
//  Created by John Lee on 2018/9/20.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = Array("🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐽🐸🐵🙈🙉🙊🐒🐔🐧🐦🐤🐣🐥🦆🦅🦉🦇🐺🐗🐴🦄🐝🐛🦋🐌🐚🐞🐜🦗🕷🕸🦂🐢🐍🦎🦖🦕🐙🦑🦐🦀🐡🐠🐟🐬🐳🐋🦈🐊🐅🐆🦓🦍🐘🦏🐪🐫🦒🐃🐂🐄🐎🐖🐏🐑🐐🦌🐕🐩🐈🐓🦃🕊🐇🐁🐀🐿🦔🐾🐉🐲")
    
    lazy var game:Concentration = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func cardButtonTapped(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel(at: cardNumber)
        }else {
            print("card is not in the cardButtons.")
        }
    }
    
    func updateViewFromModel(at cardNumber:Int) {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                if index == cardNumber {
                    UIView.transition(with: button, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: { isComplete in
                        self.hideMatchCards(isComplete: isComplete, isMatch: card.isMatch)
                    })
                }
            }else {
                if (!card.isMatch){
                    button.setTitle("", for: .normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                    if (index == cardNumber || card.isNeedFlip()) {
                        UIView.transition(with: button, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                    }
                }
            }
        }
    }
    
    func hideMatchCards(isComplete: Bool, isMatch: Bool){
        if (isComplete && isMatch) {
            // remove view from cardButtons
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                for index in self.cardButtons.indices {
                    let button = self.cardButtons[index]
                    let card = self.game.cards[index]
                    if card.isMatch {
                        button.isHidden = true
                    }
                }
                
                self.checkGame()
            })
        }
    }
    
    func checkGame() {
        if (game.isOver()) {
            let alert = UIAlertController(title: "", message: "Play Again?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    self.resetGame()
                    break
                    
                case .cancel:
                    print("cancel")
                    break
                    
                case .destructive:
                    print("destructive")
                    break
                }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func resetGame() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        for index in cardButtons.indices {
            cardButtons[index].isHidden = false
        }
        
        updateViewFromModel(at: -1)
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = String(emojiChoices.remove(at: randomIndex))
        }
        return emoji[card.identifier] ?? "?"
    }
    
}


//
//  CardDeck.swift
//  Prototype 1
//
//  Created by 陳修雯 on 17/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class CardDeck: CardTemplate {
    var cardDeck:[CardTemplate] = []
    
    func addCard(card: CardTemplate) {
        cardDeck.append(card)
    }
    
    func returnCardNum() -> Int {
        return cardDeck.count
    }
    
}

//
//  AttackCard.swift
//  Prototype 1
//
//  Created by Huu Nguyen on 17/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class attack: CardTemplate {
    var energy = Int()
    var backImage = SKTexture.self
    var cardDescription = String()
    var used = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    init(energy: Int){
        super.init(cardType: .attack)
    }
    // may accept arguments of enemies?
    func attack() -> Int {
        return energy;
    }
}

class cardAttack1 : attack {
    var cardAttackImage = SKTexture()
    
    
    init() {
        let cardImage = SKSpriteNode(imageNamed: "CardAttackImage1")
        
        super.init(energy: 1)
        cardAttackImage = SKTexture(imageNamed: "CardAttackImage1")
        cardImage.position = CGPoint(x: 0, y: 30)
        cardImage.zPosition = 1
        self.addChild(cardImage)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

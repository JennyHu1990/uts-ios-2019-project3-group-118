//
//  DefendCard.swift
//  Prototype 1
//
//  Created by Huu Nguyen on 17/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit

// Sub Class of Card Template
class DebuffCard: CardTemplate {
//    var backImage = SKTexture.self
    var used = false

    func defense() {
        print("Defense")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(energy: Int) {
        super.init(cardType: .debuff)
    }

    init(name: String, energy: Int, imageName: String, description: String) {
        super.init(cardType: .debuff)
        self.setImage(with: imageName)
        self.setName(with: name)
        self.setEnergy(with: energy)
        self.setDescription(with: description)
    }
}

//Energy 2
//Enemy sclient 2 rounds
//class cardDebuff1: DebuffCard {
//    init() {
//        super.init(name: "Debuff1", energy: 2, imageName: "CardDebuffImage1", description: "Skip all Enemies 2 turns")
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func activateCardEnemy(enemy: Enemy) {
//        // TODO
//    }
//}

// Debuff Card 2
class cardDebuff2: DebuffCard {
    init() {
        super.init(name: "Debuff 2", energy: 2, imageName: "CardDebuffImage2", description: "10 damage 2 times \nSkip player 1 turn")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardEnemy(enemy: Enemy) {
        GameManager.damageEnemy(with: 10, enemy: enemy)
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.7),
            SKAction.run { GameManager.damageEnemy(with: 10, enemy: enemy) }]))
        GameManager.skipPlayer = true
    }
}

//Debuff Card 3 
class cardDebuff3: DebuffCard {
    init() {
        super.init(name: "Debuff 3", energy: 2, imageName: "CardDebuffImage3", description: "Skip all enemy 1 turn")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardEnemy(enemy: Enemy) {
        GameManager.skipAllEnemy = true
    }
}

//Debuff Card 4
class cardDebuff4: DebuffCard {
    init() {
        super.init(name: "Debuff 4", energy: 2, imageName: "CardDebuffImage4", description: "Reduce 2 damage in next turn")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardEnemy(enemy: Enemy) {
        GameManager.reduceEnemyTwoDamage = true
    }
}

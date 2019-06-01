//
//  DefendCard.swift
//  Prototype 1
//
//  Created by Huu Nguyen on 17/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit


class HealCard: CardTemplate {
//    var backImage = SKTexture.self
    var used = false
    var heal: Int = 0
    
    func defense() {
        print("Defense")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(energy: Int) {
        super.init(cardType: .heal)
    }

    init(name: String, energy: Int, imageName: String, description: String, heal: Int = 0) {
        super.init(cardType: .heal)
        self.setImage(with: imageName)
        self.setName(with: name)
        self.setEnergy(with: energy)
        self.setDescription(with: description)
        self.heal = heal
    }

    override func activateCardPlayer() {
        GameManager.healPlayer(with: heal)
    }
}

//Energy 2
//Double player hp
class cardHeal1: HealCard {
    init() {
        super.init(name: "Heal1", energy: 2, imageName: "CardHealImage1", description: "Double player hp")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardPlayer() {
        GameManager.healPlayer(with: GameManager.hp)
    }
}

//Energy 2
//Random 1-4 heal of player
class cardHeal2: HealCard {
    init() {
        super.init(name: "Heal2", energy: 2, imageName: "CardHealImage2", description: "1-4 Random Heal")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardPlayer() {
        let randomHeal = Int.random(in: 1 ..< 4)
        GameManager.healPlayer(with: randomHeal)
    }
}

//Energy 3
//Heal player hp 3
//Damage all the enemy 2 hp
class cardHeal3: HealCard {
    init() {
        super.init(name: "Heal3", energy: 3, imageName: "CardHealImage3", description: "3 Heal \n1 Damage all the enemies")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardPlayer() {
        GameManager.healPlayer(with: 3)
        for e in GameManager.enemy {
            GameManager.damageEnemy(with: 2, enemy: e)
        }
//        GameManager.targetEnemy?.getDamage(with: 2)
    }
}

//Energy 1
//Heal player 1
class cardHeal4: HealCard {
    init() {
        super.init(name: "Heal4", energy: 1, imageName: "CardHealImage4", description: "1 Heal", heal: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
//  DefendCard.swift
//  Prototype 1
//
//  Created by Huu Nguyen on 17/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit

//Sub Class of CardTemplate
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

//Heal Card 1
class cardHeal1: HealCard {
    init() {
        super.init(name: "Heal 1", energy: 4, imageName: "CardHealImage1", description: "Double player hp")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func activateCardPlayer() {
        GameManager.healPlayer(with: GameManager.hp)
    }
}

//Heal Card 2
class cardHeal2: HealCard {
    init() {
        super.init(name: "Heal 2", energy: 2, imageName: "CardHealImage2", description: "2-6 Random Heal")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func activateCardPlayer() {
        let randomHeal = Int.random(in: 2...6)
        GameManager.healPlayer(with: randomHeal)
    }
}

//Heal Card 3
class cardHeal3: HealCard {
    init() {
        super.init(name: "Heal 3", energy: 3, imageName: "CardHealImage3", description: "3 Heal \n3 Damage all the enemies")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func activateCardPlayer() {
        GameManager.healPlayer(with: 3)
        for e in GameManager.enemyList {
            GameManager.damageEnemy(with: 3, enemy: e)
        }
//        GameManager.targetEnemy?.getDamage(with: 2)
    }
}

//Heal Card 4
class cardHeal4: HealCard {
    init() {
        super.init(name: "Heal 4", energy: 1, imageName: "CardHealImage4", description: "2 Heal", heal: 2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


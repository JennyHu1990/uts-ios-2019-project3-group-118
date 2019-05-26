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

class AttackCard: CardTemplate {
//    var backImage = SKTexture.self
    var used = false
    var damage: Int = 0

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(energy: Int) {
        super.init(cardType: .attack)
    }

    init(name: String, energy: Int, imageName: String, description: String, damage:Int = 0) {
        super.init(cardType: .attack)
        self.setImage(with: imageName)
        self.setName(with: name)
        self.setEnergy(with: energy)
        self.setDescription(with: description)
        self.damage = damage
    }

    func use(for enemy: Enemy) {
        enemy.getDamage(with: damage)
    }
}

// Dragon attack
// Energy 1;
// Damage enemy hp 3
class cardAttack1: AttackCard {
    
    init() {
        super.init(name: "Dragon attack", energy: 1, imageName: "CardAttackImage1", description: "3 Damage", damage: 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Item2:  Snake fire
// Energy 2;
// damage enemy hp 6
class cardAttack2: AttackCard {
    
    init() {
        super.init(name: "Snake fire", energy: 2, imageName: "CardAttackImage1", description: "6 Damage", damage: 6)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//Sword angry
//Energy 2,
//Damage enemy hp equals to the player’s hp
class cardAttack3: AttackCard {
    init() {
        super.init(name: "Sword angry", energy: 2, imageName: "CardAttackImage1", description: "Damage enemy hp equals to the player’s hp")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func use(for enemy: Enemy) {
        enemy.getDamage(with: GameManager.hp)
    }
}

//Item4： Goblin Food
//Energy 2
//Damage enemy hp 3
//Heal player hp 2
class cardAttack4: AttackCard {
    init() {
        super.init(name: "Goblin Food", energy: 2, imageName: "CardAttackImage1", description: "Damage enemy hp 3 and Heal player hp 2")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func use(for enemy: Enemy) {
        enemy.getDamage(with: 3)
        GameManager.healPlayer(with: 2)
    }
}

//Item5: Palladium Lava
//Energy 1
//damage  enemy hp 8
//Damage player hp 4
class cardAttack5: AttackCard {
    init() {
        super.init(name: "Palladium Lava", energy: 1, imageName: "CardAttackImage1", description: "Damage enemy hp 8 and Damage player hp 4")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func use(for enemy: Enemy) {
        enemy.getDamage(with: 8)
        GameManager.damagePlayer(with: 4)
    }
}

//Energy 2
//Damage enemy hp 4
//Lose 1 card
class cardAttack6: AttackCard {
    init() {
        super.init(name: "Item6", energy: 1, imageName: "CardAttackImage1", description: "Damage enemy hp 4 and Lose 1 card")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func use(for enemy: Enemy) {
        enemy.getDamage(with: 4)
        GameManager.throwRandomCard()
    }
}

//Energy 2
//Random 1-4 damage of the enemy
class cardAttack7: AttackCard {
    init() {
        super.init(name: "Item7", energy: 1, imageName: "CardAttackImage1", description: "Damage enemy random 1-4 hp")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func use(for enemy: Enemy) {
        let randomDamage = Int.random(in: 0 ..< 4)
        enemy.getDamage(with: randomDamage)
    }
}

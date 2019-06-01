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

    /*try extension*/
    override func activateCardEnemy(enemy: Enemy) {
        GameManager.damageEnemy(with: damage, enemy: enemy)
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
        super.init(name: "Snake fire", energy: 2, imageName: "CardAttackImage2", description: "6 Damage", damage: 6)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//Sword angry
//Energy 3,
//Damage enemy hp equals to the player’s hp
class cardAttack3: AttackCard {
    init() {
        super.init(name: "Sword angry", energy: 3, imageName: "CardAttackImage3", description: "Damage = Player’s hp")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardEnemy(enemy: Enemy) {
        GameManager.damageEnemy(with: GameManager.hp, enemy: enemy)
    }
}

//Item4： Goblin Food
//Energy 2
//Damage enemy hp 3
//Heal player hp 2
class cardAttack4: AttackCard {
    init() {
        super.init(name: "Goblin Food", energy: 2, imageName: "CardAttackImage4", description: "3 Damage \n2 Heal")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardEnemy(enemy: Enemy) {
        GameManager.damageEnemy(with: 3, enemy: enemy)
        GameManager.healPlayer(with: 2)
    }
}

//Item5: Palladium Lava
//Energy 1
//damage  enemy hp 8
//Damage player hp 4
class cardAttack5: AttackCard {
    init() {
        super.init(name: "Palladium Lava", energy: 1, imageName: "CardAttackImage5", description: "8 Damage - Enemay \n4 Damage - Player")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardEnemy(enemy: Enemy) {
        GameManager.damageEnemy(with: 8, enemy: enemy)
        GameManager.damagePlayer(with: 4)
    }
}

//Energy 2
//Damage enemy hp 4
//Lose 1 card
class cardAttack6: AttackCard {
    init() {
        super.init(name: "Attack", energy: 1, imageName: "CardAttackImage6", description: "4 Damage \n1 Card Lose")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardEnemy(enemy: Enemy) {
        GameManager.damageEnemy(with: 4, enemy: enemy)
        GameManager.throwRandomCard()
    }
}

//Energy 2
//Random 1-4 damage of the enemy
class cardAttack7: AttackCard {
    init() {
        super.init(name: "Attack", energy: 1, imageName: "CardAttackImage7", description: "1-4 Random Damage  ")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardEnemy(enemy: Enemy) {
        let randomDamage = Int.random(in: 0 ..< 4)
        GameManager.damageEnemy(with: randomDamage, enemy: enemy)
    }
}

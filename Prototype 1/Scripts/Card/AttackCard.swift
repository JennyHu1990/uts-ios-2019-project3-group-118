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

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(energy: Int) {
        super.init(cardType: .attack)
    }

    init(name: String, energy: Int, imageName: String, description: String) {
        super.init(cardType: .attack)
        self.setImage(with: imageName)
        self.setName(with: name)
        self.setEnergy(with: energy)
        self.setDescription(with: description)
    }

    // may accept arguments of enemies?
//    func attack() -> Int {
//        return energy;
//    }
}

class cardAttack1: AttackCard {
    var cardAttackImage = SKTexture()
    var cardAttackName = String()
}

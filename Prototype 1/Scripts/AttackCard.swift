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
    // may accept arguments of enemies?
    func attack() {
        print("Attack")
    }
}

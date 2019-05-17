//
//  Enemy.swift
//  Prototype 1
//
//  Created by 胡健妮 on 17/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

enum EnemyType: Int {
    case bossFirst,
    bossSecond
}

class Enemy: SKSpriteNode {
    
    let enemy :EnemyType
    let frontTexture :SKTexture
    let backTexture :SKTexture
    var hp: Int
//    init(imageName: String, name: String, hp: Int) {
//        
//        self.hp = hp
//        self.name = name
//    }
    
    init(health: Int, enemyType: EnemyType) {
        self.enemy = enemyType
        backTexture = SKTexture(imageNamed: "CardBackgroundShadow")
        self.hp = health
        switch enemyType {
        case .bossFirst:
            frontTexture = SKTexture(imageNamed: "CardBackground")
        case .bossSecond:
            frontTexture = SKTexture(imageNamed: "ManaCircle")
        }
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
    var maxHp: Int
    var enemySize: CGSize
//    init(imageName: String, name: String, hp: Int) {
//        
//        self.hp = hp
//        self.name = name
//    }
    
    init(health: Int, enemyType: EnemyType) {
        self.enemy = enemyType
        backTexture = SKTexture(imageNamed: "CardBackgroundShadow")
        self.hp = health
        self.maxHp = health
        self.enemySize = CGSize.init(width: 560.0, height: 560.0)
        switch enemyType {
        case .bossFirst:
            frontTexture = SKTexture(imageNamed: "Enemy1")
        case .bossSecond:
            frontTexture = SKTexture(imageNamed: "Enemy2")
        }
        
        super.init(texture: frontTexture, color: .clear, size: enemySize)
        self.physicsBody = SKPhysicsBody(rectangleOf: self.enemySize)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = Physics.enemy
        self.physicsBody?.contactTestBitMask = Physics.card
        self.physicsBody?.collisionBitMask = Physics.none

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getDamage(with value: Int) {
        if value > 0 {
            hp = hp - value
        }
        if hp <= 0 {
            die()
        }
    }
    
    func die() {
        print("\(self.name) is ded")
    }
}

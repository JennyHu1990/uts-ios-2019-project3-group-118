//
//  Player.swift
//  Prototype 1
//
//  Created by 陳修雯 on 20/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

enum PlayerType: Int {
    case player1,
    player2,
    player3
}

//Class of player
class Player: SKSpriteNode {
    let player :PlayerType
    let frontTexture :SKTexture
    let backTexture :SKTexture
    // hp is stored in game manager
//    var hp: Int
    var playerSize: CGSize
    
    init(playerType: PlayerType) {
        self.player = playerType
        backTexture = SKTexture(imageNamed: "CardBackgroundShadow")
//        self.hp = health
        self.playerSize = CGSize.init(width: 170.0, height: 170.0)
        switch playerType {
        case .player1:
            frontTexture = SKTexture(imageNamed: "Player1")
        case .player2:
            frontTexture = SKTexture(imageNamed: "ManaCircle")
        case .player3:
            frontTexture = SKTexture(imageNamed: "ManaCircle")
        }
        
        super.init(texture: frontTexture, color: .clear, size: playerSize)
        self.physicsBody = SKPhysicsBody(rectangleOf: playerSize)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = Physics.player
        self.physicsBody?.contactTestBitMask = Physics.card | Physics.enemy
        self.physicsBody?.collisionBitMask = Physics.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

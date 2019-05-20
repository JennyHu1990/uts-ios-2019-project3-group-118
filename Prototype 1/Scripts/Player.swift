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

class Player: SKSpriteNode {
    let player :PlayerType
    let frontTexture :SKTexture
    let backTexture :SKTexture
    var hp: Int
   
    
    init(health: Int, playerType: PlayerType) {
        self.player = playerType
        backTexture = SKTexture(imageNamed: "CardBackgroundShadow")
        self.hp = health
        switch playerType {
        case .player1:
            frontTexture = SKTexture(imageNamed: "Enemy2")
        case .player2:
            frontTexture = SKTexture(imageNamed: "ManaCircle")
        case .player3:
            frontTexture = SKTexture(imageNamed: "ManaCircle")
        }
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

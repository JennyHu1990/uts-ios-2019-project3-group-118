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
    var playerSize: CGSize
    
    init(health: Int, playerType: PlayerType) {
        self.player = playerType
        backTexture = SKTexture(imageNamed: "CardBackgroundShadow")
        self.hp = health
        self.playerSize = CGSize.init(width: 200.0, height: 200.0)
        switch playerType {
        case .player1:
            frontTexture = SKTexture(imageNamed: "Player1")
        case .player2:
            frontTexture = SKTexture(imageNamed: "ManaCircle")
        case .player3:
            frontTexture = SKTexture(imageNamed: "ManaCircle")
        }
        
        super.init(texture: frontTexture, color: .clear, size: playerSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

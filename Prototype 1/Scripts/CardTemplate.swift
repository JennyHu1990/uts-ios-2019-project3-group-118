//
//  CardTemplate.swift
//  Prototype 1
//
//  Created by 胡健妮 on 16/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

enum CardType :Int {
    case attack,
    defense,
    skills
}

// 1
class CardTemplate: SKSpriteNode {
    
    let cardType :CardType
    let frontTexture :SKTexture
    let backTexture :SKTexture
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(cardType: CardType) {
        self.cardType = cardType
        backTexture = SKTexture(imageNamed: "CardBackgroundShadow")
        
        switch cardType {
        case .attack:
            frontTexture = SKTexture(imageNamed: "CardBackground")
        case .defense:
            frontTexture = SKTexture(imageNamed: "CardBackground")
        case .skills:
            frontTexture = SKTexture(imageNamed: "CardBackground")
        }
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
    }
}


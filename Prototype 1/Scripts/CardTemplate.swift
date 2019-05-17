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
    skills,
    pet
}


enum CardLevel :CGFloat {
    case board = 10
    case moving = 100
    case enlarged = 200
}


// 1
class CardTemplate: SKSpriteNode {
    
    let cardType :CardType
    let frontTexture :SKTexture
    let backTexture :SKTexture
    var chosen :Bool = false
    

    var enlarged = false
    var savedPosition = CGPoint.zero
    var chosenCard = [Int]()
    
    var maxNumberOfCard = 1
    
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
            frontTexture = SKTexture(imageNamed: "ManaCircle")
        case .skills:
            frontTexture = SKTexture(imageNamed: "CardBackground")
        case .pet:
            frontTexture = SKTexture(imageNamed: "ManaCircle")
        }
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
    }
    
    func enlarge() {
        if enlarged {
            let slide = SKAction.move(to: savedPosition, duration:0.3)
            let scaleDown = SKAction.scale(to: 1.0, duration:0.3)
            run(SKAction.group([slide, scaleDown]), completion: {
                self.enlarged = false
                self.zPosition = CardLevel.board.rawValue
            })
        } else {
            enlarged = true
            savedPosition = position
            
            zPosition = CardLevel.enlarged.rawValue
            
            if let parent = parent {
                removeAllActions()
                zRotation = 0
                let newPosition = CGPoint(x: parent.frame.midX, y: parent.frame.midY)
                let slide = SKAction.move(to: newPosition, duration:0.3)
                let scaleUp = SKAction.scale(to: 5.0, duration:0.3)
                run(SKAction.group([slide, scaleUp]))
            }
        }
    }
    func selectCard() {
        print("Selected")
    }
}

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

class defense: CardTemplate {
    var energy = Int()
    var backImage = SKTexture.self
    var cardDescription = String()
    var used = false
    func defense() {
        print("Defense")
    }
}




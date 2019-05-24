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
    buff,
    debuff
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
    var cardSize : CGSize
    var enlarged = false
    var savedPosition = CGPoint.zero
    var chosenCard = [Int]()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(cardType: CardType) {
        self.cardType = cardType
        backTexture = SKTexture(imageNamed: "CardBackgroundShadow")
        self.cardSize = CGSize.init(width: 130, height: 190)
        switch cardType {
        case .attack:
            frontTexture = SKTexture(imageNamed: "CardAttack")
        case .defense:
            frontTexture = SKTexture(imageNamed: "CardHeal")
        case .buff:
            frontTexture = SKTexture(imageNamed: "CardBuff")
        case .debuff:
            frontTexture = SKTexture(imageNamed: "CardDeBuff")
        }
        super.init(texture: frontTexture, color: .clear, size: cardSize)
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
        self.physicsBody = SKPhysicsBody(rectangleOf: self.cardSize)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = Physics.card
        self.physicsBody?.contactTestBitMask = Physics.enemy
        self.physicsBody?.collisionBitMask = Physics.none
        //        }
        
        //        super.init(texture: frontTexture, color: .clear, size: cardSize)
    }
    
    func activateCard() {
        
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


//
//  ObjectsComponents.swift
//  Prototype 1
//
//  Created by 胡健妮 on 16/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
// 1
import SpriteKit
import GameplayKit

enum CardLevel :CGFloat {
    case board = 10
    case moving = 100
    case enlarged = 200
}

class cardSpriteNode: SKSpriteNode {

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let card = atPoint(location) as? cardSpriteNode {
                card.zPosition = CardLevel.moving.rawValue
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let card = atPoint(location) as? cardSpriteNode {
                card.zPosition = CardLevel.board.rawValue
                card.removeFromParent()
                addChild(card)
            }
        }
    }
}

// 2
class ObjectComponents: GKComponent {
    
    // 3
    let node: cardSpriteNode
    
    // 4
    init(texture: SKTexture) {
        node = cardSpriteNode(texture: texture, color: .white, size: texture.size())
        super.init()
    }
    
    // 5
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

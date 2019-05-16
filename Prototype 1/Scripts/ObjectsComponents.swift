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


// 2
class ObjectComponents: GKComponent {
    
    // 3
    let node: SKSpriteNode
    
    // 4
    init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        super.init()
    }
    
    // 5
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

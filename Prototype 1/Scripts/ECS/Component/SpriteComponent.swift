//
//  SpriteComponent.swift
//  Prototype 1
//
//  Created by 胡健妮 on 17/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent {
    
    let node: SKSpriteNode
    
    init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

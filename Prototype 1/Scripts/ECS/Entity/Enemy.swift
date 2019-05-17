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

class Enemy: GKEntity {
    
    var name : String = ""
    var hp: Int = 30
    
    init(imageName: String, name: String, hp: Int) {
        super.init()
        self.hp = hp
        self.name = name
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

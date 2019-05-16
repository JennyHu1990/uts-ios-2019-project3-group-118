//
//  GameManager.swift
//  Prototype 1
//
//  Created by 胡健妮 on 16/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class GameManager {
    
    // 1
    var entities = Set<GKEntity>()
    let scene: SKScene
    
    // 2
    init(scene: SKScene) {
        self.scene = scene
    }
    
    // 3
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: ObjectComponents.self)?.node {
            scene.addChild(spriteNode)
        }
    }
    
    // 4
    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: ObjectComponents.self)?.node {
            spriteNode.removeFromParent()
        }
        
        entities.remove(entity)
    }
}

//
//  NodeManager.swift
//  Prototype 1
//
//  Created by 胡健妮 on 26/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class NodeManager {
    
    var entities = Set<SKSpriteNode>()
    let scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func add(_ entity: SKSpriteNode) {
        entities.insert(entity)
        scene.addChild(entity)
    }
    
    func remove(_ entity: SKSpriteNode) {
        entity.removeFromParent()
        entities.remove(entity)
    }

}

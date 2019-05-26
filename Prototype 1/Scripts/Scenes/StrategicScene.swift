//
//  StrategicScene.swift
//  Prototype 1
//
//  Created by 胡健妮 on 16/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

class StrategicScene: SceneClass {

    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()
    private var lastUpdateTime: TimeInterval = 0
    private var label: SKLabelNode?

    //    var gameManager: GameManager!


    override func sceneDidLoad() {

        self.lastUpdateTime = 0
    }

    override func didMove(to view: SKView) {
        // 1
        super.nodeManager = NodeManager(scene: self)
        physicsWorld.gravity = .zero

//
        // cardAttack
        let cardAttackItem1 = cardAttack1()

        cardAttackItem1.position = CGPoint(x: -size.width / 2 + 3 * cardAttackItem1.size.width, y: size.height / 2 - 2 * cardAttackItem1.size.height)
        super.nodeManager.add(cardAttackItem1)


        // 4
        let buffCard = cardBuff1()
        buffCard.position = CGPoint(x: size.width / 2 - buffCard.size.width, y: 200)
        super.nodeManager.add(buffCard)
        // 5
        let debuffCard = cardDebuff1()

        debuffCard.position = CGPoint(x: size.width / 2 - buffCard.size.width, y: 200)
        super.nodeManager.add(debuffCard)
    }


    //    override func update(_ currentTime: TimeInterval) {
    //        // Called before each frame is rendered
    //
    //        // Initialize _lastUpdateTime if it has not already been
    //        if (self.lastUpdateTime == 0) {
    //            self.lastUpdateTime = currentTime
    //        }
    //
    //        // Calculate time since last update
    //        let dt = currentTime - self.lastUpdateTime
    //
    //        // Update entities
    //        for entity in self.entities {
    //            entity.update(deltaTime: dt)
    //        }
    //
    //        self.lastUpdateTime = currentTime
    //    }
}


// Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)

//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
//    }

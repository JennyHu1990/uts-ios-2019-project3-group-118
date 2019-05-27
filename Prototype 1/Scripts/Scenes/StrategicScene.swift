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


        // cardAttack
        let cardAttackItem1 = cardAttack1()

        cardAttackItem1.position = CGPoint(x: -size.width / 2 + 1 * cardAttackItem1.size.width, y: size.height / 2 - 1 * cardAttackItem1.size.height)
        super.nodeManager.add(cardAttackItem1)
        
        // cardAttack
        let cardAttackItem2 = cardAttack2()

        cardAttackItem2.position = CGPoint(x: -size.width / 2 + 2 * cardAttackItem2.size.width, y: size.height / 2 - 1 * cardAttackItem1.size.height)
        super.nodeManager.add(cardAttackItem2)

        // cardAttack
        let cardAttackItem3 = cardAttack3()

        cardAttackItem3.position = CGPoint(x: -size.width / 2 + 3 * cardAttackItem3.size.width, y: size.height / 2 - 1 * cardAttackItem3.size.height)
        super.nodeManager.add(cardAttackItem3)

        // cardAttack
        let cardAttackItem4 = cardAttack4()

        cardAttackItem4.position = CGPoint(x: -size.width / 2 + 4 * cardAttackItem4.size.width, y: size.height / 2 - 1 * cardAttackItem4.size.height)
        super.nodeManager.add(cardAttackItem4)

        // cardAttack
        let cardAttackItem5 = cardAttack5()

        cardAttackItem5.position = CGPoint(x: -size.width / 2 + 5 * cardAttackItem5.size.width, y: size.height / 2 - 1 * cardAttackItem5.size.height)
        super.nodeManager.add(cardAttackItem5)

        // cardAttack
        let cardAttackItem6 = cardAttack6()

        cardAttackItem6.position = CGPoint(x: -size.width / 2 + 6 * cardAttackItem6.size.width, y: size.height / 2 - 1 * cardAttackItem6.size.height)
        super.nodeManager.add(cardAttackItem6)

        // cardAttack
        let cardAttackItem7 = cardAttack7()

        cardAttackItem7.position = CGPoint(x: -size.width / 2 + 7 * cardAttackItem7.size.width, y: size.height / 2 - 1 * cardAttackItem7.size.height)
        super.nodeManager.add(cardAttackItem7)

        // cardAttack
        let cardHealItem1 = cardHeal1()

        cardHealItem1.position = CGPoint(x: -size.width / 2 + 1 * cardHealItem1.size.width, y: size.height / 2 - 2 * cardHealItem1.size.height)
        super.nodeManager.add(cardHealItem1)

        let cardHealItem2 = cardHeal2()

        cardHealItem2.position = CGPoint(x: -size.width / 2 + 2 * cardHealItem2.size.width, y: size.height / 2 - 2 * cardHealItem2.size.height)
        super.nodeManager.add(cardHealItem2)

        let cardHealItem3 = cardHeal3()

        cardHealItem3.position = CGPoint(x: -size.width / 2 + 3 * cardHealItem3.size.width, y: size.height / 2 - 2 * cardHealItem3.size.height)
        super.nodeManager.add(cardHealItem3)

        let cardHealItem4 = cardHeal4()

        cardHealItem4.position = CGPoint(x: -size.width / 2 + 4 * cardHealItem4.size.width, y: size.height / 2 - 2 * cardHealItem4.size.height)
        super.nodeManager.add(cardHealItem4)


        let cardBuffItem1 = cardBuff1()

        cardBuffItem1.position = CGPoint(x: -size.width / 2 + 5 * cardBuffItem1.size.width, y: size.height / 2 - 2 * cardBuffItem1.size.height)
        super.nodeManager.add(cardBuffItem1)

        let cardBuffItem2 = cardBuff2()

        cardBuffItem2.position = CGPoint(x: -size.width / 2 + 6 * cardBuffItem2.size.width, y: size.height / 2 - 2 * cardBuffItem2.size.height)
        super.nodeManager.add(cardBuffItem2)

        let cardBuffItem3 = cardBuff3()

        cardBuffItem3.position = CGPoint(x: -size.width / 2 + 7 * cardBuffItem3.size.width, y: size.height / 2 - 2 * cardBuffItem3.size.height)
        super.nodeManager.add(cardBuffItem3)

        let cardBuffItem4 = cardBuff4()

        cardBuffItem4.position = CGPoint(x: -size.width / 2 + 8 * cardBuffItem4.size.width, y: size.height / 2 - 2 * cardBuffItem4.size.height)
        super.nodeManager.add(cardBuffItem4)


        // 5
        let debuffItem1 = cardDebuff1()

        debuffItem1.position =  CGPoint(x: -size.width / 2 + 8 * debuffItem1.size.width, y: size.height / 2 - 1 * debuffItem1.size.height)
        
       
        super.nodeManager.add(debuffItem1)

        let debuffItem2 = cardDebuff2()

        debuffItem2.position = CGPoint(x: -size.width / 2 + 9 * debuffItem2.size.width, y: size.height / 2 - 1 * debuffItem2.size.height)
        super.nodeManager.add(debuffItem2)

        let debuffItem3 = cardDebuff3()

        debuffItem3.position =  CGPoint(x: -size.width / 2 + 9 * debuffItem3.size.width, y: size.height / 2 - 2 * debuffItem3.size.height)
       
        super.nodeManager.add(debuffItem3)

        let debuffItem4 = cardDebuff4()

        debuffItem4.position = CGPoint(x: -size.width / 2 + 9 * debuffItem4.size.width, y: size.height / 2 - 3 * debuffItem4.size.height)
        super.nodeManager.add(debuffItem4)
        
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

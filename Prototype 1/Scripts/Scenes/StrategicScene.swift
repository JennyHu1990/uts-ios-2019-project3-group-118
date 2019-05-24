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
    
    //var entities = [GKEntity]()
//    var graphs = [String : GKGraph]()
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    //    var gameManager: GameManager!
    
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        // 1
        super.gameManager = GameManager(scene: self)
        physicsWorld.gravity = .zero
        
        // cardDefense
        let cardDefense1 = defense(cardType: .defense)
        let cardDefense2 = defense(cardType: .defense)
        let cardDefense3 = defense(cardType: .defense)
        let cardDefense4 = defense(cardType: .defense)
        let cardDefense5 = defense(cardType: .defense)
        //        cardDefense1.name = "cardDefense1"
        cardDefense1.position = CGPoint(x: -size.width/2 + 3*cardDefense1.size.width, y: size.height/2 - cardDefense1.size.height)
        cardDefense2.position = CGPoint(x: -size.width/2 + cardDefense1.size.width, y: size.height/2 - cardDefense2.size.height)
        cardDefense3.position = CGPoint(x: 0,  y: size.height/2 - cardDefense3.size.height)
        cardDefense4.position = CGPoint(x: size.width/2 - cardDefense1.size.width, y: size.height/2 - cardDefense4.size.height)
        cardDefense5.position = CGPoint(x: size.width/2 - 3*cardDefense1.size.width, y: size.height/2 - cardDefense5.size.height)
        super.gameManager.add(cardDefense1)
        super.gameManager.add(cardDefense2)
        super.gameManager.add(cardDefense3)
        super.gameManager.add(cardDefense4)
        super.gameManager.add(cardDefense5)
        
        // cardAttak
        let cardAttackkItem1 = cardAttack1()
        //        let cardAttackkItem2 = cardAttack2()
        //        let cardAttackkItem3 = cardAttack3()
        //        let cardAttackkItem4 = cardAttack4()
        //        let cardAttackkItem5 = cardAttack5()
        cardAttackkItem1.position = CGPoint(x: -size.width/2 + 3*cardDefense1.size.width, y: size.height/2 - 2 * cardAttackkItem1.size.height)
        //        cardAttack2.position = CGPoint(x: -size.width/2 + cardDefense1.size.width, y: size.height/2 - 2*cardAttack2.size.height)
        //        cardAttack3.position = CGPoint(x: 0,  y: size.height/2 - 2*cardAttack3.size.height)
        //        cardAttack4.position = CGPoint(x: size.width/2 - cardDefense1.size.width, y: size.height/2 - 2*cardAttack4.size.height)
        //        cardAttack5.position = CGPoint(x: size.width/2 - 3*cardDefense1.size.width, y: size.height/2 - 2*cardAttack5.size.height)
        super.gameManager.add(cardAttackkItem1)
        
        // 4
        let card3 = CardTemplate(cardType: .buff)
        card3.position = CGPoint(x: size.width/2 - card3.size.width, y:200)
        super.gameManager.add(card3)
        // 5
        let card4 = CardTemplate(cardType: .debuff)
        card4.position = CGPoint(x: size.width/2 - card3.size.width, y:200)
        super.gameManager.add(card4)
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


//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }


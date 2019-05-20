//
//  GameScene.swift
//  Prototype 1
//
//  Created by 陳修雯 on 16/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SceneClass {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func sceneDidLoad() {
        self.backgroundColor = .red
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        super.gameManager = GameManager(scene: self)
        let card1 = CardTemplate(cardType: .defense)
        card1.name = "card1"
        card1.position = CGPoint(x: -size.width/2 + 2*card1.size.width, y: 200)
        super.gameManager.add(card1)
        
        // 3
        let card2 = CardTemplate(cardType: .attack)
        card2.position = CGPoint(x: size.width/2 - card2.size.width, y:200)
        super.gameManager.add(card2)
        // 4
        let card3 = CardTemplate(cardType: .buff)
        card3.position = CGPoint(x: size.width/2 - card3.size.width, y:200)
        super.gameManager.add(card3)
        // 3
        let card4 = CardTemplate(cardType: .debuff)
        card4.position = CGPoint(x: size.width/2 - card4.size.width, y:200)
        super.gameManager.add(card4)
        
        let enemy = Enemy(health: 100, enemyType: .bossFirst)
        enemy.position = CGPoint(x: 320, y:0)
        super.gameManager.add(enemy)
//        let spiderEnemy = Enemy(imageName: "FightIcon", name: "Spider", hp: 30)
//        if let spriteComponent = spiderEnemy.component(ofType: SpriteComponent.self) {
//            spriteComponent.node.position = CGPoint(x: spriteComponent.node.size.width/2, y: size.height/2)
//        }
//        super.gameManager.add(spiderEnemy)
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
    

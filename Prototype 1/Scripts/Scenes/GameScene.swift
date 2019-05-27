//
//  GameScene.swift
//  Prototype 1
//
//  Created by 陳修雯 on 16/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import SpriteKit
import GameplayKit

/* Tracking enum for game state */
enum GameState {
    case title, ready, playing, gameOver
}

class GameScene: SceneClass {
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var healthBar: SKSpriteNode!
    var state: GameState = .title
    
    override func sceneDidLoad() {
        self.backgroundColor = .red
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        super.nodeManager = NodeManager(scene: self)
        let card1 = CardTemplate(cardType: .heal)
        card1.name = "card1"
        card1.position = CGPoint(x: -320, y: -300)
        addChild(card1)
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        // 3
        let card2 = CardTemplate(cardType: .attack)
        card2.position = CGPoint(x: -160, y:-300)
        addChild(card2)
        // 4
        let card3 = CardTemplate(cardType: .buff)
        card3.position = CGPoint(x: 0, y:-200)
        super.nodeManager.add(card3)
        // 3
        let card4 = CardTemplate(cardType: .debuff)
        card4.position = CGPoint(x: 160, y:-300)
        super.nodeManager.add(card4)
        
        let enemy = Enemy(health: 100, enemyType: .bossFirst)
        enemy.position = CGPoint(x: 320, y:0)
        enemy.zPosition = 10
        addChild(enemy)
        
        let player = Player(playerType: .player1)
        player.position = CGPoint(x: -320, y:-100)
        player.zPosition = 1
        super.nodeManager.add(player)
        
        ///Health Bar
        healthBar = childNode(withName: "healthBar") as? SKSpriteNode
        
        
        
    }
    func cardHitOther(card: SKSpriteNode, other: SKSpriteNode) {

        card.removeFromParent()
        other.removeFromParent()
        print("hit")
    }
    
    func currentTurnOrder() -> Int {
        let current = gameTurn.enemyTurn.rawValue
        
        return current
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        var health: CGFloat = 1.0 {
            didSet {
                /* Scale health bar between 0.0 -> 1.0 e.g 0 -> 100% */
                healthBar.xScale = health
            }
        }
        // Called before each frame is rendered/* Called before each frame is rendered */
        if state != .playing {
            return
        }
        /* Decrease Health */
        health -= 0.01

        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        
        self.lastUpdateTime = currentTime
    }
    
}
extension GameScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & Physics.card != 0) &&
            (secondBody.categoryBitMask & Physics.enemy != 0)) {
            if let card = firstBody.node as? SKSpriteNode,
                let enemy = secondBody.node as? SKSpriteNode {
                cardHitOther(card: card, other: enemy)
            }
        }
    }
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
    

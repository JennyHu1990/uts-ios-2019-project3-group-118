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

class StrategicScene: SKScene {

    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    var gameManager: GameManager!
    var currentCard: CardTemplate?
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        // 1
        gameManager = GameManager(scene: self)
        
        // 2
        let card1 = CardTemplate(cardType: .defense)
        card1.name = "card1"
        card1.position = CGPoint(x: -size.width/2 + 2*card1.size.width, y: 200)
        gameManager.add(card1)
        
        // 3
        let card2 = CardTemplate(cardType: .attack)
        card2.position = CGPoint(x: size.width/2 - card2.size.width, y:200)
        gameManager.add(card2)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if let card = atPoint(location) as? CardTemplate {
                currentCard = card
                currentCard?.zPosition = CardLevel.moving.rawValue
                currentCard?.removeAction(forKey: "drop")
                currentCard?.run(SKAction.scale(to: 1.3, duration: 0.25), withKey: "pickup")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchedPoint = touches.first!
        let pointToMove = touchedPoint.location(in: self)
        let moveAction = SKAction.move(to: pointToMove, duration: 0.1)// play with the duration to get a smooth movement
//        if let card = atPoint(pointToMove) as? CardTemplate {
        if currentCard != nil{
            currentCard?.run(moveAction)
        }
//        }
//        node.run(moveAction)
//        for touch in touches{
//            let location = touch.location(in: self)
        
        
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if currentCard != nil {
                currentCard?.zPosition = CardLevel.board.rawValue
                currentCard?.removeAction(forKey: "pickup")
                currentCard?.run(SKAction.scale(to: 1.0, duration: 0.25), withKey: "drop")
                currentCard = nil
//                card.removeFromParent()
//                addChild(card)
            }
            if let button = atPoint(location) as? SKSpriteNode {
                if button.name == "Start" {
                    let revealGameScene = SKTransition.fade(withDuration: 0.5)
                    let goToGameScene = GameScene(fileNamed: "GameScene")
                    goToGameScene!.scaleMode = SKSceneScaleMode.aspectFill
                    self.view?.presentScene(goToGameScene!, transition:revealGameScene)
                }
            }
        }
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


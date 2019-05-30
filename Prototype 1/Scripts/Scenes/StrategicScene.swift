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

        cardAttackItem1.position = CGPoint(x: -size.width / 2 + 5 * cardAttackItem1.size.width, y: size.height / 2 - 2 * cardAttackItem1.size.height)
        super.nodeManager.add(cardAttackItem1)
        
        // cardAttack
        let cardAttackItem2 = cardAttack2()

        cardAttackItem2.position = CGPoint(x: -size.width / 2 + 2 * cardAttackItem2.size.width, y: size.height / 2 - 1 * cardAttackItem1.size.height)
        super.nodeManager.add(cardAttackItem2)

        // cardAttack
        let cardAttackItem3 = cardAttack3()

        cardAttackItem3.position = CGPoint(x: -size.width / 2 + 9 * cardAttackItem3.size.width, y: size.height / 2 - 2 * cardAttackItem3.size.height)
        super.nodeManager.add(cardAttackItem3)

        // cardAttack
        let cardAttackItem4 = cardAttack4()

        cardAttackItem4.position = CGPoint(x: -size.width / 2 + 6 * cardAttackItem4.size.width, y: size.height / 2 - 2 * cardAttackItem4.size.height)
        super.nodeManager.add(cardAttackItem4)

        // cardAttack
        let cardAttackItem5 = cardAttack5()

        cardAttackItem5.position = CGPoint(x: -size.width / 2 + 3 * cardAttackItem5.size.width, y: size.height / 2 - 2 * cardAttackItem5.size.height)
        super.nodeManager.add(cardAttackItem5)

        // cardAttack
        let cardAttackItem6 = cardAttack6()

        cardAttackItem6.position = CGPoint(x: -size.width / 2 + 6 * cardAttackItem6.size.width, y: size.height / 2 - 1 * cardAttackItem6.size.height)
        super.nodeManager.add(cardAttackItem6)

        // cardAttack
        let cardAttackItem7 = cardAttack7()

        cardAttackItem7.position = CGPoint(x: -size.width / 2 + 8 * cardAttackItem7.size.width, y: size.height / 2 - 2 * cardAttackItem7.size.height)
        super.nodeManager.add(cardAttackItem7)

        // cardAttack
        let cardHealItem1 = cardHeal1()

        cardHealItem1.position = CGPoint(x: -size.width / 2 + 9 * cardHealItem1.size.width, y: size.height / 2 - 3 * cardHealItem1.size.height)
        super.nodeManager.add(cardHealItem1)

        let cardHealItem2 = cardHeal2()

        cardHealItem2.position = CGPoint(x: -size.width / 2 + 2 * cardHealItem2.size.width, y: size.height / 2 - 2 * cardHealItem2.size.height)
        super.nodeManager.add(cardHealItem2)

        let cardHealItem3 = cardHeal3()

        cardHealItem3.position = CGPoint(x: -size.width / 2 + 5 * cardHealItem3.size.width, y: size.height / 2 - 1 * cardHealItem3.size.height)
        super.nodeManager.add(cardHealItem3)

        let cardHealItem4 = cardHeal4()

        cardHealItem4.position = CGPoint(x: -size.width / 2 + 7 * cardHealItem4.size.width, y: size.height / 2 - 1 * cardHealItem4.size.height)
        super.nodeManager.add(cardHealItem4)


        let cardBuffItem1 = cardBuff1()

        cardBuffItem1.position = CGPoint(x: -size.width / 2 + 1 * cardBuffItem1.size.width, y: size.height / 2 - 2 * cardBuffItem1.size.height)
        super.nodeManager.add(cardBuffItem1)

        let cardBuffItem2 = cardBuff2()

        cardBuffItem2.position = CGPoint(x: -size.width / 2 + 4 * cardBuffItem2.size.width, y: size.height / 2 - 2 * cardBuffItem2.size.height)
        super.nodeManager.add(cardBuffItem2)

        let cardBuffItem3 = cardBuff3()

        cardBuffItem3.position = CGPoint(x: -size.width / 2 + 4 * cardBuffItem3.size.width, y: size.height / 2 - 1 * cardBuffItem3.size.height)
        super.nodeManager.add(cardBuffItem3)

        let cardBuffItem4 = cardBuff4()

        cardBuffItem4.position = CGPoint(x: -size.width / 2 + 9 * cardBuffItem4.size.width, y: size.height / 2 - 1 * cardBuffItem4.size.height)
        super.nodeManager.add(cardBuffItem4)


        // 5
        let debuffItem1 = cardDebuff1()

        debuffItem1.position =  CGPoint(x: -size.width / 2 + 8 * debuffItem1.size.width, y: size.height / 2 - 1 * debuffItem1.size.height)
        
       
        super.nodeManager.add(debuffItem1)

        let debuffItem2 = cardDebuff2()

        debuffItem2.position = CGPoint(x: -size.width / 2 + 7 * debuffItem2.size.width, y: size.height / 2 - 2 * debuffItem2.size.height)
        super.nodeManager.add(debuffItem2)
 

        let debuffItem3 = cardDebuff3()

        debuffItem3.position =  CGPoint(x: -size.width / 2 + 3 * debuffItem3.size.width, y: size.height / 2 - 1 * debuffItem3.size.height)
       
        super.nodeManager.add(debuffItem3)

        let debuffItem4 = cardDebuff4()

        debuffItem4.position = CGPoint(x: -size.width / 2 + 1 * debuffItem4.size.width, y: size.height / 2 - 1 * debuffItem4.size.height)
        super.nodeManager.add(debuffItem4)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // select card on first touch
        if let touch = touches.first {
            // set current touch
            let location = touch.location(in: self)
            if let card = atPoint(location) as? CardTemplate {
                // select current card
                currentCard = card
                // change the card floating height
                currentCard?.zPosition = CardLevel.moving.rawValue
                // remove the drop action
                currentCard?.removeAction(forKey: "drop")
                // run the card enlargement animation
                currentCard?.run(SKAction.scale(to: 1.3, duration: 0.25), withKey: "pickup")
                // add card to deck
                //if touch.tapCount > 1 {
                //deck?.addCard(card: currentCard!)
                // debug
                //print("Selected this card")
                //}
            }
                // check for card child i.e the card image, and do silimar thing as above
            else if let card = atPoint(location).parent as? CardTemplate {
                currentCard = card
                currentCard?.zPosition = CardLevel.moving.rawValue
                currentCard?.removeAction(forKey: "drop")
                currentCard?.run(SKAction.scale(to: 1.3, duration: 0.25), withKey: "pickup")
                //                if touch.tapCount > 1 {
                //                    deck?.addCard(card: currentCard!)
                //                    print("Selected this card")
                //                }
            }
        }
    }
    
    // move the card when the touch position change
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touchedPoint = touches.first!
//        let pointToMove = touchedPoint.location(in: self)
//        // animation for card movement
//        let moveAction = SKAction.move(to: pointToMove, duration: 0.1)
//        //        if let card = atPoint(pointToMove) as? CardTemplate {
//        if currentCard != nil {
//            currentCard?.run(moveAction)
//        }
        // experimental movement
        //        }
        //        node.run(moveAction)
        //        for touch in touches{
        //            let location = touch.location(in: self)
    }
    
    // "drop" the card when the touch end
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            // use the first touch
            let location = touch.location(in: self)
            // select the card
            if currentCard != nil {
                // change the card floating height
                GameManager.addCard(card: currentCard!)
                currentCard?.zPosition = CardLevel.board.rawValue
                // remove the pickup action
                currentCard?.removeAction(forKey: "pickup")
                // run the card drop animation
                currentCard?.run(SKAction.scale(to: 1.0, duration: 0.25), withKey: "drop")
                currentCard = nil
                //                card.removeFromParent()
                //                addChild(card)
            }
            // do similar things as above, but for start button
            if let button = atPoint(location) as? SKSpriteNode {
                if button.name == "Start"{
                    if GameManager.remainCards.count != 0 {
                        let revealGameScene = SKTransition.fade(withDuration: 1.5)
                        let goToGameScene = GameScene(fileNamed: "GameScene")
                        goToGameScene!.scaleMode = SKSceneScaleMode.aspectFill
                        self.view?.presentScene(goToGameScene!, transition: revealGameScene)
                    }
                    else {
                        let errorLabel = SKLabelNode(text: "Cannot Start Game")
                        errorLabel.position = CGPoint(x: 0, y:0)
                        errorLabel.fontSize = 80
                        errorLabel.zPosition = 100
                        addChild(errorLabel)
                        errorLabel.run(SKAction.sequence([
                            SKAction.fadeOut(withDuration: 3), 
                            SKAction.removeFromParent()]))
                    }
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

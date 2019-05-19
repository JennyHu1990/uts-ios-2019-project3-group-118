//
//  SceneClass.swift
//  Prototype 1
//
//  Created by Huu Nguyen on 17/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import Foundation

import SpriteKit
import GameplayKit

class SceneClass: SKScene {

    var currentCard: CardTemplate?
    var gameManager: GameManager!
    var deck: CardDeck?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            if let card = atPoint(location) as? CardTemplate {
                currentCard = card
                currentCard?.zPosition = CardLevel.moving.rawValue
                currentCard?.removeAction(forKey: "drop")
                currentCard?.run(SKAction.scale(to: 1.3, duration: 0.25), withKey: "pickup")
                if touch.tapCount>1{
                deck?.addCard(card: currentCard!)
                print("Selected this card")
                }
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

}

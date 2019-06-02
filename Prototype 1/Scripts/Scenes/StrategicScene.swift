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

//The player picks the card in this scene
class StrategicScene: SceneClass {
    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()
    private var lastUpdateTime: TimeInterval = 0
    private var label: SKLabelNode?
    var cardsLeft = [CardTemplate]()
    var playerSelectedCards = [CardTemplate]()
    let maxSelectCount = 5
    var selectCountNode = SKLabelNode(text: "Select:")
    var selectCount: Int {
        get {
            return playerSelectedCards.count
        }
    }
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    //Display the card and count the selected cards
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        cardsLeft = []
        cardsLeft.append(contentsOf: [cardAttack1(), cardAttack2(), cardAttack3(), cardAttack4(), cardAttack5(), cardAttack6(), cardAttack7(), cardHeal1(), cardHeal2(), cardHeal3(), cardHeal4(), cardBuff1(), cardBuff2(), cardBuff3(), cardBuff4(),  cardDebuff2(), cardDebuff3(), cardDebuff4()])
        cardsLeft.shuffle()
        
        for (index, card) in cardsLeft.enumerated() {
            var gap: CGFloat
            if index < 9 {
                gap = CGFloat(index + 1)
                card.position = CGPoint(x: -size.width / 2 + gap * card.size.width, y: size.height / 2 - 1 * card.size.height)
            } else if index < 18 {
                gap = CGFloat(index - 9 + 1)
                card.position = CGPoint(x: -size.width / 2 + gap * card.size.width, y: size.height / 2 - 2 * card.size.height)
            } else {
                gap = CGFloat(index - 18 + 1)
                card.position = CGPoint(x: -size.width / 2 + gap * card.size.width, y: size.height / 2 - 3 * card.size.height)
            }
            self.addChild(card)
        }
        selectCountNode.position = CGPoint(x: 450, y: -250)
        selectCountNode.text = "Select: 0/\(maxSelectCount)"
        addChild(selectCountNode)
    }
    
    // function for select card
    func selectCard(card: CardTemplate?) {
        if let index = cardsLeft.index(of: card!) {
            if (selectCount < maxSelectCount) {
                cardsLeft.remove(at: index)
                playerSelectedCards.append(card!)
                selectCountNode.text = "Select: \(selectCount)/\(maxSelectCount)"
                card?.selectCard()
            }
        } else if let index = playerSelectedCards.index(of: card!) {
            playerSelectedCards.remove(at: index)
            cardsLeft.append(card!)
            selectCountNode.text = "Select: \(selectCount)/\(maxSelectCount)"
            card?.selectCard()
        }
    }
    
    //Interact the card
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
                selectCard(card: currentCard)
            }
                // check for card child i.e the card image, and do silimar thing as above
            else if let card = atPoint(location).parent as? CardTemplate {
                currentCard = card
                currentCard?.zPosition = CardLevel.moving.rawValue
                currentCard?.removeAction(forKey: "drop")
                currentCard?.run(SKAction.scale(to: 1.3, duration: 0.25), withKey: "pickup")
                selectCard(card: currentCard)
            }
        }
    }
    // move the card when the touch position change
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func addCardBeforeStartGame() {
        for cardSelected in playerSelectedCards {
            GameManager.addCardToPlayerHand(card: cardSelected)
        }
        
        for cardLeft in cardsLeft {
            GameManager.addCardToRemainCards(card: cardLeft)
        }
    }
    
    // "drop" the card when the touch end
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            // use the first touch
            let location = touch.location(in: self)
            // select the card
            if currentCard != nil {
                // change the card floating height
                currentCard?.zPosition = CardLevel.board.rawValue
                // remove the pickup action
                currentCard?.removeAction(forKey: "pickup")
                // run the card drop animation
                currentCard?.run(SKAction.scale(to: 1.0, duration: 0.25), withKey: "drop")
                currentCard = nil
            }
            // do similar things as above, but for start button
            if let button = atPoint(location) as? SKSpriteNode {
                if button.name == "Start" {
                    if playerSelectedCards.count == maxSelectCount {
                        let revealGameScene = SKTransition.fade(withDuration: 1.5)
                        // add cards to game manager
                        addCardBeforeStartGame()
                        let goToGameScene = GameScene(fileNamed: "GameScene")
                        goToGameScene!.scaleMode = SKSceneScaleMode.aspectFill
                        self.view?.presentScene(goToGameScene!, transition: revealGameScene)
                    } else {
                        let errorLabel = SKLabelNode(text: "Please select \(maxSelectCount) cards")
                        errorLabel.position = CGPoint(x: 0, y: -180)
                        errorLabel.fontSize = 80
                        errorLabel.zPosition = 100
                        addChild(errorLabel)
                        errorLabel.run(SKAction.sequence([SKAction.fadeOut(withDuration: 3), SKAction.removeFromParent()]))
                    }
                }
            }
        }
    }    
}

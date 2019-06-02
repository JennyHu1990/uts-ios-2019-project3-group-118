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

class GameScene: SceneClass {
    // set some variables
    private var lastUpdateTime: TimeInterval = 0
    private var label: SKLabelNode?
    private var spinnyNode: SKShapeNode?
    private var endButton: SKSpriteNode = SKSpriteNode(imageNamed: "EndTurnButton")
    var oldLocation = CGPoint(x: 0, y: 0)
    var healthBarPlayer: SKSpriteNode!
    var energyLabelNode = SKLabelNode(text: "Energy:")
    
    //count energy when play the game
    var energyCount: Int = 0 {
        didSet {
            if energyCount < 0 {
                energyCount = 0
            }
            energyLabelNode.text = "Energy: \(energyCount)/\(GameManager.energyEachTurn)"
        }
    }
    
    //hp for enemy and player
    var enemy = Enemy(health: 100, enemyType: .bossFirst)
    var playerHealthBarValue: CGFloat = 0.0 {
        didSet {
            /* Scale health bar between 0.0 -> 1.0 e.g 0 -> 100% */
            if playerHealthBarValue < 0 {
                playerHealthBarValue = 0
            }
            healthBarPlayer.xScale = playerHealthBarValue
        }
    }
    var healthBarEnemy: SKSpriteNode!
    var enemyHealthBarValue: CGFloat = 0.0 {
        didSet {
            if enemyHealthBarValue < 0 {
                enemyHealthBarValue = 0
            }
            /* Scale health bar between 0.0 -> 1.0 e.g 0 -> 100% */
            healthBarEnemy.xScale = enemyHealthBarValue
        }
    }
    var activeCard: SKSpriteNode?
    var activeOther: SKSpriteNode?
    let cardPosition = CGPoint(x: -320, y: -220)
    var turnOrder: gameTurn = gameTurn.playerTurn


    // sceneDidLoad override
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }

    // set up initial view
    override func didMove(to view: SKView) {

        // call node manager to keep track of nodes
        super.nodeManager = NodeManager(scene: self)

        // set physic world
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self

        // initiallize end turn button
        endButton.name = "EndTurnButton"
        endButton.size = CGSize(width: 160, height: 60)
        endButton.position = CGPoint(x: 0, y: 200)
        addChild(endButton)

        energyLabelNode.position = CGPoint(x: -500, y: -250)
        addChild(energyLabelNode)

        // add card which selected from strategicScene
        for card in GameManager.holdCards {
            card.position = cardPosition
            scene?.addChild(card)
        }

        // initiallize enemy
        var enemyList = [Enemy]()
        enemy.position = CGPoint(x: 320, y: 30)
        enemy.zPosition = 10
        addChild(enemy)
        enemyList.append(enemy)

        // initiallize player
        let player = Player(playerType: .player1)
        player.position = CGPoint(x: -320, y: 0)
        player.zPosition = 1
        super.nodeManager.add(player)

        ///Initiallize health bar
        healthBarPlayer = childNode(withName: "BarPlayer")?.childNode(withName: "healthBarPlayer") as? SKSpriteNode
        healthBarPlayer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        healthBarPlayer.position = CGPoint(x: healthBarPlayer.position.x - healthBarPlayer.frame.maxX / 2, y: healthBarPlayer.position.y)
        healthBarEnemy = childNode(withName: "BarEnemy")?.childNode(withName: "healthBarEnemy") as? SKSpriteNode
        healthBarEnemy.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        healthBarEnemy.position = CGPoint(x: healthBarEnemy.position.x - healthBarEnemy.frame.maxX / 2, y: healthBarEnemy.position.y)
        playerHealthBarValue = (CGFloat)(GameManager.hp / GameManager.maxHp)
        enemyHealthBarValue = (CGFloat)(enemy.hp / enemy.maxHp)

        // start state machine
        GameManager.initialGameStateAndStart(scene: self, player: player, enemy: enemyList)
        showPlayerHoldCards()
    }

    // function to return current turn order
    func currentTurnOrder() -> Int {
        let current = turnOrder.rawValue
        return current
    }

    // update per frame function
    override func update(_ currentTime: TimeInterval) {
        energyCount = GameManager.remainEnergy
        /* Decrease Health */
        if GameManager.gameIsRunning {
            updateHealthBarValue()

            // Initialize _lastUpdateTime if it has not already been
            if (self.lastUpdateTime == 0) {
                self.lastUpdateTime = currentTime
            }

            // Calculate time since last update
            let dt = currentTime - self.lastUpdateTime

            // Update entities
            GameManager.updateGame(deltaTime: dt)

            self.lastUpdateTime = currentTime
        }
    }

    //update the hp
    func updateHealthBarValue() {
        var currentHp: CGFloat = CGFloat(GameManager.hp)
        let currentMax: CGFloat = CGFloat(GameManager.maxHp)

        if currentHp < 0 {
            currentHp = 0
        }

        self.playerHealthBarValue = currentHp / currentMax
    }
    
    //show the damage or heal
    func showDamageOrHealLabel(value: Int, node: SKSpriteNode) {
        let labelNode = SKLabelNode(fontNamed: "AvenirNext-Bold")
        if value >= 0 {
            labelNode.text = "+ \(value)"
            labelNode.fontColor = UIColor.green
        } else {
            labelNode.text = "- \(-value)"
            labelNode.fontColor = UIColor.yellow
        }

        labelNode.fontSize = 30
        labelNode.zPosition = 100
        labelNode.position = CGPoint(x: node.position.x, y: node.position.y + 50)

        self.addChild(labelNode)
        let groupAction = SKAction.group([SKAction.fadeOut(withDuration: 2), SKAction.move(by: CGVector(dx: 0, dy: 50), duration: 1.5)])
        labelNode.run(groupAction) {
            labelNode.run(.removeFromParent())
        }
    }

    
    //show the card that player hold each turn
    func showPlayerHoldCards() {
        print("show player hold cards \(GameManager.holdCards.count)")
        for (index, card) in GameManager.holdCards.enumerated() {
            card.position = CGPoint(x: -320 + CGFloat(index) * card.cardSize.width + 20, y: -220)
            card.isHidden = false
            
            if card.parent != nil {
                card.removeFromParent()
                print("debug1")
            }
            self.addChild(card)
        }
    }

    // funciont for interact the card
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // select card on first touch
        if let touch = touches.first {
            // set current touch
            let location = touch.location(in: self)
            if let card = atPoint(location) as? CardTemplate {
                currentCard = card
            }
            // check for card child i.e the card image, and do silimar thing as above
            else if let card = atPoint(location).parent as? CardTemplate {
                currentCard = card
            }

            guard let currentCard = currentCard else {
                return
            }

            if (GameManager.isAvailableToUseCard(card: currentCard)) {
                // change the card floating height
                currentCard.zPosition = CardLevel.moving.rawValue
                // remove the drop action
                currentCard.removeAction(forKey: "drop")
                // run the card enlargement animation
                currentCard.run(SKAction.scale(to: 1.3, duration: 0.25), withKey: "pickup")
            } else {
                self.currentCard = nil
                // shining the remain energy label or sth in order to remind player
                GameManager.shakeSprite(target: energyLabelNode, duration: 1.5)
                if GameManager.isAvailableToUseAnyCardInThisTurn() {
                    GameManager.shakeSprite(target: endButton, duration: 2.5)
                }
            }
        }
    }
    func activate(card: CardTemplate, enemy: SKSpriteNode) {
        
        if card is AttackCard || card is DebuffCard {
            if currentCard != nil {
                // change the card floating height
                currentCard?.zPosition = CardLevel.board.rawValue
                // remove all animation
                currentCard?.removeAllActions()
                // run the card drop animation
                currentCard?.run(SKAction.scale(to: 1.0, duration: 0.25), withKey: "drop")
                //currentCard?.removeFromParent()
                //addChild(currentCard!)
                currentCard = nil
            }
            GameManager.shakeSprite(target: enemy, duration: 1.0)
            showPlayerHoldCards()
            GameManager.useCard(card: card, enemy: enemy as? Enemy)
            
        } else {
            print("wrong interaction with \(String(describing: card.getName())) desc: \(card.getDescription())")
            showPlayerHoldCards()
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            //use the first touch
            let location = touch.location(in: self)
            // select the card
            if currentCard != nil {
                // change the card floating height
                currentCard?.zPosition = CardLevel.board.rawValue
                // remove the pickup action
                currentCard?.removeAction(forKey: "pickup")
                // run the card drop animation
                currentCard?.run(SKAction.scale(to: 1.0, duration: 0.25), withKey: "drop")
                //currentCard?.removeFromParent()
                //addChild(currentCard!)
                currentCard = nil
            }
            //do similar things as above, but for start button
            if let button = atPoint(location) as? SKSpriteNode {
                if button.name == "EndTurnButton" {
                    GameManager.enterEnemyState()
                }
            }
        }
    }
}

// physic contact delegate
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        // reorganise the two physic bodies so that the bitmask is in order
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        // run function if card interact with other
        if ((firstBody.categoryBitMask & Physics.card != 0) && (secondBody.categoryBitMask & Physics.enemy != 0)) {
            if let card = firstBody.node as? CardTemplate, let enemy = secondBody.node as? SKSpriteNode {
                if card is AttackCard || card is DebuffCard {
                    if currentCard != nil {
                        // change the card floating height
                        currentCard?.zPosition = CardLevel.board.rawValue
                        // remove all animation
                        currentCard?.removeAllActions()
                        // run the card drop animation
                        currentCard?.run(SKAction.scale(to: 1.0, duration: 0.25), withKey: "drop")
                        //currentCard?.removeFromParent()
                        //addChild(currentCard!)
                        currentCard = nil
                    }
                    GameManager.shakeSprite(target: enemy, duration: 1.0)
                    showPlayerHoldCards()
                    GameManager.useCard(card: card, enemy: enemy as? Enemy)
                    
                } else {
                    print("wrong interaction with \(String(describing: card.getName())) desc: \(card.getDescription())")
                    showPlayerHoldCards()
                }
                
            }
        } else if ((firstBody.categoryBitMask & Physics.card != 0) && (secondBody.categoryBitMask & Physics.player != 0)) {
            if let card = firstBody.node as? CardTemplate, let _ = secondBody.node as? SKSpriteNode {
                if card is HealCard || card is BuffCard {
                    if currentCard != nil {
                        // change the card floating height
                        currentCard?.zPosition = CardLevel.board.rawValue
                        // remove all animation
                        currentCard?.removeAllActions()
                        // run the card drop animation
                        currentCard?.run(SKAction.scale(to: 1.0, duration: 0.25), withKey: "drop")
                        //currentCard?.removeFromParent()
                        //addChild(currentCard!)
                        currentCard = nil
                    }
                    GameManager.useCard(card: card)
                } else {
                    print("wrong interaction with \(String(describing: card.getName())) desc: \(card.getDescription())")
                    showPlayerHoldCards()
                }
            }
        }
    }
}

// default function below


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
    

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
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var healthBarPlayer: SKSpriteNode!
    var deckCountL = SKLabelNode(text: "Cards left")
    var deckCount:String = "0" {
        didSet{
            deckCountL = SKLabelNode(text: "Cards left " + deckCount)
        }
    }
    var enemy = Enemy(health: 100, enemyType: .bossFirst)
    var healthBarValue: CGFloat = 0.0 {
        didSet {
            /* Scale health bar between 0.0 -> 1.0 e.g 0 -> 100% */
            healthBarPlayer.xScale = healthBarValue
        }
    }
    var healthBarEnemy: SKSpriteNode!
    var healthE: CGFloat = 0.0 {
        didSet {
            /* Scale health bar between 0.0 -> 1.0 e.g 0 -> 100% */
            healthBarEnemy.xScale = healthE
        }
    }
    var activeCard: SKSpriteNode?
    var activeOther: SKSpriteNode?
    let cardPosition = CGPoint(x: -320, y: -300)
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
        let endButton = SKSpriteNode(imageNamed: "EndTurnButton")
        endButton.name = "EndTurnButton"
        endButton.size = CGSize(width: 160, height: 60)
        endButton.position = CGPoint(x: 0, y: 200)
        addChild(endButton)
        
        deckCount = (String)(GameManager.remainCards.count)
        deckCountL.position = CGPoint(x: -500, y: -250)
        addChild(deckCountL)
        
        // add card which selected from strategicScene
        for card in GameManager.holdCards {
            card.position = cardPosition
            scene?.addChild(card)
        }
        
        // initiallize enemy
        enemy.position = CGPoint(x: 320, y:0)
        enemy.zPosition = 10
        addChild(enemy)
        
        // initiallize player
        let player = Player(playerType: .player1)
        player.position = CGPoint(x: -320, y:-100)
        player.zPosition = 1
        super.nodeManager.add(player)
        
        ///Initiallize health bar
        healthBarPlayer = childNode(withName: "BarPlayer")?.childNode(withName: "healthBarPlayer") as? SKSpriteNode
        healthBarEnemy = childNode(withName: "BarEnemy")?.childNode(withName: "healthBarEnemy") as? SKSpriteNode
        healthBarValue = (CGFloat)(GameManager.hp / GameManager.maxHp)
        healthE = (CGFloat)(enemy.hp / enemy.maxHp)
        
        // start state machine
        GameManager.initialGameStateAndStart(scene: self)
    }
    
    func shakeSprite(target:SKSpriteNode, duration:Float) {
        
        let position = target.position
        
        let amplitudeX:Float = 10
        let amplitudeY:Float = 6
        let numberOfShakes = duration / 0.04
        var actionsArray:[SKAction] = []
        for _ in 1...Int(numberOfShakes) {
            let moveX = Float(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2
            let moveY = Float(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2
            let shakeAction = SKAction.moveBy(x: CGFloat(moveX), y: CGFloat(moveY), duration: 0.02)
            shakeAction.timingMode = SKActionTimingMode.easeOut
            actionsArray.append(shakeAction)
            actionsArray.append(shakeAction.reversed())
        }
        
        actionsArray.append(SKAction.move(to: position, duration: 0.0))
        
        let actionSeq = SKAction.sequence(actionsArray)
        target.run(actionSeq)
    }
    
    // function to interact with cards
    func cardHitOther(card: CardTemplate, other: SKSpriteNode) {
        if other == enemy {
            card.activateCardEnemy(enemy: enemy)
        }
        card.removeFromParent()
        shakeSprite(target: other, duration: 1.0)
        //other.removeFromParent()
        print("hit")
    }
    
    // function to return current turn order
    func currentTurnOrder() -> Int {
        let current = turnOrder.rawValue
        return current
    }
    
    // update per frame function
    override func update(_ currentTime: TimeInterval) {
        /* Decrease Health */
        if  GameManager.gameIsRunning {
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
    
    func updateHealthBarValue() {
        var currentHp:CGFloat = CGFloat(GameManager.hp)
        let currentMax:CGFloat = CGFloat(GameManager.maxHp)
        
        if currentHp < 0 {
            currentHp = 0
        }
        
        self.healthBarValue = currentHp / currentMax
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
                currentCard = nil
                //                card.removeFromParent()
                //                addChild(card)
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
extension GameScene: SKPhysicsContactDelegate{
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
        if ((firstBody.categoryBitMask & Physics.card != 0) &&
            (secondBody.categoryBitMask & Physics.enemy != 0)) {
            if let card = firstBody.node as? CardTemplate,
                let enemy = secondBody.node as? SKSpriteNode {
                    cardHitOther(card: card, other: enemy)
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
    

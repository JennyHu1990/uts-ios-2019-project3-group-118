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
    // set some variables
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var healthBarPlayer: SKSpriteNode!
    var enemy = Enemy(health: 100, enemyType: .bossFirst)
    var health: CGFloat = 0.0 {
        didSet {
            /* Scale health bar between 0.0 -> 1.0 e.g 0 -> 100% */
            healthBarPlayer.xScale = health
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
    var turnOrder: gameTurn = gameTurn.playerTurn
    // set gamesgate
    lazy var gameState: GKStateMachine = GKStateMachine(states: [
        PlayerTurnState(scene: self),
        EnemyTurnState(scene: self),
        EndGameState(scene: self)])
    var state: GameState = .title
    
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
        
        // initiallize some basic cards
        let card1 = cardAttack1()
        // card position
        card1.position = CGPoint(x: -320, y: -300)
        // add card to scene
        //addChild(card1)
        
        // 2
        let card2 = cardAttack3()
        card2.position = CGPoint(x: -160, y:-300)
        addChild(card2)
        
        // 3
//        let card3 = CardTemplate(cardType: .buff)
//        card3.position = CGPoint(x: 0, y:-200)
//        super.nodeManager.add(card3)
        
        // 4
//        let card4 = CardTemplate(cardType: .debuff)
//        card4.position = CGPoint(x: 160, y:-300)
//        super.nodeManager.add(card4)
        
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
        health = (CGFloat)(GameManager.hp / GameManager.maxHp)
        healthE = (CGFloat)(enemy.hp / enemy.maxHp)
        
        // enter start game
        gameState.enter(PlayerTurnState.self)
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
    func cardHitOther(card: SKSpriteNode, other: SKSpriteNode) {
        card.removeFromParent()
        shakeSprite(target: other, duration: 1.0)
        //other.removeFromParent()
        print("hit")
        gameState.enter(EnemyTurnState.self)
    }
    
    // function to return current turn order
    func currentTurnOrder() -> Int {
        let current = turnOrder.rawValue
        return current
    }
    
    // update per frame function
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered/* Called before each frame is rendered */
//        if state != .playing {
//            return
//        }
        /* Decrease Health */
        let currentHp = (Double)(GameManager.hp)
        let currentMax = (Double)(GameManager.maxHp)
        self.health = (CGFloat)(currentHp / currentMax)
        //print(health)
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        self.gameState.update(deltaTime: dt)
        // Update entities
        
        self.lastUpdateTime = currentTime
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
            if let card = firstBody.node as? SKSpriteNode,
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
    

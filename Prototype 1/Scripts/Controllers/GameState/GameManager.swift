//
//  GameManager.swift
//  Prototype 1
//
//  Created by 胡健妮 on 16/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

//

// class to store infos
class GameManager {

    static var scene: GameScene?
    static var firstRound = false
    // Player
    static var player: Player?
    static var maxHp: Int = 50
    static var hp: Int = 50

    static var enemy: [Enemy] = []
    // Draw 5 new cards each player turn
    static var drawEachTurn = 5
    static var EnergyEachTurn = 4

    // may have 2 or more enemy in the future
//    static var targetEnemy : Enemy?

    // will resupply card if there are no remain card and player wanna get one
    private (set) static var remainCards: [CardTemplate] = []
    private (set) static var holdCards: [CardTemplate] = []
    private (set) static var usedCards: [CardTemplate] = []

    // player buff
    // TODO may set to false if end the turn
    static var nextRoundDamagePlusOne = false
    // TODO not implemented
    static var doubleDamageOfNextCard = false

    // set gamesgate
    static var gameState: GKStateMachine?

    static var gameIsRunning: Bool {
        return gameState?.currentState is PlayerTurnState || gameState?.currentState is EnemyTurnState
    }

    static func damagePlayer(with value: Int) {
        var damage = value
        if damage > 0 {
            if doubleDamageOfNextCard {
                damage = value * 2
                doubleDamageOfNextCard = false
            }
            hp = hp - damage
            scene?.showDamageOrHealLabel(value: -value, node: player!)
            shakeSprite(target: player!, duration: 1.0)
        }
        if hp <= 0 {
            playerDied()
        }
    }

    static func damageEnemy(with value: Int, enemy: Enemy) {
        if value > 0 {
            enemy.hp = enemy.hp - value
        }
        scene?.showDamageOrHealLabel(value: -value, node: enemy)
        scene?.enemyHealthBarValue = CGFloat(enemy.hp)/CGFloat(enemy.maxHp)
        if hp <= 0 {
            enemy.die()
        }

    }

    static func addCardToRemainCards(card: CardTemplate) {
        if card.parent != nil {
            card.removeFromParent()
            card.isHidden = true
        }
        remainCards.append(card)
    }

    static func addCardToPlayerHand(card: CardTemplate) {
        if card.parent != nil {
            card.removeFromParent()
            card.isHidden = true
        }
        card.isSelected = false
        holdCards.append(card)
    }

    // Slay the spire style
    static func removeCardsOnHandAndDrawNew() {
        usedCards.append(contentsOf: holdCards)
        drawRandomCards(count: drawEachTurn)
    }

    static func healPlayer(with value: Int) {
        if value > 0 {
            GameManager.hp = GameManager.hp + value
            GameManager.hp = GameManager.hp > GameManager.maxHp ? GameManager.maxHp : GameManager.hp
            scene?.showDamageOrHealLabel(value: value, node: player!)
        }
    }

    // add card to player's own cards
    // 
    static func drawRandomCards(count: Int = 1) {
        for _ in 0..<count {
            if remainCards.count > 0 {
                let randomCard = remainCards.randomElement()!
                holdCards.append(randomCard)
                if let index = remainCards.index(of: randomCard) {
                    remainCards.remove(at: index)
                }
            } else {
                if usedCards.count > 0 {
                    remainCards.append(contentsOf: usedCards)
                    usedCards = []
                    let randomCard = remainCards.randomElement()!
                    holdCards.append(randomCard)
                    if let index = remainCards.index(of: randomCard) {
                        remainCards.remove(at: index)
                    }
                } else {
                    print("No card left in remainCards")
                }
            }
        }
    }

    // throw one random card
    static func throwRandomCard() {
        if holdCards.count > 0 {
            let randomCard = holdCards.randomElement()!
            throwCards(with: [randomCard])
        }
    }

    // when player use one card
    static func throwCards(with cards: [CardTemplate]) {
        usedCards.append(contentsOf: cards)
        for card in cards {
            if let index = holdCards.index(of: card) {
                holdCards.remove(at: index)
            }
        }
    }

    static func useCard(card: CardTemplate, enemy: Enemy? = nil, completion: (() -> Void)? = nil) {
        if card is AttackCard || card is DebuffCard {
//            if enemy == nil {
//                print("Have to assign an enemy")
//                return
//            }
//            card.activateCardEnemy(enemy: targetEnemy!)
            if let enemy = enemy {
                card.activateCardEnemy(enemy: enemy)
                throwCards(with: [card])
                card.removeFromParent()
                card.isHidden = true
                scene?.deckCount = remainCards.count
            } else {
                print("enemy is nil")
            }
        } else if card is HealCard || card is BuffCard {
            card.activateCardPlayer()
            throwCards(with: [card])
            card.removeFromParent()
            card.isHidden = true
            scene?.deckCount = remainCards.count
        }

        if let callback = completion {
            callback()
        }
    }

    static func shakeSprite(target: SKSpriteNode, duration: Float) {

        let position = target.position

        let amplitudeX: Float = 10
        let amplitudeY: Float = 6
        let numberOfShakes = duration / 0.04
        var actionsArray: [SKAction] = []
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

    static func initialGameStateAndStart(scene: GameScene, player: Player) {
        gameState = GKStateMachine(states: [PlayerTurnState(scene: scene), EnemyTurnState(scene: scene), EndGameState(scene: scene), LoseGameState(scene: scene)])
        self.player = player
        self.scene = scene
        self.firstRound = true
        gameState?.enter(PlayerTurnState.self)
        hp = maxHp
    }

    static func updateGame(deltaTime: Double) {
        self.gameState?.update(deltaTime: deltaTime)
    }

    static func enterEnemyState() {
        self.gameState?.enter(EnemyTurnState.self)
    }

    // ded boi
    static func playerDied() {
        print("player is ded")
        gameState?.enter(LoseGameState.self)
        return
    }


}

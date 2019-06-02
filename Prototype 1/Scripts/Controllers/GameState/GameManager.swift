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
    // TODO
//    Use card1 : -2
//    heal card place in the center of scene should place it in original place

    static var scene: GameScene?
    static var firstRound = false
    // Player
    static var player: Player?
    static var maxHp: Int = 500
    static var hp: Int = 500

    static var enemyList: [Enemy] = []
    // Draw 5 new cards each player turn
    static var drawEachTurn = 5
    static var energyEachTurn = 4
    private (set) static var remainEnergy = energyEachTurn

    // may have 2 or more enemy in the future
//    static var targetEnemy : Enemy?

    // will resupply card if there are no remain card and player wanna get one
    private (set) static var remainCards: [CardTemplate] = []
    private (set) static var holdCards: [CardTemplate] = []
    private (set) static var usedCards: [CardTemplate] = []

    // player buff
    static var thisRoundDamagePlusOne = false
    static var doubleDamageOfNextCard = false
    static var skipPlayer = false
    // TODO if need to add more enemy in one scene, the code in enemy state should be modified
    static var skipAllEnemy = false
    static var reduceEnemyTwoDamage = false
    
    // Second Enemy
    static var secondEnemyComeUp = false


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
            playerDie()
        }
    }

    static func damageEnemy(with value: Int, enemy: Enemy) {
        var damageValue = value
        if thisRoundDamagePlusOne {
            damageValue = damageValue + 1
        }
        if reduceEnemyTwoDamage {
            damageValue = damageValue - 2
        }
        if doubleDamageOfNextCard {
            damageValue = damageValue * 2
        }

        // for testing
//        if enemy.enemyType == .bossFirst{
//            damageValue = 100
//        }
        
        if damageValue > 0 {
            if damageValue > enemy.hp {
                enemy.hp = 0
            } else {
                enemy.hp = enemy.hp - damageValue
            }
        }
        scene?.showDamageOrHealLabel(value: -damageValue, node: enemy)
        scene?.enemyHealthBarValue = CGFloat(enemy.hp) / CGFloat(enemy.maxHp)
        if enemy.hp <= 0 {
            enemy.die()
            if !secondEnemyComeUp {
                print("second Enemy Come Up")
                showSecondEnemy()
            }
            if let index = enemyList.index(of: enemy) {
                enemyList.remove(at: index)
                if enemyList.isEmpty && secondEnemyComeUp {
                    playerWin()
                }
            }
        }
    }
    
    private static func showSecondEnemy() {
        let secondEnemy = Enemy(health: 50, enemyType: .bossSecond)
        secondEnemy.position = CGPoint(x: 320, y: 30)
        secondEnemy.zPosition = 10
        secondEnemy.size = CGSize(width: 200.0, height: 200.0)
        scene?.addChild(secondEnemy)
        enemyList.append(secondEnemy)
        scene?.enemyHealthBarValue = CGFloat(secondEnemy.hp) / CGFloat(secondEnemy.maxHp)
        secondEnemyComeUp = true
    }

    static func addCardToRemainCards(card: CardTemplate) {
        if card.parent != nil {
            throwCardInASecretPlace(card: card)
        }
        remainCards.append(card)
    }

    static func addCardToPlayerHand(card: CardTemplate) {
        if card.parent != nil {
            card.removeFromParent()
        }
        card.isSelected = false
        holdCards.append(card)
    }

    // Slay the spire style
    static func drawCardsOnNewTurn() {
        drawRandomCards(count: drawEachTurn)
        scene?.showPlayerHoldCards()
    }

    static func removeCardsOnHand() {
        for card in holdCards {
            
            throwCardInASecretPlace(card: card)
        }
        usedCards.append(contentsOf: holdCards)
        holdCards = []
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
        print("Draw random cards")
        for _ in 0..<count {
            if remainCards.count > 0 {
                addRandomCardFromRemainCardsToHoldCards()
            } else {
                if usedCards.count > 0 {
                    print("remain card count = 0")
                    remainCards.append(contentsOf: usedCards)
                    usedCards = []
                    addRandomCardFromRemainCardsToHoldCards()
                } else {
                    print("No card left in remainCards and usedCards")
                }
            }
        }
        //scene?.showPlayerHoldCards()
    }

    private static func addRandomCardFromRemainCardsToHoldCards() {
        print(remainCards.count)
        let randomCard = remainCards.randomElement()!
        holdCards.append(randomCard)
        if let index = remainCards.index(of: randomCard) {
            remainCards.remove(at: index)
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
        
        for card in cards {
            if let index = holdCards.index(of: card) {
                throwCardInASecretPlace(card: card)
                usedCards.append(card)
                holdCards.remove(at: index)
            }
        }
        scene?.showPlayerHoldCards()
    }

    // remove card from scene in order to prevent physical issue
    private static func throwCardInASecretPlace(card: CardTemplate) {
        
        card.removeFromParent()
    }

    static func useCard(card: CardTemplate, enemy: Enemy? = nil/*, completion: (() -> Void)? = nil*/) {
        if card is AttackCard || card is DebuffCard {
            if let enemy = enemy {
                if isAvailableToUseCard(card: card) {
                    card.activateCardEnemy(enemy: enemy)
                    remainEnergy -= card.getEnergy()
                    print("Use card\(card.getName()) remain: \(remainEnergy) energy")
                    throwCards(with: [card])
                }
            } else {
                print("enemy is nil")
            }
        } else if card is HealCard || card is BuffCard {
            card.activateCardPlayer()
            card.removeFromParent()
            throwCards(with: [card])
            remainEnergy -= card.getEnergy()
        }
//        if let callback = completion {
//            callback()
//        }
    }

    static func isAvailableToUseCard(card: CardTemplate) -> Bool {
        return card.getEnergy() <= remainEnergy
    }

    static func isAvailableToUseAnyCardInThisTurn() -> Bool {
        for card in holdCards {
            if remainEnergy >= card.getEnergy() {
                return true
            }
        }
        return false
    }

    static func fillEnergy() {
        remainEnergy = energyEachTurn
    }

    static func shakeSprite(target: SKNode, duration: Float) {

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

    static func initialGameStateAndStart(scene: GameScene, player: Player, enemy: [Enemy]) {
        gameState = GKStateMachine(states: [PlayerTurnState(scene: scene), EnemyTurnState(scene: scene), EndGameState(scene: scene), LoseGameState(scene: scene)])
        self.player = player
        self.enemyList = enemy
        self.scene = scene
        self.firstRound = true
        remainEnergy = energyEachTurn
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
    static func playerDie() {
        print("player is dead")
        removeAllCardsParent()
        gameState?.enter(LoseGameState.self)
        return
    }

    static func playerWin() {
        print("player win")
        removeAllCardsParent()
        gameState?.enter(EndGameState.self)
    }

    static func removeAllCardsParent() {
        let allCards: [CardTemplate] = remainCards + usedCards + holdCards
        for card in allCards {
            card.removeFromParent()
        }
        remainCards = []
        usedCards = []
        holdCards = []
        secondEnemyComeUp = false
    }
}

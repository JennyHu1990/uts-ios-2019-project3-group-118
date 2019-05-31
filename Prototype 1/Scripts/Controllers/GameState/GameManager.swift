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
    
    // Player
    static var maxHp: Int = 50
    static var hp: Int = 50
    
    static var enemy:[Enemy] = []
    // Draw 5 new cards each player turn
    static var drawEachTurn = 5
    
    // will resupply card if there are no remain card and player wanna get one
    private (set) static var remainCards : [CardTemplate] = []
    private (set) static var holdCards: [CardTemplate] = []
    private (set) static var usedCards : [CardTemplate] = []
    
    // player buff
    // TODO may set to false if end the turn
    static var nextRoundDamagePlusOne = false
    // TODO not implemented
    static var doubleDamageOfNextCard = false
    
    // set gamesgate
    static var gameState: GKStateMachine?
    
    static var gameIsRunning : Bool {
        return gameState?.currentState is PlayerTurnState || gameState?.currentState is EnemyTurnState
    }
    
    static func damagePlayer(with value: Int) {
        var damage = value
        if damage > 0 {
            if doubleDamageOfNextCard {
                damage = value * 2
                doubleDamageOfNextCard = false
            }
            GameManager.hp = GameManager.hp - damage
        }
        if GameManager.hp <= 0 {
            playerDied()
        }
    }
    
    static func addCardToRemainCards(card: CardTemplate){
        if card.parent != nil {
            card.removeFromParent()
        }
        remainCards.append(card)
    }
    
    static func addCardToPlayerHand(card: CardTemplate){
        if card.parent != nil {
            card.removeFromParent()
        }
        holdCards.append(card)
        print(card.name)
    }
    
    // Slay the spire style
    static func removeCardsOnHandAndDrawNew() {
        usedCards.append(contentsOf: holdCards)
        drawRandomCards(count: drawEachTurn)
    }
    
    static func healPlayer(with value: Int) {
        if value > 0 {
            GameManager.hp = GameManager.hp + value
            GameManager.hp = GameManager.hp>GameManager.maxHp ? GameManager.maxHp : GameManager.hp
        }
    }
    
    // add card to player's own cards
    // 
    static func drawRandomCards(count : Int = 1) {
        for _ in 0 ..< count {
            if remainCards.count > 0 {
                let randomCard = remainCards.randomElement()!
                holdCards.append(randomCard)
                if let index = remainCards.index(of: randomCard){
                    remainCards.remove(at: index)
                }
            } else {
                if usedCards.count > 0 {
                    remainCards.append(contentsOf: usedCards)
                    usedCards = []
                    let randomCard = remainCards.randomElement()!
                    holdCards.append(randomCard)
                    if let index = remainCards.index(of: randomCard){
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
    static func throwCards(with cards: [CardTemplate]){
        usedCards.append(contentsOf: cards)
        for card in cards {
            if let index = holdCards.index(of: card){
                holdCards.remove(at: index)
            }
        }
    }
    
    static func initialGameStateAndStart(scene: GameScene) {
        gameState = GKStateMachine(states: [
            PlayerTurnState(scene: scene),
            EnemyTurnState(scene: scene),
            EndGameState(scene: scene),
            LoseGameState(scene: scene)
        ])
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

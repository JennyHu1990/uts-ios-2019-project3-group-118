//
//  StartGameState.swift
//  Prototype 1
//
//  Created by Huu Nguyen on 24/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class PlayerTurnState: GKState {
    var scene: GameScene?
    var winningLabel: SKNode!
    var resetNode: SKNode!
    var boardNode: SKNode!

    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == EnemyTurnState.self || stateClass == EndGameState.self || stateClass == LoseGameState.self
    }

    override func didEnter(from previousState: GKState?) {
//        let currentHp = (Double)(GameManager.hp)
//        let currentMax = (Double)(GameManager.maxHp)
//        
//        // Player die
//        if currentHp <= 0 {
//            self.health = 0
//            print("lose game")
//            gameState.enter(LoseGameState.self)
//            return
//        }
//        
//        self.health = (CGFloat)(currentHp / currentMax)
        updateGameState()
        
    }

    override func update(deltaTime: TimeInterval) {
        //resetGame()
        //print("still player turn")
        //self.stateMachine?.enter(ActiveGameState.self)
    }

    override func willExit(to nextState: GKState) {
        if GameManager.thisRoundDamagePlusOne {
            GameManager.thisRoundDamagePlusOne.toggle()
        }
        if GameManager.doubleDamageOfNextCard {
            GameManager.doubleDamageOfNextCard.toggle()
        }
        GameManager.removeCardsOnHand()
    }

    func updateGameState() {
        assert(scene != nil, "Scene must not be nil")
        print("player turn")

        GameManager.fillEnergy()
        if GameManager.skipPlayer {
            GameManager.skipPlayer.toggle()
            return
        }
        if GameManager.reduceEnemyTwoDamage {
            GameManager.reduceEnemyTwoDamage.toggle()
            return
        }
        
        if GameManager.firstRound {
            GameManager.firstRound.toggle()
        } else {
            print("remove card and redraw")
            GameManager.drawCardsOnNewTurn()
            scene?.showPlayerHoldCards()
        }
        //if let card1 = GameManager.drawRandomCards()! {
        //let card1 = GameManager.drawRandomCards()!
        // card1.position = (scene?.cardPosition)!
        // scene?.addChild(card1)
        //}
    }

}





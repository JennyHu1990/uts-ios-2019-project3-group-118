//
//  EnemyTurnState.swift
//  Prototype 1
//
//  Created by Huu Nguyen on 28/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//
//


import Foundation
import GameplayKit
import SpriteKit

enum gameTurn: Int {
    case playerTurn, enemyTurn
}

class EnemyTurnState: GKState {
    var scene: GameScene?
    var waitingOnPlayer: Bool
    
    init(scene: GameScene) {
        self.scene = scene
        waitingOnPlayer = false
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == EndGameState.self || stateClass == PlayerTurnState.self || stateClass == LoseGameState.self
    }
    
    override func didEnter(from previousState: GKState?) {
        updateGameState()
        self.stateMachine?.enter(PlayerTurnState.self)
    }
    
    override func update(deltaTime: TimeInterval) {
        assert(scene != nil, "Scene must not be nil")
    }
    
    func updateGameState() {
        assert(scene != nil, "Scene must not be nil")
        assert(scene?.enemy.hp != nil, "enemy hp must not be nil")
        if GameManager.skipAllEnemy {
            GameManager.skipAllEnemy.toggle()
            return
        }
        
        switch GameManager.enemyList[0].enemyType {
        case .bossFirst:
            GameManager.damagePlayer(with: 5)
            print("enemy 1 turn")
        case .bossSecond:
            GameManager.damagePlayer(with: 10)
            print("enemy 2 turn")
        }
    }
}

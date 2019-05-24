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

class StartGameState: GKState{
    var scene: GameScene?
    var winningLabel: SKNode!
    var resetNode: SKNode!
    var boardNode: SKNode!
    
    init(scene: GameScene){
        self.scene = scene
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        <#code#>
    }
    
    
    override func update(deltaTime: TimeInterval) {
        resetGame()
        self.stateMachine?.enter(ActiveGameState.self)
    }
    
    func resetGame(){
        
    }
}





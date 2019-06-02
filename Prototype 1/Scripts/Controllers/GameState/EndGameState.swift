//
//  EndGameState.swift
//  Prototype 1
//
//  Created by Huu Nguyen on 24/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class EndGameState: GKState{
    var scene: GameScene?
    
    init(scene: GameScene){
        self.scene = scene
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == PlayerTurnState.self
    }
    
    override func didEnter(from previousState: GKState?) {
        updateGameState()
    }
    
    func updateGameState(){
        let revealScene = SKTransition.fade(withDuration: 1.5)
        let goToEndScene = SKScene(fileNamed: "EndScene")
        goToEndScene!.scaleMode = SKSceneScaleMode.aspectFill
        scene?.view?.presentScene(goToEndScene!, transition: revealScene)
    }
}

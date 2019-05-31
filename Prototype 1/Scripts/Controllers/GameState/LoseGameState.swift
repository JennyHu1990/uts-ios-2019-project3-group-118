//
//  EndGameState.swift
//  Prototype 1
//
//  Created by Huu Nguyen on 31/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class LoseGameState: GKState{
    var scene: GameScene?
    
    init(scene: GameScene){
        self.scene = scene
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == PlayerTurnState.self
    }
    
    override func didEnter(from previousState: GKState?) {
        print("Enter lose scene")
        updateGameState()
    }
    
    func updateGameState(){
        let revealGameScene = SKTransition.fade(withDuration: 1.5)
        let goToGameScene = SKScene(fileNamed: "LoseScene")
        goToGameScene!.scaleMode = SKSceneScaleMode.aspectFill
        scene?.view?.presentScene(goToGameScene!, transition: revealGameScene)
    }
}

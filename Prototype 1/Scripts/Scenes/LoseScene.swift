//
//  LoseScene.swift
//  Prototype 1
//
//  Created by 陳修雯 on 1/6/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import SpriteKit
import GameplayKit

class LoseScene: SceneClass {

    private var restartButton: SKSpriteNode = SKSpriteNode(imageNamed: "RestartGame")

    override func didMove(to view: SKView) {
        restartButton.name = "RestartGameButton"
        restartButton.size = CGSize(width: 210, height: 60)
        restartButton.position = CGPoint(x: 0, y: -150)
        addChild(restartButton)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            //use the first touch
            let location = touch.location(in: self)
            if let button = atPoint(location) as? SKSpriteNode {
                if button.name == "RestartGameButton" {
                    let revealScene = SKTransition.fade(withDuration: 1.5)
                    let goToStrategicScene = SKScene(fileNamed: "StrategicScene")
                    goToStrategicScene!.scaleMode = SKSceneScaleMode.aspectFill
                    scene?.view?.presentScene(goToStrategicScene!, transition: revealScene)
                }
            }
        }
    }
}
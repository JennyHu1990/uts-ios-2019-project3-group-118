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




class ActiveGameState: GKState{
    var scene: GameScene?
    var waitingOnPlayer: Bool
    
    init(scene: GameScene){
        self.scene = scene
        waitingOnPlayer = false
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == EndGameState.self
    }
    
    override func didEnter(from previousState: GKState?) {
        waitingOnPlayer = false
    }
    
    override func update(deltaTime: TimeInterval) {
        assert(scene != nil, "Scene must not be nil")
        
        if !waitingOnPlayer{
            waitingOnPlayer = true
            updateGameState()
        }
    }
    
    func updateGameState(){
        assert(scene != nil, "Scene must not be nil")
        
        self.waitingOnPlayer = false
        self.scene?.isUserInteractionEnabled = true
        
//        let (state, winner) = self.scene!.gameBoard!.determineIfWinner()
//        if state == .Winner{
//            let winningLabel = self.scene?.childNodeWithName("winningLabel")
//            winningLabel?.hidden = true
//            let winningPlayer = self.scene!.gameBoard!.isPlayerOne(winner!) ? "1" : "2"
//            if let winningLabel = winningLabel as? SKLabelNode,
//                let player1_score = self.scene?.childNodeWithName("//player1_score") as? SKLabelNode,
//                let player2_score = self.scene?.childNodeWithName("//player2_score") as? SKLabelNode{
//                winningLabel.text = "Player \(winningPlayer) wins!"
//                winningLabel.hidden = false
//
//                if winningPlayer == "1"{
//                    player1_score.text = "\(Int(player1_score.text!)! + 1)"
//                }
//                else{
//                    player2_score.text = "\(Int(player2_score.text!)! + 1)"
//                }
//
//                self.stateMachine?.enterState(EndGameState.self)
//                waitingOnPlayer = false
//            }
//        }
//        else if state == .Draw{
//            let winningLabel = self.scene?.childNodeWithName("winningLabel")
//            winningLabel?.hidden = true
//
//
//            if let winningLabel = winningLabel as? SKLabelNode{
//                winningLabel.text = "It's a draw"
//                winningLabel.hidden = false
//            }
//            self.stateMachine?.enterState(EndGameState.self)
//            waitingOnPlayer = false
//        }
//
//        else if self.scene!.gameBoard!.isPlayerTwoTurn(){
//            //AI moves
//            self.scene?.userInteractionEnabled = false
//
//            assert(scene != nil, "Scene must not be nil")
//            assert(scene?.gameBoard != nil, "Gameboard must not be nil")
//
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//                self.scene!.ai.gameModel = self.scene!.gameBoard!
//                let move = self.scene!.ai.bestMoveForActivePlayer() as? Move
//
//                assert(move != nil, "AI should be able to find a move")
//
//                let strategistTime = CFAbsoluteTimeGetCurrent()
//                let delta = CFAbsoluteTimeGetCurrent() - strategistTime
//                let  aiTimeCeiling: NSTimeInterval = 1.0
//
//                let delay = min(aiTimeCeiling - delta, aiTimeCeiling)
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay) * Int64(NSEC_PER_SEC)), dispatch_get_main_queue()) {
//
//                    guard let cellNode: SKSpriteNode = self.scene?.childNodeWithName(self.scene!.gameBoard!.getElementAtBoardLocation(move!.cell).node) as? SKSpriteNode else{
//                        return
//                    }
//                    let circle = SKSpriteNode(imageNamed: "O_symbol")
//                    circle.size = CGSize(width: 75, height: 75)
//                    cellNode.addChild(circle)
//                    self.scene!.gameBoard!.addPlayerValueAtBoardLocation(move!.cell, value: .O)
//                    self.scene!.gameBoard!.togglePlayer()
//                    self.waitingOnPlayer = false
//                    self.scene?.userInteractionEnabled = true
//                }
//            }
//        }
//        else{

        
    }
}


class EndGameState: GKState{
    var scene: GameScene?
    
    init(scene: GameScene){
        self.scene = scene
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == StartGameState.self
    }
    
    override func didEnter(from previousState: GKState?) {
        updateGameState()
    }
    
    func updateGameState(){
        let resetNode = self.scene?.childNode(withName: "Reset")
        resetNode?.isHidden = false
    }
}




//
class GameManager {

    // 1
    var entities = Set<SKSpriteNode>()
    let scene: SKScene

    // 2
    init(scene: SKScene) {
        self.scene = scene
    }

    // 3
    func add(_ entity: SKSpriteNode) {
        entities.insert(entity)
        scene.addChild(entity)
    }

    // 4
    func remove(_ entity: SKSpriteNode) {
        entity.removeFromParent()
        entities.remove(entity)
    }
}

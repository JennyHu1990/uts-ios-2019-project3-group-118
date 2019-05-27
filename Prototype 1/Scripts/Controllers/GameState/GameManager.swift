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
class GameManager {    //
    
    // Player
    static var maxHp: Int = 50
    static var hp: Int = 50
    static var enemy:[Enemy] = []
    // will resupply card if there are no remain card and player wanna get one
    static var remainCards : [CardTemplate] = []
    static var holdCards: [CardTemplate] = []
    static var usedCards : [CardTemplate] = []
    
    
    // player buff
    // TODO may set to false if end the turn
    static var nextRoundDamagePlusOne = false
    // TODO not implemented
    static var doubleDamageOfNextCard = false
    
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
    
    static func healPlayer(with value: Int) {
        if value > 0 {
            GameManager.hp = GameManager.hp + value
            GameManager.hp = GameManager.hp>GameManager.maxHp ? GameManager.maxHp : GameManager.hp
        }
    }
    
    // add card to player's own cards
    static func drawRandomCards(count : Int = 1) {
        for _ in 0 ..< count {
            if remainCards.count>0 {
                let randomCard = remainCards.randomElement()!
                holdCards.append(randomCard)
                if let index = remainCards.index(of: randomCard){
                    remainCards.remove(at: index)
                }
            } else {
                if usedCards.count > 0 {
                    remainCards.append(contentsOf: usedCards)
                    usedCards = []
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
    
    static func playerDied() {
        print("player is died")
    }
    
}

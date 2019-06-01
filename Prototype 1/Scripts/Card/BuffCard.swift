//
//  DefendCard.swift
//  Prototype 1
//
//  Created by Huu Nguyen on 17/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit


class BuffCard: CardTemplate {
//    var backImage = SKTexture.self
    var used = false
    func defense() {
        print("Defense")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(energy: Int) {
        super.init(cardType: .buff)
    }

    init(name: String, energy: Int, imageName: String, description: String) {
        super.init(cardType: .buff)
        self.setImage(with: imageName)
        self.setName(with: name)
        self.setEnergy(with: energy)
        self.setDescription(with: description)
    }
}

//Energy 1
//Gain 2 cards
class cardBuff1: BuffCard {
    init() {
        super.init(name: "Buff1", energy: 1, imageName: "CardBuffImage1", description: "Gain 2 cards")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardPlayer() {
        GameManager.drawRandomCards(count: 2)
    }
}

//Energy 2
//Increase next round damage +1
class cardBuff2: BuffCard {
    init() {
        super.init(name: "Buff2", energy: 1, imageName: "CardBuffImage2", description: "Increase 1 Damage this round")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardPlayer() {
        GameManager.thisRoundDamagePlusOne = true
    }
}

//Energy 2
//Double the damage of next card
class cardBuff3: BuffCard {
    init() {
        super.init(name: "Buff3", energy: 2, imageName: "CardBuffImage3", description: "Double damage of next card")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardPlayer() {
        GameManager.doubleDamageOfNextCard = true
    }
}

//Energy 2
//Damage player 3 hp
//Gain 3 cards
class cardBuff4: BuffCard {
    init() {
        super.init(name: "Buff4", energy: 2, imageName: "CardBuffImage4", description: "3 Damage - player \nGain 3 cards")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardPlayer() {
        GameManager.damagePlayer(with: 3)
        GameManager.drawRandomCards(count: 3)
    }
}

//
//  DefendCard.swift
//  Prototype 1
//
//  Created by Huu Nguyen on 17/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit

//Sub class of Card Template
class BuffCard: CardTemplate {
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

//Buff Card 1
class cardBuff1: BuffCard {
    init() {
        super.init(name: "Buff 1", energy: 1, imageName: "CardBuffImage1", description: "Gain 2 cards")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardPlayer() {
        GameManager.drawRandomCards(count: 2)
    }
}

//Buff Card 2
class cardBuff2: BuffCard {
    init() {
        super.init(name: "Buff 2", energy: 1, imageName: "CardBuffImage2", description: "Increase 1 Damage this round")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardPlayer() {
        GameManager.thisRoundDamagePlusOne = true
    }
}

//Buff Card 3
class cardBuff3: BuffCard {
    init() {
        super.init(name: "Buff 3", energy: 2, imageName: "CardBuffImage3", description: "Double damage of next card")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardPlayer() {
        GameManager.doubleDamageOfNextCard = true
    }
}

//Buff Card 4
class cardBuff4: BuffCard {
    init() {
        super.init(name: "Buff 4", energy: 2, imageName: "CardBuffImage4", description: "3 Damage - player \nGain 3 cards")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardPlayer() {
        GameManager.damagePlayer(with: 3)
        GameManager.drawRandomCards(count: 3)
    }
}

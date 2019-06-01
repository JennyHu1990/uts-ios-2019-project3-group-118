//
//  DefendCard.swift
//  Prototype 1
//
//  Created by Huu Nguyen on 17/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit


class DebuffCard: CardTemplate {
//    var backImage = SKTexture.self
    var used = false

    func defense() {
        print("Defense")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(energy: Int) {
        super.init(cardType: .debuff)
    }

    init(name: String, energy: Int, imageName: String, description: String) {
        super.init(cardType: .debuff)
        self.setImage(with: imageName)
        self.setName(with: name)
        self.setEnergy(with: energy)
        self.setDescription(with: description)
    }
}

//Energy 2
//Enemy sclient 2 rounds
class cardDebuff1: DebuffCard {
    init() {
        super.init(name: "Debuff1", energy: 2, imageName: "CardDebuffImage1", description: "Sclience all Enemies 2 turns")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardEnemy(enemy: Enemy) {
        // TODO
    }
}

//Energy 2
//Enemy lost 2 hp for 2 round
//Slient player 1 round
class cardDebuff2: DebuffCard {
    init() {
        super.init(name: "Debuff2", energy: 2, imageName: "CardDebuffImage2", description: "2 damage 2 turns \nSlience player 1 turn")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardEnemy(enemy: Enemy) {
        // TODO
    }
}

//Energy 3
//All enemy Sclient 1 round
class cardDebuff3: DebuffCard {
    init() {
        super.init(name: "Debuff3", energy: 3, imageName: "CardDebuffImage3", description: "Sclience All enemies 1 turn")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardEnemy(enemy: Enemy) {
        // TODO
    }
}

//Energy 2
//Reduce the 2hp damage of enemy in next turn
class cardDebuff4: DebuffCard {
    init() {
        super.init(name: "Debuff4", energy: 2, imageName: "CardDebuffImage4", description: "Reduce 2 damage in next turn")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activateCardEnemy(enemy: Enemy) {
        // TODO
    }
}

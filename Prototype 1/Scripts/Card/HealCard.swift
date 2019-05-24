//
//  DefendCard.swift
//  Prototype 1
//
//  Created by Huu Nguyen on 17/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit


class HealCard: CardTemplate {
//    var backImage = SKTexture.self
    var used = false
    func defense() {
        print("Defense")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(energy: Int) {
        super.init(cardType: .heal)
    }

    init(name: String, energy: Int, imageName: String, description: String) {
        super.init(cardType: .heal)
        self.setImage(with: imageName)
        self.setName(with: name)
        self.setEnergy(with: energy)
        self.setDescription(with: description)
    }
}



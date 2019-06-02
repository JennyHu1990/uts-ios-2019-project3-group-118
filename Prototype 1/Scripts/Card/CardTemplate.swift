//
//  CardTemplate.swift
//  Prototype 1
//
//  Created by 胡健妮 on 16/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

enum CardType: Int {
    case attack,
         heal,
         buff,
         debuff
}


enum CardLevel: CGFloat {
    case board = 10
    case moving = 100
    case enlarged = 200
}


//Super Class of all the cards
class CardTemplate: SKSpriteNode {

    let cardType: CardType
    let frontTexture: SKTexture
    let backTexture: SKTexture
    var chosen: Bool = false
    var cardSize: CGSize
    var enlarged = false
    var savedPosition = CGPoint.zero
    var chosenCard = [Int]()
    var isSelected = false {
        didSet {
            highLightNode.isHidden = !isSelected
        }
    }

    // node
    var energyNode = SKLabelNode(fontNamed: "Chalkduster")
    var nameNode = SKLabelNode(fontNamed: "Chalkduster")
    var imageNode = SKSpriteNode(imageNamed: "CardAttackImage1")
    var highLightNode = SKSpriteNode(imageNamed: "CardShine")
    var descNode = SKLabelNode(fontNamed: "Chalkduster")

    // card attribute
    private var energy: Int = 1
    private var cardName: String = ""
    private var cardDescription: String = ""
    private var cardImage: String = ""

    init(cardType: CardType) {
        self.cardType = cardType
        backTexture = SKTexture(imageNamed: "CardBackgroundShadow")
        self.cardSize = CGSize(width: 130, height: 190)

        switch cardType {
        case .attack:
            frontTexture = SKTexture(imageNamed: "CardAttack")
        case .heal:
            frontTexture = SKTexture(imageNamed: "CardHeal")
        case .buff:
            frontTexture = SKTexture(imageNamed: "CardBuff")
        case .debuff:
            frontTexture = SKTexture(imageNamed: "CardDeBuff")
        }
        super.init(texture: frontTexture, color: .clear, size: cardSize)
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
        self.physicsBody = SKPhysicsBody(rectangleOf: self.cardSize)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = Physics.card
        self.physicsBody?.contactTestBitMask = Physics.enemy
        self.physicsBody?.collisionBitMask = Physics.none
        //        }

        //        super.init(texture: frontTexture, color: .clear, size: cardSize)
        self.initialUINode()
    }

//    convenience init(cardType: CardType, name: String, energy: Int, imageName: String) {
//        self.init(cardType: cardType)
//        setName(with: name)
//        setEnergy(with: energy)
//        setImage(with: imageName)
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    func initialUINode() {
//        energyNode.text = "1"
        energyNode.fontSize = 16
        energyNode.fontColor = SKColor.white
        energyNode.position = CGPoint(x: -50, y: 73)
        energyNode.preferredMaxLayoutWidth = 110
        super.addChild(energyNode)

        nameNode.fontSize = 12
        nameNode.fontColor = SKColor.black
        nameNode.position = CGPoint(x: 0, y: -20)
        nameNode.preferredMaxLayoutWidth = 90
        super.addChild(nameNode)

        descNode.fontSize = 10
        descNode.fontColor = SKColor.black
        descNode.preferredMaxLayoutWidth = 100
        descNode.numberOfLines = 2
        descNode.horizontalAlignmentMode = .center
        descNode.position = CGPoint(x: 0, y: -(190 / 5))
        descNode.verticalAlignmentMode = .top
        super.addChild(descNode)

//        imageNode = SKSpriteNode(imageNamed: "CardAttackImage2")
//        imageNode.position = CGPoint(x: 0, y: 0)
//        imageNode.zPosition = -1
////        imageNode.zPosition = -1
//        super.addChild(imageNode)

        highLightNode.zPosition = -1.5
        highLightNode.position = CGPoint(x: highLightNode.position.x + 2, y: highLightNode.position.y - 7)
        highLightNode.size = CGSize(width: 130, height: 190)
        highLightNode.isHidden = true
        super.addChild(highLightNode)

    }

    func setEnergy(with value: Int) {
        energyNode.text = "\(value)"
        self.energy = value
    }

    func getEnergy() -> Int {
        return self.energy
    }

    func setName(with value: String) {
        nameNode.text = "\(value)"
        self.cardName = value
    }

    func getName() -> String {
        return self.cardName
    }

    func setDescription(with value: String) {
        descNode.text = "\(value)"
        self.cardDescription = value
    }

    func getDescription() -> String {
        return self.cardDescription
    }

    func setImage(with fileName: String) {
        self.cardImage = fileName
        imageNode = SKSpriteNode(imageNamed: fileName)
        imageNode.position = CGPoint(x: 0, y: 30)
        imageNode.zPosition = -1
        super.addChild(imageNode)
//        imageNode.isUserInteractionEnabled = false
    }

    func getImageName() -> String {
        return self.cardImage
    }

    func activateCardEnemy(enemy: Enemy) {
        print("Need to be implement")
    }
    func activateCardPlayer(){
        print("Need to be implement")
    }

    
    // enlarge the card when pressed
    func enlarge() {
        if enlarged {
            let slide = SKAction.move(to: savedPosition, duration: 0.3)
            let scaleDown = SKAction.scale(to: 1.0, duration: 0.3)
            run(SKAction.group([slide, scaleDown]), completion: {
                self.enlarged = false
                self.zPosition = CardLevel.board.rawValue
            })
        } else {
            enlarged = true
            savedPosition = position

            zPosition = CardLevel.enlarged.rawValue

            if let parent = parent {
                removeAllActions()
                zRotation = 0
                let newPosition = CGPoint(x: parent.frame.midX, y: parent.frame.midY)
                let slide = SKAction.move(to: newPosition, duration: 0.3)
                let scaleUp = SKAction.scale(to: 5.0, duration: 0.3)
                run(SKAction.group([slide, scaleUp]))
            }
        }
    }
    
    //select cards to play the game
    func selectCard() {
        print("Selected")
        isSelected = !isSelected
    }
}


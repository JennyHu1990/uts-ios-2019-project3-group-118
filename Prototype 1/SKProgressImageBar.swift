//
//  SKProgressImageBar.swift
//  Prototype 1
//
//  Created by 陳修雯 on 25/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//
import SpriteKit
import GameplayKit

class SKProgressImageBar: SKNode {
    var baseSprite: SKSpriteNode!
    var coverSprite: SKSpriteNode!
    var originalCoverSprite: SKSpriteNode!
    override init() {
        super.init()
    }
    convenience init(baseImageName:String="", coverImageName:String="", baseColor: SKColor, coverColor: SKColor, size: CGSize ) {
        self.init()
        self.baseSprite = baseImageName.isEmpty ? SKSpriteNode(color: baseColor, size: size) : SKSpriteNode(texture: SKTexture(imageNamed:baseImageName), size: size)
        self.coverSprite = coverImageName.isEmpty ? SKSpriteNode(color: coverColor, size: size) : SKSpriteNode(texture: SKTexture(imageNamed:coverImageName), size: size)
        self.originalCoverSprite = self.coverSprite.copy() as! SKSpriteNode
        self.addChild(baseSprite)
        self.addChild(coverSprite)
        self.coverSprite.zPosition = 2.0
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setProgress(_ value:CGFloat) {
        print("Set progress bar to: \(value)")
        guard 0.0 ... 1.0 ~= value else { return }
        self.coverSprite.texture = self.originalCoverSprite.texture
        let originalSize = self.baseSprite.size
        var calculateFraction:CGFloat = 0.0
        self.coverSprite.position = self.baseSprite.position
        if value == 1.0 {
            calculateFraction = originalSize.width
        } else if 0.01..<1.0 ~= value {
            calculateFraction = originalSize.width * value
        }
        
        let coverRect = CGRect(origin: self.baseSprite.frame.origin, size: CGSize(width:calculateFraction,height:self.baseSprite.size.height))
        if let parent = self.parent, parent is SKScene, let parentView = (parent as! SKScene).view {
            if let texture = parentView.texture(from: self.originalCoverSprite, crop: coverRect) {
                let sprite = SKSpriteNode(texture:texture)
                self.coverSprite.texture = sprite.texture
                self.coverSprite.size = sprite.size
            }
            if value == 0.0 {
                self.coverSprite.texture = SKTexture()
                self.coverSprite.size = CGSize.zero
            }
            if value>0.0 && value<1.0 {
                let calculateFractionForPosition = originalSize.width - (originalSize.width * value)
                self.coverSprite.position = CGPoint(x:(self.coverSprite.position.x-calculateFractionForPosition)/2,y:self.coverSprite.position.y)
            }
        }
    }
}

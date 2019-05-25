//
//  Physics.swift
//  Prototype 1
//
//  Created by 胡健妮 on 23/5/19.
//  Copyright © 2019 Siou-Wun Chen. All rights reserved.
//

import Foundation
import SpriteKit

struct Physics {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let card: UInt32 = 0x1 << 0
    static let player: UInt32 = 0x1 << 1
    static let enemy: UInt32 = 0x1 << 2
}

//
//  Building.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-20.
//  Copyright © 2016 Cameron Bardell. All rights reserved.
//

import UIKit
import SpriteKit

class Building: SKSpriteNode {
    //Lane, ramp, and xPosition vars
    var lane: Int
    var hasRamp: Bool
    var xPosition: CGFloat
    var lastBuilding: Bool
    var right: Bool
    init(lane: Int, hasRamp: Bool, lastBuilding: Bool, right: Bool) {
        let texture : SKTexture
        self.right = right
        if self.right {
            texture = SKTexture(imageNamed: "BuildingLeft")
        }
        else {
            texture = SKTexture(imageNamed: "BuildingRight")
        }
        self.lane = lane
        self.hasRamp = hasRamp
        self.xPosition = 384
        self.lastBuilding = lastBuilding
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        self.lane = 2
        self.right = false
        self.hasRamp = false
        self.xPosition = 384
        self.lastBuilding = false
        super.init(coder: aDecoder)
    }
}

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
    init(lane: Int, hasRamp: Bool, lastBuilding: Bool) {
        let texture : SKTexture
        self.lane = lane
        switch lane {
        case 0:
            texture = SKTexture(imageNamed: "BuildingRight")
        case 1:
            texture = SKTexture(imageNamed: "BuildingMiddle")
        case 2:
            texture = SKTexture(imageNamed: "BuildingLeft")
        default:
            texture = SKTexture(imageNamed: "BuildingMiddle")
        }
        self.hasRamp = hasRamp
        self.xPosition = 384
        self.lastBuilding = lastBuilding
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        self.lane = 2
        self.hasRamp = false
        self.xPosition = 384
        self.lastBuilding = false
        super.init(coder: aDecoder)
    }
}

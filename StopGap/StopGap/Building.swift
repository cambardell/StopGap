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
    init(lane: Int, hasRamp: Bool) {
        let texture = SKTexture(imageNamed: "Building")
        self.lane = lane
        self.hasRamp = hasRamp
        self.xPosition = 384
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        self.lane = 2
        self.hasRamp = false
        self.xPosition = 384
        super.init(coder: aDecoder)
    }
}

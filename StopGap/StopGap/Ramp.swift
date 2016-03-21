//
//  Ramp.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-20.
//  Copyright © 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit

class Ramp: SKSpriteNode {
    var lane:Int
    init(lane:Int) {
        let texture : SKTexture
        self.lane = lane
        switch lane {
        case 0:
            texture = SKTexture(imageNamed: "RampLeft")
        case 1:
            texture = SKTexture(imageNamed: "RampMiddle")
        case 2:
            texture = SKTexture(imageNamed: "RampRight")
        default:
            texture = SKTexture(imageNamed: "RampMiddle")
        }
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.lane = 2
        super.init(coder: aDecoder)
    }

}

//
//  Ramp.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-20.
//  Copyright © 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit

class Ramp: SKSpriteNode {
    var right:Bool
    init(right:Bool) {
        let texture : SKTexture
        self.right = right
        if right {
            texture = SKTexture(imageNamed: "RampRight")
        }
        else {
            texture = SKTexture(imageNamed: "RampLeft")
        }
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.right = true
        super.init(coder: aDecoder)
    }

}

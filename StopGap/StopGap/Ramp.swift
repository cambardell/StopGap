//
//  Ramp.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-20.
//  Copyright © 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit

class Ramp: SKSpriteNode {
    init() {
        let texture = SKTexture(imageNamed: "Ramp")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

//
//  Stairs.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-25.
//  Copyright © 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit

class Stairs: SKSpriteNode {
    init() {
        let texture = SKTexture(imageNamed: "Stairs")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

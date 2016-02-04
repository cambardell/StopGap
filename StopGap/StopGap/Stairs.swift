//
//  Stairs.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-25.
//  Copyright © 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit

class Stairs: SKSpriteNode {
    var right:Bool
    init(right:Bool) {
        let texture : SKTexture
        self.right = right
        if right {
            texture = SKTexture(imageNamed: "StairsRight")
        }
        else {
            texture = SKTexture(imageNamed: "StairsLeft")
        }
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        self.right = true
        super.init(coder: aDecoder)
    }

}

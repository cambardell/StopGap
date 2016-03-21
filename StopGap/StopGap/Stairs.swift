//
//  Stairs.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-25.
//  Copylane © 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit

class Stairs: SKSpriteNode {
    var lane:Int
    init(lane:Int) {
        var texture : SKTexture
        self.lane = lane
        switch lane {
        case 0:
            texture = SKTexture(imageNamed: "StairsLeft")
        case 1:
            texture = SKTexture(imageNamed: "StairsMiddle")
        case 2:
            texture = SKTexture(imageNamed: "StairsRight")
        default:
            texture = SKTexture(imageNamed: "StairsMiddle")
        }
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        self.lane = 2
        super.init(coder: aDecoder)
    }

}

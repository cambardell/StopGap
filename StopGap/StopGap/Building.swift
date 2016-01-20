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
    var hasRamp:Bool
    init() {
        self.hasRamp = false
        let texture = SKTexture(imageNamed: "Building")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    required init?(coder aDecoder: NSCoder) {
        self.hasRamp = false
        super.init(coder: aDecoder)
    }
}

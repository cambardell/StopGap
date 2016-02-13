//
//  RampMan.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-14.
//  Copyright © 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit

class RampMan: SKSpriteNode {
    //Lane vars
    var laneOne:Bool
    var laneTwo:Bool
    var laneThree:Bool
    init(position: CGPoint) {
        var texture : SKTexture
        //Switch the skin of the rampman based on the skin the user selected
        switch roundVars.rampSkin {
        case "RampMan":
             texture = SKTexture(imageNamed: "RampMan")
        case "Walker":
             texture = SKTexture(imageNamed: "RampMan")
        case "Stroller":
             texture = SKTexture(imageNamed: "RampMan")
        default:
             texture = SKTexture(imageNamed: "RampMan")
        }
        
        self.laneOne = false
        self.laneTwo = true
        self.laneThree = false
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: texture.size().width/2)
        self.physicsBody!.dynamic = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.laneOne = false
        self.laneTwo = true
        self.laneThree = false
        super.init(coder: aDecoder)
        
    }
}

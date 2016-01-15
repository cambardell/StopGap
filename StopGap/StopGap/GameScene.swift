 //
//  GameScene.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-14.
//  Copyright (c) 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var rampMan = SKSpriteNode()

    override func didMoveToView(view: SKView) {
        addMan(CGPointMake(frame.size.width/10, frame.size.height/2))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        for touch in touches {
            let touchposition = touch.locationInNode(self)
            if touchposition.y > 512 {
                moveMan(1)
            }
            if touchposition.y < 512 && touchposition.y > 256 {
                moveMan(2)
            }
            if touchposition.y < 256 {
                moveMan(3)
            }
        }

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    func addMan (position: CGPoint) {
        // returns a new man
        rampMan = RampMan(position: position)
        self.addChild(rampMan)

    }
    
    func moveMan(lane: Int) {
        switch lane {
        case 1:
            print("one")
            rampMan.position.y = 640
        case 2:
            print("two")
            rampMan.position.y = 384
        case 3:
            print("three")
            rampMan.position.y = 128
        default:
             break
        }
        
    }
}

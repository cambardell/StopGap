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
    var line = SKShapeNode()
    var line2 = SKShapeNode()

    override func didMoveToView(view: SKView) {
        addMan(CGPointMake(frame.size.width/2, frame.size.height/10))
        line = SKShapeNode(rectOfSize: CGSize(width: 1, height: frame.size.height))
        line.fillColor = SKColor.blackColor()
        line.strokeColor = SKColor.blackColor()
        line.lineWidth = 0.1
        line.position = CGPoint(x: frame.size.width/1.5, y: frame.size.height/2)
        addChild(line)
        line2 = SKShapeNode(rectOfSize: CGSize(width: 1, height: frame.size.height))
        line2.fillColor = SKColor.blackColor()
        line2.strokeColor = SKColor.blackColor()
        line2.position = CGPoint(x: frame.size.width/3, y: frame.size.height/2)
        addChild(line2)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let touchposition = touch.locationInNode(self)
            if touchposition.x > frame.size.width/1.5 {
                moveMan(1)
            }
            if touchposition.x < frame.size.width/1.5 && touchposition.x > frame.size.width/3 {
                moveMan(2)
            }
            if touchposition.x < frame.size.width/3 {
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
        let stopRampMan = (SKAction.runBlock({
            print("done")
            self.rampMoveEnded()
        }))
        switch lane {
        case 1:
            print("one")
            rampMoveEnded()
            let moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/1.2, rampMan.position.y), duration: 0.5))
            let moveAction = (SKAction.sequence([moveRampMan, stopRampMan]))
            rampMan.runAction(moveAction)
        case 2:
            print("two")
            rampMoveEnded()
            let moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/2, rampMan.position.y), duration: 0.5))
            let moveAction = (SKAction.sequence([moveRampMan, stopRampMan]))
            rampMan.runAction(moveAction)
        case 3:
            print("three")
            rampMoveEnded()
            let moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/6, rampMan.position.y), duration: 0.5))
            let moveAction = (SKAction.sequence([moveRampMan, stopRampMan]))
            rampMan.runAction(moveAction)

        default:
             break
        }
        
    }
    
    func rampMoveEnded() {
        rampMan.removeAllActions()
    }
}

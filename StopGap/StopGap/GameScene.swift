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
    var rampManMoveRight = false
    var laneNumber = 2

    override func didMoveToView(view: SKView) {
        addMan(CGPointMake(frame.size.width/2, frame.size.height/10))
        addLine(CGPoint(x: frame.size.width/1.5, y: frame.size.height), startPoint: CGPoint(x: frame.size.width/1.5, y: 0))
        addLine(CGPoint(x: frame.size.width/3, y: frame.size.height), startPoint: CGPoint(x: frame.size.width/3, y: 0))
        
        }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let touchposition = touch.locationInNode(self)
            if touchposition.x > frame.size.width/1.5 {
                laneNumber = 1
                moveMan(1)
            }
            if touchposition.x < frame.size.width/1.5 && touchposition.x > frame.size.width/3 {
                moveMan(2)
                
                if laneNumber == 1 {
                    rampManMoveRight = true
                }
                if laneNumber == 3 {
                    rampManMoveRight = false
                }
                laneNumber = 2
            }
            if touchposition.x < frame.size.width/3 {
                moveMan(3)
                laneNumber = 3
            }
        }

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    func addMan (position: CGPoint) {
        // returns a new man
        rampMan = RampMan(position: position)
        rampMan.setScale(3)
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
            rampMan.zRotation = 0
            let rotate = SKAction.rotateByAngle(-0.5, duration: 0.1)
            let endRotation = SKAction.rotateByAngle(0.5, duration: 0.1)
            let moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/1.2, rampMan.position.y), duration: 0.5))
            let moveAction = (SKAction.sequence([rotate, moveRampMan, endRotation, stopRampMan]))
            rampMan.runAction(moveAction)
        case 2:
            print("two")
            rampMoveEnded()
            var rotate = SKAction()
            var endRotation = SKAction()
            rampMan.zRotation = 0
            if rampManMoveRight {
                rotate = SKAction.rotateByAngle(0.5, duration: 0.1)
                endRotation = SKAction.rotateByAngle(-0.5, duration: 0.1)
            }
            if !rampManMoveRight {
                rotate = SKAction.rotateByAngle(-0.5, duration: 0.1)
                endRotation = SKAction.rotateByAngle(0.5, duration: 0.1)
            }
            let moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/2, rampMan.position.y), duration: 0.5))
            let moveAction = (SKAction.sequence([rotate, moveRampMan, endRotation, stopRampMan]))
            rampMan.runAction(moveAction)
        case 3:
            print("three")
            let rotate = SKAction.rotateByAngle(0.5, duration: 0.1)
            let endRotation = SKAction.rotateByAngle(-0.5, duration: 0.1)
            rampMoveEnded()
            rampMan.zRotation = 0
            let moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/6, rampMan.position.y), duration: 0.5))
            let moveAction = (SKAction.sequence([rotate, moveRampMan, endRotation, stopRampMan]))
            rampMan.runAction(moveAction)

        default:
             break
        }
        
    }
    
    func rampMoveEnded() {
        rampMan.removeAllActions()
    }
    
    func addLine(endPoint: CGPoint, startPoint: CGPoint) {
        let path = CGPathCreateMutable()
        let line = SKShapeNode()
        CGPathMoveToPoint(path, nil, startPoint.x, startPoint.y)
        CGPathAddLineToPoint(path,nil, endPoint.x, endPoint.y)
        line.path = path
        line.fillColor = SKColor.blackColor()
        line.strokeColor = SKColor.blackColor()
        line.lineWidth = 1
        addChild(line)

    }
}

 //
//  GameScene.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-14.
//  Copyright (c) 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    //ramp man vars
    var rampMan = SKSpriteNode()
    var rampManMoveRight = false
    
    //lane vars
    var laneNumber = 2
    
    //building vars
    var buildings = [Building]()
    var buildingSpeed:CGFloat = 10.0
    

    override func didMoveToView(view: SKView) {
        //Initialize objects
        addMan(CGPointMake(frame.size.width / 2, frame.size.height / 9))
        addLine(CGPoint(x: frame.size.width / 1.5, y: frame.size.height), startPoint: CGPoint(x: frame.size.width/1.5, y: 0))
        addLine(CGPoint(x: frame.size.width / 3, y: frame.size.height), startPoint: CGPoint(x: frame.size.width/3, y: 0))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        for touch in touches {
            let touchposition = touch.locationInNode(self)
            if touchposition.x > frame.size.width / 1.5 {
                rampManMoveRight = true
                moveMan(1)
            }
            if touchposition.x < frame.size.width / 1.5 && touchposition.x > frame.size.width / 3 {
                moveMan(2)
                
                if laneNumber == 1 {
                    rampManMoveRight = true
                }
                if laneNumber == 3 {
                    rampManMoveRight = false
                }
            }
            if touchposition.x < frame.size.width/3 {
                moveMan(3)
                rampManMoveRight = false
            }
        }

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //Set the lane number
        if rampMan.position.x > frame.size.width / 1.5 {
            laneNumber = 1
        }
        if rampMan.position.x < frame.size.width / 1.5 && rampMan.position.x < frame.size.width/3 {
            laneNumber = 2
        }
        if rampMan.position.x < frame.size.width / 3 {
            laneNumber = 3
        }
        //Add Buildings
        addBuilding(2, hasRamp: false)
        moveBuilding()
        
    }
    
    func addMan (position: CGPoint) {
        // returns a new man
        rampMan = RampMan(position: position)
        rampMan.size.width = frame.size.width/8
        rampMan.size.height = frame.size.width/8
        self.addChild(rampMan)

    }
    
    //Move the ramp man
    func moveMan(lane: Int) {
        let stopRampMan = (SKAction.runBlock({
            self.rampMoveEnded()
        }))
        switch lane {
        case 1:
            rampMoveEnded()
            rampMan.zRotation = 0
            let rotate = SKAction.rotateByAngle(-0.5, duration: 0.1)
            let endRotation = SKAction.rotateByAngle(0.5, duration: 0.1)
            let moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/1.2, rampMan.position.y), duration: 0.3))
            let moveAction = (SKAction.sequence([rotate, moveRampMan, endRotation, stopRampMan]))
            rampMan.runAction(moveAction)
        case 2:
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
            let moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/2, rampMan.position.y), duration: 0.3))
            let moveAction = (SKAction.sequence([rotate, moveRampMan, endRotation, stopRampMan]))
            rampMan.runAction(moveAction)
        case 3:
            let rotate = SKAction.rotateByAngle(0.5, duration: 0.1)
            let endRotation = SKAction.rotateByAngle(-0.5, duration: 0.1)
            rampMoveEnded()
            rampMan.zRotation = 0
            let moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/6, rampMan.position.y), duration: 0.3))
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
    
    func addBuilding(lane: Int, hasRamp: Bool) {
        //Add a new building in the correct lane
        let building = Building(lane: lane, hasRamp: hasRamp)
        print(building.xPosition)
        print(building.lane)
        buildings.append(building)
        switch lane {
        case 1:
            building.xPosition = frame.size.width / 3.0
        case 2:
            building.xPosition = frame.size.width / 2.0
        case 3:
            building.xPosition = frame.size.width / 1.5
        default:
            building.xPosition = frame.size.width / 2.0
        }
        building.position = CGPoint(x: building.xPosition, y: frame.size.height + 100)
        addChild(building)
    }
    
    func moveBuilding() {
        //Move the buildings
        for building in buildings {
            building.position.y = building.position.y - buildingSpeed
        }
    }
}

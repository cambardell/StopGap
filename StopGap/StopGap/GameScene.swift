 //
//  GameScene.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-14.
//  Copyright (c) 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    //ramp man vars
    var rampMan = SKSpriteNode()
    var rampManMoveRight = false
    var startingLane = 2
    
    //lane vars
    var laneNumber = 2
    
    //building vars
    var buildings = [Building]()
    var buildingSpeed:CGFloat = 10.0
    var timeToBuilding: CFTimeInterval = 0.5
    var lastBuilding: CFTimeInterval = 0.0
    var buildingDuration = 5.0
    
    //Ramp vars
    var ramps = [Ramp]()
    
    //Collision vars
    var rampCollision = 0x1 << 1
    var rampManCollision = 0x1 << 2
    var stairCollision = 0x1 << 3
    
    
    //MARK: Did move to view
    override func didMoveToView(view: SKView) {
        //Initialize objects
        addMan(CGPointMake(frame.size.width / 2, frame.size.height / 9))
        addLine(CGPoint(x: frame.size.width / 1.5, y: frame.size.height), startPoint: CGPoint(x: frame.size.width/1.5, y: 0))
        addLine(CGPoint(x: frame.size.width / 3, y: frame.size.height), startPoint: CGPoint(x: frame.size.width/3, y: 0))
        self.physicsWorld.contactDelegate = self
    }
    
    //MARK: Update
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //Set the lane number
        print(laneNumber)
        if rampMan.position.x > frame.size.width / 1.5 {
            laneNumber = 1
        }
        
        if rampMan.position.x < frame.size.width / 1.5 && rampMan.position.x > frame.size.width/3 {
            laneNumber = 2
        }
        
        if rampMan.position.x < frame.size.width / 3 {
            laneNumber = 3
        }
        if currentTime - lastBuilding > timeToBuilding {
            let random = Int((arc4random_uniform(2)))
            switch random {
            case 0:
                addBuilding(false)
            case 1:
                addBuilding(true)
            default:
                addBuilding(true)
            }
            
            lastBuilding = currentTime + timeToBuilding
        }
        
    }
    
    //MARK: Touches
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        for touch in touches {
            let touchposition = touch.locationInNode(self)
            //Call the move function with the correct lane as the parameter.
            //When moving to the middle, specify if it is moving from the left side or right side.
            if touchposition.x > frame.size.width / 1.5 {
                rampManMoveRight = true
                moveMan(1)
            }
            if touchposition.x < frame.size.width / 1.5 && touchposition.x > frame.size.width / 3 && laneNumber != 2{
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
   
    //MARK: Man funcs
    func addMan (position: CGPoint) {
        //Returns a new man. Takes position as a parameter.
        rampMan = RampMan(position: position)
        rampMan.size.width = frame.size.width/8
        rampMan.size.height = frame.size.width/8
        rampMan.physicsBody = SKPhysicsBody(rectangleOfSize: rampMan.size)
        rampMan.physicsBody?.categoryBitMask = UInt32(rampManCollision)
        rampMan.physicsBody?.dynamic = true
        rampMan.physicsBody?.contactTestBitMask = UInt32(rampCollision)
        rampMan.physicsBody?.collisionBitMask = 0
        rampMan.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(rampMan) 
    }
    
    //Move the ramp man. Takes the correct lane as a parameter. 
    func moveMan(lane: Int) {
        let stopRampMan = (SKAction.runBlock({
            self.rampManMoveEnded()
        }))
        //Moves man to the appropriate lane with the correct rotation
        switch lane {
        case 1:
            let rotate = SKAction.rotateByAngle(-0.5, duration: 0.05)
            let endRotation = SKAction.rotateByAngle(0.5, duration: 0.05)
            var moveRampMan = SKAction()
            //If statement changes duration based on how far the man has to travel
            if startingLane == 1 {
                moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/1.2, rampMan.position.y), duration: 0.4))
            }
            if startingLane == 2 {
                moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/1.2, rampMan.position.y), duration: 0.2))
            }
            let moveAction = (SKAction.sequence([rotate, moveRampMan, endRotation, stopRampMan]))
            
            rampManMoveEnded()
            rampMan.zRotation = 0
            rampMan.runAction(moveAction)
            startingLane = 3
       
        case 2:
            rampManMoveEnded()
            var rotate = SKAction()
            var endRotation = SKAction()
            rampMan.zRotation = 0
           
            if rampManMoveRight {
                rotate = SKAction.rotateByAngle(0.5, duration: 0.05)
                endRotation = SKAction.rotateByAngle(-0.5, duration: 0.05)
            }
            
            if !rampManMoveRight {
                rotate = SKAction.rotateByAngle(-0.5, duration: 0.05)
                endRotation = SKAction.rotateByAngle(0.5, duration: 0.05)
            }
           
            let moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/2, rampMan.position.y), duration: 0.2))
            let moveAction = (SKAction.sequence([rotate, moveRampMan, endRotation, stopRampMan]))
            rampMan.runAction(moveAction)
            startingLane = 2
      
        case 3:
            let rotate = SKAction.rotateByAngle(0.5, duration: 0.05)
            let endRotation = SKAction.rotateByAngle(-0.5, duration: 0.05)
            var moveRampMan = SKAction()
            //If statement changes duration based on how far the man has to travel
            if startingLane == 3 {
                moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/6, rampMan.position.y), duration: 0.4))
            }
            if startingLane == 2 {
                moveRampMan = (SKAction.moveTo(CGPointMake(frame.size.width/6, rampMan.position.y), duration: 0.2))
            }
            
            let moveAction = (SKAction.sequence([rotate, moveRampMan, endRotation, stopRampMan]))

            rampManMoveEnded()
            rampMan.zRotation = 0
            rampMan.runAction(moveAction)
            startingLane = 1

        default:
             break
        }
        
    }
    //Ends all of the ramp man's movements
    func rampManMoveEnded() {
        rampMan.removeAllActions()
    }
    
    //Temporary border lines
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
    
    //MARK: Building funcs
    //Returns a new building, takes a boolean for ramp as a parameter.
    func addBuilding(hasRamp: Bool) {
        //Add a new building in the correct lane
        let lane = Int((arc4random_uniform(3)))
        let building = Building(lane: lane, hasRamp: hasRamp)
        
        buildings.append(building)
       
        switch lane {
        case 0:
            building.xPosition = frame.size.width / 6
        case 1:
            building.xPosition = frame.size.width / 2
        case 2:
            building.xPosition = frame.size.width / 1.2
        default:
            building.xPosition = frame.size.width / 2
        }
        building.position = CGPoint(x: building.xPosition, y: frame.size.height + 100)
        building.size = CGSize(width: frame.size.height / 10, height: frame.size.height / 10)
        addChild(building)
        if hasRamp {
            addRamp(CGPoint(x: building.position.x, y: building.position.y - (building.size.height/2)), building: building)
        }
        else {
            building.physicsBody = SKPhysicsBody(rectangleOfSize: rampMan.size)
            building.physicsBody?.categoryBitMask = UInt32(stairCollision)
            building.physicsBody?.dynamic = true
            building.physicsBody?.contactTestBitMask = UInt32(rampManCollision)
            building.physicsBody?.collisionBitMask = 0
            building.physicsBody?.usesPreciseCollisionDetection = true
        }
        //Move the building
        let moveBuilding = (SKAction.moveTo(CGPointMake(building.position.x, -100), duration: buildingDuration))
        let stopBuilding = (SKAction.runBlock({
            self.buildingMoveEnded(building)
        }))
        let moveAction = SKAction.sequence([moveBuilding, stopBuilding])
        building.runAction(moveAction)
    }
    
    func buildingMoveEnded(building: Building) {
        building.removeFromParent()
        buildings.removeAtIndex(0)
    }
    
    //MARK: Ramp funcs
    func addRamp(position: CGPoint, building: SKSpriteNode) {
        let ramp = Ramp()
        ramp.position = position
        ramp.size = CGSize(width: frame.size.height / 20, height: frame.size.height / 20)
        ramp.physicsBody = SKPhysicsBody(rectangleOfSize: ramp.size)
        ramp.physicsBody?.categoryBitMask = UInt32(rampCollision)
        ramp.physicsBody?.dynamic = true
        ramp.physicsBody?.contactTestBitMask = UInt32(rampManCollision)
        ramp.physicsBody?.collisionBitMask = 0
        ramp.physicsBody?.usesPreciseCollisionDetection = true

        addChild(ramp)
        ramps.append(ramp)
        let moveRamp = (SKAction.moveTo(CGPointMake(position.x,  -100 - building.size.height/2), duration: buildingDuration))
        let stopRamp = (SKAction.runBlock({
            self.rampMoveEnded(ramp)
        }))
        let moveAction = SKAction.sequence([moveRamp, stopRamp])
        ramp.runAction(moveAction)
    }
    
    func rampMoveEnded(ramp: Ramp){
        ramp.removeFromParent()
        ramps.removeAtIndex(0)
    }
    
    //Called when physics bodies intersect
    func didBeginContact(contact: SKPhysicsContact){
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if (firstBody.categoryBitMask & UInt32(rampCollision)) != 0 && (secondBody.categoryBitMask & UInt32(rampManCollision)) != 0 {
            enterBuilding(firstBody.node as! SKSpriteNode, man: secondBody.node as! SKSpriteNode)
        }
        if (firstBody.categoryBitMask & UInt32(rampManCollision)) != 0 && (secondBody.categoryBitMask & UInt32(stairCollision)) != 0 {
            hitStairs(firstBody.node as! SKSpriteNode, stairs: secondBody.node as! SKSpriteNode)
        }
    }
    
    //Called when the ramp man hits a ramp
    func enterBuilding(ramp: SKSpriteNode, man: SKSpriteNode){
        
    }
    
    //Called when the ramp man hits stairs
    func hitStairs(man: SKSpriteNode, stairs: SKSpriteNode){

    }
}

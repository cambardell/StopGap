//
//  selectCharacter.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-02-13.
//  Copyright © 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit

class selectCharacter: SKScene {
    var rampManLabel = SKLabelNode()
    var walkerLabel = SKLabelNode()
    var strollerLabel = SKLabelNode()
    override func didMoveToView(view: SKView) {
        rampManLabel = self.childNodeWithName("rampManLabel") as! SKLabelNode
        walkerLabel = self.childNodeWithName("walkerLabel") as! SKLabelNode
        strollerLabel = self.childNodeWithName("strollerLabel") as! SKLabelNode
        rampManLabel.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        walkerLabel.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 3)
        strollerLabel.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 1.5)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "rampManLabel" {
                roundVars.rampSkin = "RampMan"
                if let scene = GameScene(fileNamed: "GameScene"){
                    scene.scaleMode = .AspectFill
                    self.view?.presentScene(scene, transition: reveal)
                }
            }
            if node.name == "walkerLabel" {
                roundVars.rampSkin = "Walker"
                if let scene = GameScene(fileNamed: "GameScene"){
                    scene.scaleMode = .AspectFill
                    self.view?.presentScene(scene, transition: reveal)
                }
            }
            if node.name == "strollerLabel" {
                roundVars.rampSkin = "Stroller"
                if let scene = GameScene(fileNamed: "GameScene"){
                    scene.scaleMode = .AspectFill
                    self.view?.presentScene(scene, transition: reveal)
                }
            }
        }
    }
}

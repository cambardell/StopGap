//
//  GameOver.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-30.
//  Copyright © 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit

class GameOver: SKScene {
    var storesLabel = SKLabelNode()
    var winLabel = SKLabelNode()
    var toMenu = SKLabelNode()
    override func update(currentTime: NSTimeInterval) {
        storesLabel = self.childNodeWithName("storesLabel") as! SKLabelNode
        winLabel = self.childNodeWithName("winLabel") as! SKLabelNode
        toMenu = self.childNodeWithName("toMenu") as! SKLabelNode
        if endRoundVars.didPlayerWin {
            winLabel.text = "Win"
        }
        else {
            winLabel.text = "Lost"
        }
        storesLabel.text = String(roundVars.buildingsEntered)
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "toMenu" {
                roundVars.timeToBuilding = 0.0
                roundVars.buildingDuration = 0.0
                roundVars.buildingsEnteredScore = 0
                roundVars.totalTime = 0.0
                roundVars.numberOfBuildingsReset = 0
                if let scene = MainMenu(fileNamed: "MainMenu"){
                    scene.scaleMode = .AspectFit
                    self.view?.presentScene(scene, transition: reveal)
                }
            }
        }
    } 
}

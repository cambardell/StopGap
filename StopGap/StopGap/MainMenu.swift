//
//  MainMenu.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-26.
//  Copyright © 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    var playButton = SKNode()
    override func update(currentTime: NSTimeInterval) {
        playButton = self.childNodeWithName(("playButton"))! 
        playButton.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            let reveal : SKTransition = SKTransition.doorsOpenHorizontalWithDuration(0.5)
            
            if node.name == "playButton"{
                if let scene = GameScene(fileNamed: "GameScene"){
                    scene.scaleMode = .AspectFit
                    self.view?.presentScene(scene, transition: reveal)
                }
            }
        }
    }
}

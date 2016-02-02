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
    override func update(currentTime: NSTimeInterval) {
        storesLabel = self.childNodeWithName("storesLabel") as! SKLabelNode
        winLabel = self.childNodeWithName(("winLabel")) as! SKLabelNode
        if endRoundVars.didPlayerWin {
            winLabel.text = "Win"
        }
        else {
            winLabel.text = "Lost"
        }
        storesLabel.text = String(roundVars.buildingsEntered)
        
    }
}

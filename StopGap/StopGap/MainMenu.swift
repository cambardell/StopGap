//
//  MainMenu.swift
//  StopGap
//
//  Created by Cameron Bardell on 2016-01-26.
//  Copyright © 2016 Cameron Bardell. All rights reserved.
//

import SpriteKit
//Variables that control the gameplay in different rounds
struct roundVars {
    //Time between buildings
    static var timeToBuilding = 0.0
    //Duration of building move action
    static var buildingDuration = 0.0
    //Total number of buildings that are left to be entered in a round
    static var buildingsEnteredScore = 0
    //Total duration of the round
    static var totalTime:CFTimeInterval = 0
    //How many stores did the player enter
    static var buildingsEntered = 0
    //Total number of stores that must be entered. 
    static var numberOfBuildingsReset = 0
}

//Variables that control the end of the game, such as determining if the player won.
struct endRoundVars {
    //Did the player win the round
    static var didPlayerWin = false
}

//Transition between scenes.
let reveal : SKTransition = SKTransition.doorsOpenHorizontalWithDuration(0.5)


class MainMenu: SKScene {
    var bellevilleLabel = SKLabelNode()
    var torontoLabel = SKLabelNode()
    var kitchenerLabel = SKLabelNode()
    override func update(currentTime: NSTimeInterval) {
        bellevilleLabel = self.childNodeWithName("bellevilleLabel") as! SKLabelNode
        torontoLabel = self.childNodeWithName("torontoLabel") as! SKLabelNode
        kitchenerLabel = self.childNodeWithName("kitchenerLabel") as! SKLabelNode
        bellevilleLabel.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        torontoLabel.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 3)
        kitchenerLabel.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 1.5)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "bellevilleLabel" {
                roundVars.timeToBuilding = 0.7
                roundVars.buildingDuration = 5.0
                roundVars.buildingsEnteredScore = 10
                roundVars.totalTime = 30.0
                roundVars.numberOfBuildingsReset = 10
                if let scene = GameScene(fileNamed: "GameScene"){
                    scene.scaleMode = .AspectFill
                    self.view?.presentScene(scene, transition: reveal)
                }
            }
            
            if node.name == "kitchenerLabel" {
                roundVars.timeToBuilding = 0.5
                roundVars.buildingDuration = 4.5
                roundVars.buildingsEnteredScore = 20
                roundVars.totalTime = 45.0
                roundVars.numberOfBuildingsReset = 20
                if let scene = GameScene(fileNamed: "GameScene"){
                    scene.scaleMode = .AspectFill
                    self.view?.presentScene(scene, transition: reveal)
                }
            }
            
            if node.name == "torontoLabel" {
                roundVars.timeToBuilding = 0.25
                roundVars.buildingDuration = 2.0
                roundVars.buildingsEnteredScore = 40
                roundVars.totalTime = 60.0
                roundVars.numberOfBuildingsReset = 40
                if let scene = GameScene(fileNamed: "GameScene"){
                    scene.scaleMode = .AspectFill
                    self.view?.presentScene(scene, transition: reveal)
                }
            }
        }
    }
}

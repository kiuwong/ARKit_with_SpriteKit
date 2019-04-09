//
//  MainMenuScene.swift
//  BirdGame
//
//  Created by Kiu Ming Wong on 4/8/19.
//  Copyright © 2019 AlphaR. All rights reserved.
//

import SpriteKit
import ARKit

class MainMenuScene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {return}
        let positionInScene = touch.location(in: self)
        let touchedNodes = self.nodes(at: positionInScene)
        
        if let name = touchedNodes.last?.name {
            if name == "StartGame" {
                let transition = SKTransition.crossFade(withDuration: 0.9)
                
                guard let sceneView = self.view as? ARSKView else {return}
                
                if let gameScene = GameScene(fileNamed: "GameScene") {
                    sceneView.presentScene(gameScene, transition: transition)
                }
            }
        }
    }
}

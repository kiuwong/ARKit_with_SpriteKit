//
//  Scene.swift
//  BirdGame
//
//  Created by Kiu Ming Wong on 4/2/19.
//  Copyright © 2019 AlphaR. All rights reserved.
//

import SpriteKit
import ARKit

// used to create anchors
class Scene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let sceneView = self.view as? ARSKView else {return}
        
        if let touchLocation = touches.first?.location(in: sceneView) {
            if let hit = sceneView.hitTest(touchLocation, types: .featurePoint).first {
                sceneView.session.add(anchor: ARAnchor(transform: hit.worldTransform))
            }
        }
    }
}

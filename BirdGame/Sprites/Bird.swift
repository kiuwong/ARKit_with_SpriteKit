//
//  Bird.swift
//  BirdGame
//
//  Created by Kiu Ming Wong on 4/8/19.
//  Copyright © 2019 AlphaR. All rights reserved.
//

import SpriteKit
import GameplayKit

class Bird : SKSpriteNode {
    
    var mainSprite = SKSpriteNode()
    
    func setup() {
        
        mainSprite = SKSpriteNode(imageNamed: "bird")
        self.addChild(mainSprite)
        
        let textureAtlas = SKTextureAtlas(named: "bird")
        let frames = ["sprite_0", "sprite_1", "sprite_2", "sprite_3", "sprite_4", "sprite_5", "sprite_6"].map{textureAtlas.textureNamed($0)}
        
        let atlasAnimation = SKAction.animate(with: frames, timePerFrame: 1/7, resize: true, restore: false)
        
        let animationAction = SKAction.repeatForever(atlasAnimation)
        mainSprite.run(animationAction)
        
        let left = GKRandomSource.sharedRandom().nextBool()
        
        if left {
            mainSprite.xScale = -1
        }
        
        let duration = randomNumber(lowerBound: 15, upperBound: 20)
        
        let fade = SKAction.fadeOut(withDuration: TimeInterval(duration))
        let removeBird = SKAction.run {
            // create a new bird
            NotificationCenter.default.post(name: Notification.Name("Spawn"), object: nil)
            self.removeFromParent()
        }
        
        let flySequence = SKAction.sequence([fade, removeBird])
        
        mainSprite.run(flySequence)
    }
    
}

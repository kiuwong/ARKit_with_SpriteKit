//
//  ViewController.swift
//  BirdGame
//
//  Created by Kiu Ming Wong on 4/2/19.
//  Copyright © 2019 AlphaR. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show Statistics such as FPS and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene
        if let scene = MainMenuScene(fileNamed: "MainMenuScene") {
            sceneView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the View's Session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the View's Session
        sceneView.session.pause()
    }
    // handle pause of session when view will disappear
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }


}

extension ViewController : ARSKViewDelegate {
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        
        if GameScene.gameState == .spawnBirds {
            let bird = Bird()
            bird.setup()
            return bird
        } else {
            
        return SKNode()
            
        }
    }
    
//    func view(_ view: ARSKView, didAdd node: SKNode, for anchor: ARAnchor) {
//        let birdNode = SKSpriteNode(imageNamed: "bird")
//        birdNode.xScale = 0.30
//        birdNode.yScale = 0.30
//
//        node.addChild(birdNode)
//    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset Tracking and / or remove existing anchors if consistent tracking is required
    }
}


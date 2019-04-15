//
//  ViewController.swift
//  BirdGame
//
//  Created by Kiu Ming Wong on 4/2/19.
//  Copyright © 2019 AlphaR. All rights reserved.
//

import BoseWearable
import Logging
import UIKit
import SpriteKit
import ARKit

/// Stored preferences.
class Preferences {
    
    /// Singleton instance.
    static let shared = Preferences()
    
    /// UserDefaults keys
    enum Key: String {
        case correctForBaseReading
        case mirrorPitch
        case mirrorRoll
        case mirrorYaw
    }
    
    /// Default values for the preferences
    private let defaults: [Key: Any?] = [
        .correctForBaseReading: true,
        .mirrorPitch: true,
        .mirrorRoll: true,
        .mirrorYaw: false
    ]
    
    /// Stores the value for the specified key.
    func set<T>(_ key: Key, to value: T?) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    /// Retrieves the value for the specified key.
    func get<T>(_ key: Key) -> T {
        if let val = UserDefaults.standard.object(forKey: key.rawValue) as? T {
            return val
        }
        if let defaultVal = defaults[key] as? T {
            return defaultVal
        }
        fatalError("All keys must have defaults!")
    }
}

class GameViewController: UIViewController {
    enum RotationMode {
        case rotationVector
        case gameRotationVector
        
        var sensor: SensorType {
            switch self {
            case .rotationVector:
                return .rotation
            case .gameRotationVector:
                return .gameRotation
            }
        }
    }
    
    private enum Constants {
        // Config
        static let showCubeDemo = false // show the cube with "Bose AR" text demo or the glasses demo
        static let showDebugInfo = false // print out angles, position, etc. data of camera and root object
        static let manuallyControlModel = false // swipe, pinch, etc. to change camera position
        
        // Consts
        static let halfPi = Float.pi / 2
    }
    
    var rotationMode: RotationMode = .rotationVector
    
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
    
    var sensorDispatch = SensorDispatch(queue: .main)
    
    // The session is set by the HomeViewController before this view controller is shown.
    // When this view controller is popped and deallocated, the session will be released and deallocated. This will cause the connection to be closed.
    var session: WearableDeviceSession!
    
//    var token: ListenerToken?
//
//    var activityIndicator: ActivityIndicator?
    
    private let rotation = Quaternion(from: Vector(x: 0, y: -1, z: 0), to: Vector(x: 0, y: 0, z: 1))
    
    // swiftlint:disable:next large_tuple
    private var baseReadings: (pitch: Double, roll: Double, yaw: Double)?
    
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
    
//    var session: WearableDeviceSession!
//    
////    /// Used to block the UI during connection.
//    private var activityIndicator: ActivityIndicator?
//
//    /// Used to block the UI when sensor service is suspended.
//    private var suspensionOverlay: SuspensionOverlay?
//
//    // We create the SensorDispatch without any reference to a session or a device.
//    // We provide a queue on which the sensor data events are dispatched on.
//    private let sensorDispatch = SensorDispatch(queue: .main)
//
//    /// Retained for the lifetime of this object. When deallocated, deregisters
//    /// this object as a WearableDeviceEvent listener.
//    private var token: ListenerToken?

}

extension GameViewController : ARSKViewDelegate {
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        
        if GameScene.gameState == .spawnBirds {
            let bird = Bird()
            bird.setup()
            return bird
        } else {
            
        return SKNode()
            
        }
    }
    

    
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


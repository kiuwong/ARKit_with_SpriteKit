//
//  HomeViewController.swift
//  BirdGame
//
//  Created by Kiu Ming Wong on 4/12/19.
//  Copyright © 2019 AlphaR. All rights reserved.
//

import BoseWearable
import UIKit

class HomeViewController: UITableViewController {
    
    private var activityIndicator: ActivityIndicator?
    
    @IBOutlet var autoselectSwitch: UISwitch!
    
    @IBOutlet var versionLabel: UILabel!
    
    /// Determine the search mode based on the state of the autoselect switch
    private var mode: DeviceSearchMode {
        return autoselectSwitch.isOn
            
            // This option only shows the search UI if the most-recently connected device
            // is not found within 5 seconds. If the most-recently connected device is
            // found before 5 seconds has elapsed, it is automatically selected.
            ? .automaticallySelectMostRecentlyConnectedDevice(timeout: 5)
                
                // This option will always immediately show the search UI.
            : .alwaysShowUI
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = "BoseWearable \(BoseWearable.formattedVersion)"
    }
    
    
    @IBAction func searchTapped(_ sender: Any) {
        activityIndicator = ActivityIndicator.add(to: navigationController?.view)
        
        BoseWearable.shared.startDeviceSearch(mode: mode) { result in
            switch result {
            case .success(let session):
                self.showScene(with: session)
                
            case .failure(let error):
                self.show(error)
                
            case .cancelled:
                break
            }
            
            self.activityIndicator?.removeFromSuperview()
        }
    }
    
    @IBAction func useSimulatedDeviceTapped(_ sender: Any) {
//         Instead of using a session for a remote device, create a session for a simulated device.
                showScene(with: BoseWearable.shared.createSimulatedWearableDeviceSession())
    }
    
    
    private func showScene(with session: WearableDeviceSession) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
            fatalError("Cannot instantiate view controller")
        }

        
//        switch rotationSource.selectedSegmentIndex {
//        case 0:
//            vc.rotationMode = .rotationVector
//        case 1:
//            vc.rotationMode = .gameRotationVector
//        default:
//            fatalError("Invalid rotation mode selected")
//        }
///
        vc.session = session
        show(vc, sender: self)
    }
}

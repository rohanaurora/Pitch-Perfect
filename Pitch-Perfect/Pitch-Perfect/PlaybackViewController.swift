
//
//  PlaybackViewController.swift
//  Pitch-Perfect
//
//  Created by Rohan Aurora on 2020-12-13.
//  Copyright © 2020 Rohan Aurora. All rights reserved.
//

import UIKit

class PlaybackViewController: UIViewController {

    var recordedAudioURL: URL = URL(string: "")! {
        didSet {
            print("URL")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

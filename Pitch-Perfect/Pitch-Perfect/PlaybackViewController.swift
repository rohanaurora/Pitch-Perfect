
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
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func playButtonPressed(_ sender: Any) {
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
    }
}

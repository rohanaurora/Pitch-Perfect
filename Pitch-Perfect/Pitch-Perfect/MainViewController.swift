//
//  ViewController.swift
//  Pitch-Perfect
//
//  Created by Rohan Aurora on 2020-12-13.
//  Copyright © 2020 Rohan Aurora. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    @IBAction func recordAudioPressed(_ sender: Any) {
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        textLabel.text = "Recording in progress"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try? audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        print("Record")
    }
    
    @IBAction func stopAudioPressed(_ sender: Any) {
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        textLabel.text = "Tap to record"
        audioRecorder.stop()
        let av = AVAudioSession.sharedInstance()
        try? av.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playbackVC = segue.destination as! PlaybackViewController
            playbackVC.recordedAudioURL = sender as! URL
        }
    }
}


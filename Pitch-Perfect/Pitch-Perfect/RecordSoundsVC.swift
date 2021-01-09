//
//  RecordSoundsVC.swift
//  Pitch-Perfect
//
//  Created by Rohan Aurora on 2020-12-13.
//  Copyright © 2020 Rohan Aurora. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsVC: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIWhenRecording(true)
    }
    
    @IBAction func recordAudioPressed(_ sender: Any) {
        configureUIWhenRecording(false)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopAudioPressed(_ sender: Any) {
        audioRecorder.stop()
        configureUIWhenRecording(true)
        let av = AVAudioSession.sharedInstance()
        try? av.setActive(false)
    }
    
    func configureUIWhenRecording(_ recording:Bool) {
        if recording {
            stopRecordingButton.isEnabled = false
            recordButton.isEnabled = true
            textLabel.text = "Tap to record"
        } else {
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
            textLabel.text = "Recording in progress"
        }
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
            let playbackVC = segue.destination as! PlaybackVC
            playbackVC.recordedAudioURL = sender as? URL
        }
    }
}


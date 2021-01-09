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
        configureUIForStatus(.initial)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = Constants.appTitle
    }
    
    // MARK: Record Audio
    @IBAction func recordAudioPressed(_ sender: UIButton) {
        configureUIForStatus(.recording)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = Constants.recordedVoiceFile
        let pathArray = [dirPath, recordingName]
        guard let filePath = URL(string: pathArray.joined(separator: "/")) else { return }

        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSession.Category.playAndRecord,
                                 mode: AVAudioSession.Mode.default,
                                 options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try? audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // MARK: Stop Audio
    @IBAction func stopAudioPressed(_ sender: UIButton) {
        audioRecorder.stop()
        configureUIForStatus(.stopping)
        let av = AVAudioSession.sharedInstance()
        try? av.setActive(false)
    }
    
    private func configureUIForStatus(_ status: Status) {
        if status == .recording {
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
            textLabel.text = Constants.stopRecordingText
        } else {
            stopRecordingButton.isEnabled = false
            recordButton.isEnabled = true
            textLabel.text = Constants.startRecordingText
        }
    }

    // MARK: Delegate
    internal func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: Constants.detailViewSegueIdentifier, sender: audioRecorder.url)
        } else {
            print("Recording failed")
        }
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.detailViewSegueIdentifier {
            let playbackVC = segue.destination as! PlaybackVC
            playbackVC.recordedAudioURL = sender as? URL
        }
    }
}


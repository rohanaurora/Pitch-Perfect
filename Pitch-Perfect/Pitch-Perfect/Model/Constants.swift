//
//  Constants.swift
//  Pitch-Perfect
//
//  Created by Rohan Aurora on 2021-01-09.
//  Copyright © 2021 Rohan Aurora. All rights reserved.
//

import Foundation

struct Constants {
    static let recordedVoiceFile = "recordedVoice.wav"
    static let startRecordingText = "Tap to record"
    static let stopRecordingText = "Recording in progress"
    static let detailViewSegueIdentifier = "stopRecording"
    static let appTitle = "Pitch Perfect"
}

struct Alerts {
    static let DismissAlert = "Dismiss"
    static let RecordingDisabledTitle = "Recording Disabled"
    static let RecordingDisabledMessage = "You've disabled this app from recording your microphone. Check Settings."
    static let RecordingFailedTitle = "Recording Failed"
    static let RecordingFailedMessage = "Something went wrong with your recording."
    static let AudioRecorderError = "Audio Recorder Error"
    static let AudioSessionError = "Audio Session Error"
    static let AudioRecordingError = "Audio Recording Error"
    static let AudioFileError = "Audio File Error"
    static let AudioEngineError = "Audio Engine Error"
}


/// The types of buttons status required for audio recording.
enum Status {
    case initial,
         recording,
         stopping
}

/// The types of audio playback states.
enum PlayingState {
    case playing,
         notPlaying
}

/// The types of buttons for various audio effects.
enum ButtonType: Int {
    case slow = 0,
         fast,
         chipmunk,
         vader,
         echo,
         reverb
}

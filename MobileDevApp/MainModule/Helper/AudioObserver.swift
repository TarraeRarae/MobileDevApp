//
//  Observer.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 28.11.2021.
//

import Foundation
import CoreMedia

class AudioObserver: NSObject {

    static let shared = AudioObserver()

    var currentTime: Float = 0
    weak var audioPlayer: ObservableAudioObjectProtocol?
    weak var viewWithSlider: ObservingAudioObjectProtocol?
}

extension AudioObserver: AudioObserverProtocol {

    func changeTrackCurrentTime(newValue: Float) {
        audioPlayer?.observableValueDidChange(newValue: newValue)
    }

    func trackCurrentTimeDidChange(newValue: Float) {
        self.currentTime = newValue
        viewWithSlider?.observableValueDidChange(newValue: newValue)
    }

    func pauseTrack() {
        audioPlayer?.pause()
    }

    func playTrack() {
        audioPlayer?.play()
    }
}

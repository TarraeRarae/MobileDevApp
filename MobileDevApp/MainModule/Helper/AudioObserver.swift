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

    weak var audioPlayer: ObservableObjectProtocol?
    weak var viewWithSlider: ObservableObjectProtocol?
}

extension AudioObserver: AudioObserverProtocol {

    func changeTrackCurrentTime(newValue: Float) {
        audioPlayer?.observableValueDidChange(newValue: newValue)
    }

    func trackCurrentTimeDidChange(newValue: Float) {
        viewWithSlider?.observableValueDidChange(newValue: newValue)
    }
}

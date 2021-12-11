//
//  ObservingObjectProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 29.11.2021.
//

import Foundation

protocol ObservableAudioObjectProtocol: AnyObject {
    func observableValueDidChange(newValue: Float)
    func pause()
    func play()
}

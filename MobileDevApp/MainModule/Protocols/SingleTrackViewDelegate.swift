//
//  SingleTrackViewDelegateProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 09.11.2021.
//

import Foundation

protocol SingleTrackViewDelegate: AnyObject {

    func playButtonTapped(isPaused: Bool)
    func sliderValueChanged(newValue value: Float)
}

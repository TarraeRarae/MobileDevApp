//
//  AudioObserver.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 28.11.2021.
//

import Foundation

protocol AudioObserverProtocol: AnyObject {
    func changeTrackCurrentTime(newValue: Float)
    func trackCurrentTimeDidChange(newValue: Float)
}

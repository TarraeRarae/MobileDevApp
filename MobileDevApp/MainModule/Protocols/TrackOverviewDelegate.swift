//
//  TrackOverviewProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 05.11.2021.
//

import Foundation

protocol TrackOverviewDelegate: AnyObject {

    func presentSingleTrackView(data: TrackDataJSON, isPaused: Bool)
    func closeTrack()
}

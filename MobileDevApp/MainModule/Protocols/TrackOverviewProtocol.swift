//
//  TrackOverviewProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 05.11.2021.
//

import Foundation

protocol TrackOverviewProtocol: AnyObject {

    func presentSingleTrackView(data: TrackData, isPaused: Bool)
    func closeTrack()
}

//
//  TrackOverviewProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 05.11.2021.
//

import Foundation

protocol TrackOverviewDelegate: AnyObject {

    func presentSingleTrackView(viewModel: TrackOverviewViewModelProtocol, isPaused: Bool)
    func closeTrack()
}

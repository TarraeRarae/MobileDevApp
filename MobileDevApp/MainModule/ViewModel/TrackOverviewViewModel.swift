//
//  TrackOverviewViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 09.11.2021.
//

import Foundation

class TrackOverviewViewModel: TrackOverviewViewModelProtocol {

    private var trackData: TrackData

    var trackName: String {
        return trackData.name
    }

    var artistsNames: [String] {
        return trackData.artistsNames
    }

    init(data: TrackData) {
        self.trackData = data
    }
}

//
//  TrackListCellViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 09.11.2021.
//

import Foundation

class TrackListCellViewModel: TrackListCellViewModelProtocol {

    var cellTrackData: TrackData

    var name: String {
        return cellTrackData.name
    }

    var uri: String {
        return cellTrackData.uri
    }

    var artistNames: [String] {
        return cellTrackData.artistsNames
    }

    init(data: TrackData) {
        self.cellTrackData = data
    }
}

//
//  TrackListViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 09.11.2021.
//

import Foundation

class TrackListViewModel: TrackListViewModelProtocol {

    private var trackData: [TrackData] = []

    init() {
        if let trackJSONData = ParserJSON.parseJSON() {
            for item in trackJSONData.tracks {
                trackData.append(TrackData(data: item))
            }
        }
    }

    func numberOfRows() -> Int {
        return trackData.count
    }

    func overviewViewModel(for indexPath: IndexPath) -> TrackOverviewViewModelProtocol? {
        return TrackOverviewViewModel(data: trackData[indexPath.row])
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> TrackListCellViewModelProtocol? {
        let cellViewModel = TrackListCellViewModel(data: trackData[indexPath.row])
        return cellViewModel
    }
}

//
//  TrackListInteractor.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 15.11.2021.
//

import Foundation

class TrackListInteractor {

    weak var presenter: TrackListInteractorOutputProtocol?

    required init(presenter: TrackListInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension TrackListInteractor: TrackListInteractorProtocol {

    func fetchData() {
        var tracksData: [TrackData] = []
        if let trackJSONData = ParserJSON.parseJSON() {
            for item in trackJSONData.tracks {
                tracksData.append(TrackData(data: item))
            }
        }
        presenter?.didReceiveData(data: tracksData)
    }
}

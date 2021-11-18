//
//  TrackListInteractor.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 15.11.2021.
//

import Foundation
import Moya

class TrackListInteractor {

    weak var presenter: TrackListInteractorOutputProtocol?

    required init(presenter: TrackListInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension TrackListInteractor: TrackListInteractorProtocol {

    func fetchData() {
        let endpointClosure = { (target: SpotifyService) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
        }
        let provider = MoyaProvider<SpotifyService>(endpointClosure: endpointClosure)
        provider.request(.getTracksFromAlbum(albumID: "4aawyAB9vmqN3uQ7FjRGTy")) { result in
            switch result {
            case .success(let moyaResponse):
                let data = ParserJSON.parseJSON(data: moyaResponse.data)
                guard let data = data else { return }
                var resultData: [TrackData] = []
                for item in data.tracks.items {
                    resultData.append(TrackData(data: item, images: data.images))
                }
                self.presenter?.didReceiveData(data: resultData)
            case .failure:
                print("error")
            }
        }
    }
}

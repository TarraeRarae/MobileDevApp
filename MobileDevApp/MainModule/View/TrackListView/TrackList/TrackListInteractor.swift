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
    private let trackPlayer = TrackPlayer()
    private let coreDataService = CoreDataService()

    required init(presenter: TrackListInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension TrackListInteractor: TrackListInteractorProtocol {

    func isDataSaved(data: TrackData) -> Bool {
        return coreDataService.isDataSaved(data: data)
    }

    func deleteObjectFromSavedData(data: TrackData) {
        coreDataService.deleteObjectFromSavedData(data: data)
        presenter?.reloadData()
    }

    func fetchOnlineData() {
        let endpointClosure = { (target: SpotifyService) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
        }
        let provider = MoyaProvider<SpotifyService>(endpointClosure: endpointClosure)
        provider.request(.getTracksFromAlbum(albumID: "43RGWSAgcUh3ytWu26mdGH")) { result in
            switch result {
            case .success(let moyaResponse):
                let data = ParserJSON.parseJSON(data: moyaResponse.data)
                guard let data = data else { return }
                var resultData: [TrackData] = []
                for item in data.tracks.items {
                    resultData.append(TrackData(data: item, images: data.images))
                }
                DispatchQueue.main.async {
                    self.presenter?.didReceiveOnlineData(data: resultData)
                }
            case .failure:
                print("error")
            }
        }
    }

    func fetchDownloadedData() {
        guard let data = coreDataService.fetchData() else {
            presenter?.diddReceiveDownloadeData(data: [])
            return
        }
        presenter?.diddReceiveDownloadeData(data: data)
    }

    func clearDownloadedData() {
        coreDataService.clearCoreDataStack()
        presenter?.reloadData()
    }

    func saveData(data: TrackData) {
        coreDataService.saveData(data: data)
    }

    func startTrack(data: TrackData) {
        guard let url = URL(string: data.previewURL) else { return }
        self.trackPlayer.startTrack(url: url)
    }

    func playTrack() {
        self.trackPlayer.play()
    }

    func pauseTrack() {
        self.trackPlayer.pause()
    }

    func closeTrack() {
        self.trackPlayer.closeTrack()
    }
}

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
                self.presenter?.didReceiveOnlineData(data: resultData)
            case .failure:
                self.presenter?.didReceiveOnlineData(data: [])
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
        let endpointClosure = { (target: TrackDownloadService) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
        }
        let fileName = String(data.previewURL.split(separator: "/")[3].split(separator: "?")[0])
        let provider = MoyaProvider<TrackDownloadService>(endpointClosure: endpointClosure)
        provider.request(.downloadTrack(url: fileName)) { result in
            switch result {
            case .success:
                let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let destinationUrl = documentsDirectoryURL.appendingPathComponent(fileName + ".mp3")
                var resultData = data
                resultData.destinationURL = destinationUrl
                self.coreDataService.saveData(data: resultData)
            case .failure:
                print("failure")
            }
        }
    }

    func startTrack(data: TrackData) {
        guard let destinationURL = data.destinationURL else {
            guard let url = URL(string: data.previewURL) else { return }
            self.trackPlayer.startOnlineTrack(url: url)
            return
        }
        self.trackPlayer.startDownloadedTrack(url: destinationURL)
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

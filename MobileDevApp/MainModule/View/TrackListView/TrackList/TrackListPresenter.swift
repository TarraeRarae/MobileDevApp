//
//  TrackListPresenter.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 15.11.2021.
//

import Foundation

class TrackListPresenter {

    var data: [TrackData] = []
    weak var view: TrackListViewControllerProtocol?
    var interactor: TrackListInteractorProtocol?
    var router: TrackListRouterProtocol?
    private var currentDataIndex: Int = 0

    required init(view: TrackListViewControllerProtocol) {
        self.view = view
    }

    private func imagesFromCoreDataObject(object: Data?) -> [Data] {
        var result: [Data] = []
        guard let object = object else { return [] }
        if let dataArray = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: object) {
            for data in dataArray {
                if let data = data as? Data {
                    result.append(data)
                }
            }
        }
        return result
    }
}

extension TrackListPresenter: TrackListPresenterProtocol {

    func viewDidLoad(for index: Int) {
        switch index {
        case 0:
            currentDataIndex = 0
            DispatchQueue.global().async {
                self.interactor?.fetchOnlineData()
            }
        case 1:
            currentDataIndex = 1
            self.interactor?.fetchDownloadedData()
        default:
            return
        }
    }

    func getCellData(for indexPath: IndexPath) -> TrackData {
        return data[indexPath.row]
    }

    func numberOfRows() -> Int {
        return data.count
    }

    func didCellTap(at indexPath: IndexPath) {
        view?.showTrackOverview(with: data[indexPath.row])
        interactor?.startTrack(data: data[indexPath.row])
    }

    func closeTrack() {
        interactor?.closeTrack()
    }

    func changeTrackCondition(isPaused: Bool) {
        if isPaused {
            interactor?.pauseTrack()
        } else {
            interactor?.playTrack()
        }
    }

    func saveData(data: TrackData) {
        interactor?.saveData(data: data)
    }

    func didExitButtonTap() {
        router?.showAuthenticationViewController()
    }

    func didClearButtonTap() {
        interactor?.clearDownloadedData()
    }
}

extension TrackListPresenter: TrackListInteractorOutputProtocol {

    func didReceiveOnlineData(data: [TrackData]) {
        self.data = data
        self.view?.reloadData()
    }

    func diddReceiveDownloadeData(data: [TrackDataEntity]) {
        self.data = []
        for item in data {
            guard let trackName = item.trackName, let artistName = item.singerName, let images = item.images else { continue }
            let trackData = Item(artists: [Artist(name: artistName)], name: trackName, previewURL: "")
            let imagesData = imagesFromCoreDataObject(object: images)
            self.data.append(TrackData(data: trackData, images: imagesData))
        }
        view?.reloadData()
    }

    func reloadData() {
        if currentDataIndex == 1 {
            self.data = []
            view?.reloadData()
        }
    }
}

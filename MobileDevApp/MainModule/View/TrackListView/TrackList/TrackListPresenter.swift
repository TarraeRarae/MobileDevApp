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
}

extension TrackListPresenter: TrackListPresenterProtocol {

    func viewDidLoad(for index: Int) {
        switch index {
        case 0:
            currentDataIndex = 0
            self.interactor?.fetchOnlineData()
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
    }

    func trackOverviewDidCreate(with data: TrackData) {
        interactor?.startTrack(data: data)
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

    func didDataButtonTap(data: TrackData, isDataDownloaded: Bool, closure: @escaping () -> Void) {
        if isDataDownloaded {
            interactor?.deleteObjectFromSavedData(data: data, closure: closure)
            return
        }
        interactor?.saveData(data: data, closure: closure)
    }

    func didExitButtonTap() {
        router?.showAuthenticationViewController()
    }

    func didClearButtonTap() {
        interactor?.clearDownloadedData()
    }

    func isTrackDownloaded(for indexPath: IndexPath) -> Bool {
        guard let interactor = interactor else { return false }
        return interactor.isDataSaved(data: data[indexPath.row])
    }
}

extension TrackListPresenter: TrackListInteractorOutputProtocol {

    func didReceiveOnlineData(data: [TrackData]) {
        self.data = data
        self.view?.reloadData()
    }

    func didReceiveDownloadeData(data: [TrackDataEntity]) {
        self.data = []
        for item in data {
            guard let trackName = item.trackName, let artistName = item.singerName, let previewURL = item.previewURL, let destination = item.destinationURL, let imagesURLs = item.imagesURLs else { return }
            let trackData = Item(artists: [Artist(name: artistName)], name: trackName, previewURL: previewURL, durationMS: item.duration)
            var resultData = TrackData(data: trackData)
            resultData.destinationURL = destination
            resultData.imagesURLs = imagesURLs
            self.data.append(resultData)
        }
        self.data.sort { $0.name < $1.name }
        view?.reloadData()
    }

    func reloadData() {
        if currentDataIndex == 1 {
            interactor?.fetchDownloadedData()
            return
        }
//        view?.reloadData()
    }
}

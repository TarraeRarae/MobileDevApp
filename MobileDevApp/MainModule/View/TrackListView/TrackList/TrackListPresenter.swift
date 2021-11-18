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

    required init(view: TrackListViewControllerProtocol) {
        self.view = view
    }
}

extension TrackListPresenter: TrackListPresenterProtocol {

    func getCellData(for indexPath: IndexPath) -> TrackData {
        return data[indexPath.row]
    }

    func viewDidLoad() {
        interactor?.fetchData()
    }

    func numberOfRows() -> Int {
        return data.count
    }

    func didCellTap(at indexPath: IndexPath) {
        view?.showTrackOverview(with: data[indexPath.row])
    }
}

extension TrackListPresenter: TrackListInteractorOutputProtocol {

    func didReceiveData(data: [TrackData]) {
        self.data = data
        view?.reloadData()
    }
}

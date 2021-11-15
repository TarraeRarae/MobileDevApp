//
//  TrackListConfigurator.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 15.11.2021.
//

import Foundation

class TrackListConfigurator {

    func configure(view: TrackListViewController) {
        let presenter = TrackListPresenter(view: view)
        let interactor = TrackListInteractor(presenter: presenter)

        view.presenter = presenter
        presenter.interactor = interactor
    }
}

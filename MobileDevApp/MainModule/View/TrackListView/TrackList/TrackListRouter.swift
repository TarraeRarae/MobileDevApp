//
//  TrackListRouter.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 21.11.2021.
//

import Foundation

class TrackListRouter {

    weak var view: TrackListViewController?

    required init(view: TrackListViewController) {
        self.view = view
    }
}

extension TrackListRouter: TrackListRouterProtocol {

    func showAuthenticationViewController() {
        view?.navigationController?.popViewController(animated: true)
    }
}

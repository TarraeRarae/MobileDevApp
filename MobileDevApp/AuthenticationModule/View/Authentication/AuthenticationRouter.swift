//
//  AuthenticationRouter.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.11.2021.
//

import Foundation

class AuthenticationRouter {

    weak var view: AuthenticationViewController?

    required init(view: AuthenticationViewController) {
        self.view = view
    }
}

extension AuthenticationRouter: AuthenticationRouterProtocol {

    func presentTrackList() {
        view?.show(TrackListViewController(), sender: nil)
    }
}

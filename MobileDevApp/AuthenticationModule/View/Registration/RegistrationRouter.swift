//
//  AuthenticationRouter.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.11.2021.
//

import Foundation

class RegistrationRouter {

    weak var view: RegistrationViewController?

    required init(view: RegistrationViewController) {
        self.view = view
    }
}

extension RegistrationRouter: RegistrationRouterProtocol {

    func presentTrackList() {
        view?.show(TrackListViewController(), sender: nil)
    }
}

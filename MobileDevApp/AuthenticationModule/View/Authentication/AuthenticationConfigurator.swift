//
//  AuthenticationConfigurator.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.11.2021.
//

import Foundation

class AuthenticationConfigurator {

    func configure(view: AuthenticationViewController) {
        let presenter = AuthenticationPresenter(view: view)
        let interactor = AuthenticationInteractor(presenter: presenter)
        let router = AuthenticationRouter(view: view)

        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
    }
}

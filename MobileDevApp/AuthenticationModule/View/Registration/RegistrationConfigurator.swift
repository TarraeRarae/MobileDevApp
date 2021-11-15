//
//  AuthenticationConfigurator.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.11.2021.
//

import Foundation

class RegistrationConfigurator {

    func configure(view: RegistrationViewController) {
        let presenter = RegistrationPresenter(view: view)
        let interactor = RegistrationInteractor(presenter: presenter)
        let router = RegistrationRouter(view: view)

        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
    }
}

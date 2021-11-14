//
//  AuthenticationPresenter.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.11.2021.
//

import UIKit

class RegistrationPresenter {

    weak var view: RegistrationViewControllerProtocol?
    var interactor: RegistrationInteractorProtocol?
    var router: RegistrationRouterProtocol?

    var data: [AuthenticationCellData] = []

    required init(view: RegistrationViewControllerProtocol) {
        self.view = view
    }
}

extension RegistrationPresenter: RegistrationPresenterProtocol {

    func validateTableData(tableView: UITableView) {
        guard let interactor = interactor else { return }
        var cells: [AuthenticationCell] = []
        var isValid = true
        var errorsMessages = Set<String>()
        for cell in tableView.visibleCells {
            guard let authCell = cell as? AuthenticationCell else { return }
            cells.append(authCell)
        }
        let errors = interactor.validateData(cells: cells)
        for item in errors {
            if let errorInfo = item.errorInfo {
                isValid = false
                errorsMessages.insert(errorInfo)
            }
        }
        if isValid {
            router?.presentTrackList()
            return
        }
        view?.setupAlertController(data: errorsMessages)
    }

    func viewDidLoad() {
        interactor?.fetchData()
    }

    func numberOfRows() -> Int {
        return data.count
    }

    func getCellData(for indexPath: IndexPath) -> AuthenticationCellData {
        return data[indexPath.row]
    }
}

extension RegistrationPresenter: RegistrationInteractorOutputProtocol {

    func didReceiveData(data: [AuthenticationCellData]) {
        self.data = data
        view?.reloadData()
    }
}

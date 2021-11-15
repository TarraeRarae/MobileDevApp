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

    private func validateRegistrationTableData(cells: [AuthenticationCell]) -> (Bool, Set<String>) {
        var messages: Set<String> = []
        var isValid = true
        let errors = interactor?.validateData(cells: cells)
        for item in errors! {
            if let errorInfo = item.errorInfo {
                isValid = false
                messages.insert(errorInfo)
            }
        }
        return (isValid, messages)
    }

    private func checkRegisteredLoginTableData(cells: [AuthenticationCell]) -> (Bool, Set<String>) {
        var messages: Set<String> = []
        var isValid = true
        let errors = interactor?.checkRegistered(cells: cells)
        for item in errors! {
            if let errorInfo = item.errorInfo {
                isValid = false
                messages.insert(errorInfo)
            }
        }

        return (isValid, messages)
    }
}

extension RegistrationPresenter: RegistrationPresenterProtocol {

    func validateTableData(tableView: UITableView, for segmentedIndex: Int) {
        var cells: [AuthenticationCell] = []
        for cell in tableView.visibleCells {
            guard let authCell = cell as? AuthenticationCell else { return }
            cells.append(authCell)
        }
        var result: (Bool, Set<String>)?
        switch segmentedIndex {
        case 0:
             result = checkRegisteredLoginTableData(cells: cells)
        case 1:
             result = validateRegistrationTableData(cells: cells)
        default:
            return
        }
        if result!.0 {
            router?.presentTrackList()
            return
        }
        view?.setupAlertController(data: result!.1)
    }

    func viewDidLoad(for segmentedIndex: Int) {
        switch segmentedIndex {
        case 0:
            interactor?.fetchLoginData()
        case 1:
            interactor?.fetchRegistrationData()
        default:
            return
        }
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

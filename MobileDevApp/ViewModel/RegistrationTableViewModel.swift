//
//  RegistrationTableViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import UIKit

class RegistrationTableViewModel: TableViewViewModelProtocol {

    private let cellDataArray: [AuthenticationCellData] =  [
        AuthenticationCellData(placeholder: "Email", isSequreTextField: false, contentType: .emailAddress),
        AuthenticationCellData(placeholder: "Username", isSequreTextField: false, contentType: .username),
        AuthenticationCellData(placeholder: "Password. At least 6. Must contains num", isSequreTextField: true, contentType: .password),
        AuthenticationCellData(placeholder: "Confirm password", isSequreTextField: true, contentType: .password)]
    private let validator: AuthenticationCellViewModelDelegate = Helper()
    var tableView: UITableView?
    var isTableViewValid: [ValidationErrorInfo] {
        return self.validateTableView()
    }

    func numberOfRows() -> Int {
        return cellDataArray.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelProtocol? {
        let cellViewModel = AuthenticationCellViewModel(cellData: cellDataArray[indexPath.row])
        cellViewModel.delegate = validator
        return cellViewModel
    }

    private func validateTableView() -> [ValidationErrorInfo] {
        guard let tableView = tableView else { return [] }
        var validationErrors: [ValidationErrorInfo] = []
        for cell in tableView.visibleCells {
            guard let authCell = cell as? AuthenticationCell else { return [] }
            let cellValidation = authCell.isTextFieldValid
            validationErrors.append(cellValidation)
        }
        return validationErrors
    }

    private func removeUserDataFromUserDefaults() {
        UserDefaults.standard.set(nil, forKey: "Username")
        UserDefaults.standard.set(nil, forKey: "UserPassword")
    }
}

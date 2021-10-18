//
//  RegistrationTableViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import UIKit

class RegistrationTableViewModel: TableViewViewModelProtocol {

    private let cellDataArray: [AuthenticationCellData] =  [
        AuthenticationCellData(placeholder: NSLocalizedString("Email", comment: ""), isSequreTextField: false, contentType: .emailAddress),
        AuthenticationCellData(placeholder: NSLocalizedString("Username", comment: ""), isSequreTextField: false, contentType: .username),
        AuthenticationCellData(placeholder: NSLocalizedString("Password. At least 6. Must contains num", comment: ""), isSequreTextField: true, contentType: .password),
        AuthenticationCellData(placeholder: NSLocalizedString("Confirm password", comment: ""), isSequreTextField: true, contentType: .password)]
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
        saveUserData(data: validationErrors)
        return validationErrors
    }

    private func saveUserData(data: [ValidationErrorInfo]) {
        var isValid: Bool = true
        for item in data {
            isValid = isValid && item.isValid
        }
        if isValid {
            guard let tableView = tableView else { return }
            for cell in tableView.visibleCells {
                guard let authCell = cell as? AuthenticationCell else { return }
                authCell.saveUserData()
            }
        }
    }
}

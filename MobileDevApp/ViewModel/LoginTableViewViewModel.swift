//
//  LoginTableViewViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import UIKit

class LoginTableViewViewModel: TableViewViewModelProtocol {

    private let cellDataArray: [AuthenticationCellData] = [
        AuthenticationCellData(placeholder: NSLocalizedString("Username", comment: ""), isSequreTextField: false, contentType: .username),
        AuthenticationCellData(placeholder: NSLocalizedString("Password", comment: ""), isSequreTextField: true, contentType: .password)
    ]
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
            let cellValidation = authCell.isTextFieldRegistered
            validationErrors.append(cellValidation)
        }
        return validationErrors
    }
}

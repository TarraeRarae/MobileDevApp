//
//  LoginTableViewViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import UIKit

class LoginTableViewViewModel: TableViewViewModelProtocol {

    private let cellDataArray: [AuthenticationCellData] = [
        AuthenticationCellData(tag: 0, placeholder: NSLocalizedString("Username", comment: ""), isSequreTextField: false, contentType: .username),
        AuthenticationCellData(tag: 0, placeholder: NSLocalizedString("Password", comment: ""), isSequreTextField: true, contentType: .password)
    ]
    private let validator = AuthenticationHelper()
    var tableView: UITableView?

    var isTableViewValid: [ValidationErrorInfo] {
        return self.validateTableView()
    }

    func numberOfRows() -> Int {
        return cellDataArray.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelProtocol? {
        let cellViewModel = AuthenticationCellViewModel(cellData: cellDataArray[indexPath.row])
        return cellViewModel
    }

    private func validateTableView() -> [ValidationErrorInfo] {
        guard let tableView = tableView else { return [] }
        var validationErrors: [ValidationErrorInfo] = []
        for cell in tableView.visibleCells {
            guard let authCell = cell as? AuthenticationCell, let viewModel = authCell.viewModel else { return [] }
            let cellValidation = checkRegistered(text: authCell.textField.text, cellData: viewModel.cellData)
            validationErrors.append(cellValidation)
        }
        return validationErrors
    }

    public func checkRegistered(text: String?, cellData: AuthenticationCellData) -> ValidationErrorInfo {
        guard let text = text else { return ValidationErrorInfo(isValid: false, errorInfo: nil) }
        if text.count == 0 {
            return ValidationErrorInfo(isValid: false, errorInfo: NSLocalizedString("Input data into all fields", comment: ""))
        }
        switch cellData.contentType {
        case .username:
            return validator.checkUsername(username: text)
        case .password:
            return validator.checkPassword(password: text)
        default:
            return ValidationErrorInfo(isValid: false, errorInfo: NSLocalizedString("Unexpected error", comment: ""))
        }
    }
}

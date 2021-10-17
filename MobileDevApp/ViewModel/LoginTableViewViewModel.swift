//
//  LoginTableViewViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import UIKit

class LoginTableViewViewModel: TableViewViewModelProtocol {

    private let cellDataArray: [AuthenticationCellData] = [
        AuthenticationCellData(placeholder: "Login", isSequreTextField: false, contentType: .username),
        AuthenticationCellData(placeholder: "Password", isSequreTextField: true, contentType: .password)
    ]
    private let validator: AuthenticationCellViewModelDelegate = LoginValidationManager()
    var tableView: UITableView?
    var isTableViewValid: Bool {
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

    private func validateTableView() -> Bool {
        guard let tableView = tableView else { return false }
        var isValid: Bool = true
        for cell in tableView.visibleCells {
            guard let authCell = cell as? AuthenticationCell else { return false }
            let isCellValid = authCell.isTextFieldValid
            isValid = isValid && isCellValid
        }
        return isValid
    }
}

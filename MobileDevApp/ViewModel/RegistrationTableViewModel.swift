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
        AuthenticationCellData(placeholder: "*********", isSequreTextField: true, contentType: .password),
        AuthenticationCellData(placeholder: "*********", isSequreTextField: true, contentType: .password)]
    private let validator: AuthenticationCellViewModelDelegate = RegistrationValidationManager()
    weak var tableView: UITableView?
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
        var isValid: Bool = true
        for row in 0..<numberOfRows() {
            guard let cell = tableView?.cellForRow(at: IndexPath(row: row, section: 0)) as? AuthenticationCell else {
                return false
            }
            isValid = isValid && cell.isTextFieldValid
            print("\(isValid)")
        }
        return isValid
    }
}

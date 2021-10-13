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

    func numberOfRows() -> Int {
        return cellDataArray.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelProtocol? {
        let cellViewModel = AuthenticationCellViewModel(cellData: cellDataArray[indexPath.row])
        cellViewModel.delegate = validator
        return cellViewModel
    }
}

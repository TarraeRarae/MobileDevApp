//
//  RegistrationTableViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import Foundation

class RegistrationTableViewModel: TableViewViewModelProtocol {
    private let cellDataArray: [AuthenticationCellData] =  [
        AuthenticationCellData(placeholder: "Email", isSequreTextField: false, contentType: .emailAddress),
        AuthenticationCellData(placeholder: "Username", isSequreTextField: false, contentType: .username),
        AuthenticationCellData(placeholder: "*********", isSequreTextField: true, contentType: .password),
        AuthenticationCellData(placeholder: "*********", isSequreTextField: true, contentType: .password)]

    func numberOfRows() -> Int {
        return cellDataArray.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelProtocol? {
        return AuthenticationcellViewModel(cellData: cellDataArray[indexPath.row])
    }
}

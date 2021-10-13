//
//  LoginTableViewViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import Foundation

class LoginTableViewViewModel: TableViewViewModelProtocol {
    private let cellDataArray: [AuthenticationCellData] = [
        AuthenticationCellData(placeholder: "Login", isSequreTextField: false, contentType: .emailAddress),
        AuthenticationCellData(placeholder: "Password", isSequreTextField: true, contentType: .password)
    ]

    func numberOfRows() -> Int {
        return cellDataArray.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelProtocol? {
        return AuthenticationcellViewModel(cellData: cellDataArray[indexPath.row])
    }
}

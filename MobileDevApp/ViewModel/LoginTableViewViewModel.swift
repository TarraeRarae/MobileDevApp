//
//  LoginTableViewViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import UIKit

class LoginTableViewViewModel: TableViewViewModelProtocol {
    private let cellDataArray: [AuthenticationCellData] = [
        AuthenticationCellData(placeholder: "Login", isSequreTextField: false, contentType: .emailAddress),
        AuthenticationCellData(placeholder: "Password", isSequreTextField: true, contentType: .password)
    ]

    func numberOfRows() -> Int {
        return cellDataArray.count
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelProtocol? {
        return AuthenticationCellViewModel(cellData: cellDataArray[indexPath.row])
    }
}

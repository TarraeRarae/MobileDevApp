//
//  AuthenticationCellViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import UIKit

class AuthenticationCellViewModel: TableViewCellViewModelProtocol {

    var cellData: AuthenticationCellData
    var complition: ((Int) -> Void)?

    var placeholder: String {
        return cellData.placeholder
    }

    var contentType: UITextContentType {
        switch cellData.contentType {
        case .emailAddress:
            return .emailAddress
        case .username:
            return .username
        case .password, .confirmPassword:
            return .password
        }
    }

    var isSequreTextField: Bool {
        return cellData.isSequreTextField
    }

    var tag: Int {
        return cellData.tag
    }

    init(cellData: AuthenticationCellData) {
        self.cellData = cellData
    }

    func moveToNextTextField() {
        if let complition = complition {
            complition(cellData.tag)
        }
    }
}

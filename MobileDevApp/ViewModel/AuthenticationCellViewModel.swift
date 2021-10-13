//
//  AuthenticationCellViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import UIKit

class AuthenticationcellViewModel: TableViewCellViewModelProtocol {
    private var cellData: AuthenticationCellData

    var placeholder: String {
        return cellData.placeholder
    }

    var contentType: UITextContentType {
        return cellData.contentType
    }

    var isSequreTextField: Bool {
        return cellData.isSequreTextField
    }

    var textOfTextField: String? {
        didSet {
            guard let textOfTextField = textOfTextField else {
                return
            }
            self.validate(text: textOfTextField)
        }
    }

    init(cellData: AuthenticationCellData) {
        self.cellData = cellData
    }

    private func validate(text: String) {
        print(text)
    }
}

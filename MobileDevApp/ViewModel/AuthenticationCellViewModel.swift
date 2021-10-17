//
//  AuthenticationCellViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import UIKit

class AuthenticationCellViewModel: TableViewCellViewModelProtocol {
    private var cellData: AuthenticationCellData
    weak var delegate: AuthenticationCellViewModelDelegate?

    var placeholder: String {
        return cellData.placeholder
    }

    var contentType: UITextContentType {
        return cellData.contentType
    }

    var isSequreTextField: Bool {
        return cellData.isSequreTextField
    }

    init(cellData: AuthenticationCellData) {
        self.cellData = cellData
    }

    public func validate(text: String?) -> Bool {
        guard let delegate = delegate else { fatalError() }
        return delegate.validateTextField(text: text, textContentType: cellData.contentType)
    }
}

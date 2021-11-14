//
//  AuthenticationInteractor.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.11.2021.
//

import Foundation

class RegistrationInteractor {

    weak var presenter: RegistrationInteractorOutputProtocol?

    required init(presenter: RegistrationInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension RegistrationInteractor: RegistrationInteractorProtocol {

    func validateData(cells: [AuthenticationCell]) -> [ValidationErrorInfo] {
        var errors: [ValidationErrorInfo] = []
        var isValid = true
        for cell in cells {
            guard let text = cell.textField.text, let data = cell.cellData else { fatalError() }
            let errorData = AuthenticationHelper.shared.validateRegistrationData(text: text, contentType: data.contentType)
            if !errorData.isValid {
                isValid = false
                cell.makeTextFieldInvalid()
                errors.append(errorData)
            }
        }
        if isValid {
            for cell in cells {
                if let cellData = cell.cellData {
                    switch cellData.contentType {
                    case .username:
                        AuthenticationHelper.shared.saveUsername(text: cell.textField.text!)
                    case .password:
                        AuthenticationHelper.shared.saveUserPassword(text: cell.textField.text!)
                    default:
                        break
                    }
                }
            }
        }
        return errors
    }

    func fetchData() {
        let data = [
            AuthenticationCellData(tag: 0, placeholder: "Email".localized, isSequreTextField: false, contentType: .emailAddress),
            AuthenticationCellData(tag: 1, placeholder: "Username".localized, isSequreTextField: false, contentType: .username),
            AuthenticationCellData(tag: 2, placeholder: "Password. At least 6. Must contains num".localized, isSequreTextField: true, contentType: .password),
            AuthenticationCellData(tag: 3, placeholder: "Confirm password".localized, isSequreTextField: true, contentType: .confirmPassword)]
        presenter?.didReceiveData(data: data)
    }
}

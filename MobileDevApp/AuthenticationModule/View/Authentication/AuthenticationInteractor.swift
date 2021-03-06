//
//  AuthenticationInteractor.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.11.2021.
//

import Foundation

class AuthenticationInteractor {

    weak var presenter: AuthenticationInteractorOutputProtocol?

    required init(presenter: AuthenticationInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension AuthenticationInteractor: AuthenticationInteractorProtocol {

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
            saveUserData(cells: cells)
        }
        return errors
    }

    func checkRegistered(cells: [AuthenticationCell]) -> [ValidationErrorInfo] {
        var errors: [ValidationErrorInfo] = []
        for cell in cells {
            guard let text = cell.textField.text, let data = cell.cellData else { fatalError() }
            let errorData = AuthenticationHelper.shared.checkRegistered(text: text, contentType: data.contentType)
            if !errorData.isValid {
                cell.makeTextFieldInvalid()
                errors.append(errorData)
            }
        }
        return errors
    }

    func fetchRegistrationData() {
        let data = [
            AuthenticationCellData(tag: 0, placeholder: "Email".localized, isSequreTextField: false, contentType: .emailAddress),
            AuthenticationCellData(tag: 1, placeholder: "Username".localized, isSequreTextField: false, contentType: .username),
            AuthenticationCellData(tag: 2, placeholder: "Password. At least 6. Must contains num".localized, isSequreTextField: true, contentType: .password),
            AuthenticationCellData(tag: 3, placeholder: "Confirm password".localized, isSequreTextField: true, contentType: .confirmPassword)]
        presenter?.didReceiveData(data: data)
    }

    func fetchLoginData() {
        let data = [
            AuthenticationCellData(tag: 0, placeholder: "Username".localized, isSequreTextField: false, contentType: .username),
            AuthenticationCellData(tag: 1, placeholder: "Password".localized, isSequreTextField: true, contentType: .password)]
        presenter?.didReceiveData(data: data)
    }

    private func saveUserData(cells: [AuthenticationCell]) {
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
}

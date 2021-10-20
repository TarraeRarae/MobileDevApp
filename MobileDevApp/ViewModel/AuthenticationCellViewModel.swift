//
//  AuthenticationCellViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import UIKit

class AuthenticationCellViewModel: TableViewCellViewModelProtocol {

    struct Constant {

        static let usernameKey = "Username"
        static let userPasswordKey = "UserPassword"
    }

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

    public func validate(text: String?) -> ValidationErrorInfo {
        guard let delegate = delegate else { fatalError() }
        guard let text = text else { return ValidationErrorInfo(isValid: false, errorInfo: nil) }
        if text.count == 0 {
            return ValidationErrorInfo(isValid: false, errorInfo: NSLocalizedString("Input data into all fields", comment: ""))
        }
        switch cellData.contentType {
        case .emailAddress:
            return delegate.validateEmail(email: text)
        case .password:
            if delegate.password == nil {
                return delegate.validatePassword(password: text)
            } else {
                return delegate.comparePasswords(password: text)
            }
        case .username:
            return ValidationErrorInfo(isValid: true, errorInfo: nil)
        default:
            return ValidationErrorInfo(isValid: false, errorInfo: NSLocalizedString("Unexpected error", comment: ""))
        }
    }

    public func checkRegistered(text: String?) -> ValidationErrorInfo {
        guard let delegate = delegate else { fatalError() }
        guard let text = text else { return ValidationErrorInfo(isValid: false, errorInfo: nil) }
        if text.count == 0 {
            return ValidationErrorInfo(isValid: false, errorInfo: NSLocalizedString("Input data into all fields", comment: ""))
        }
        switch cellData.contentType {
        case .username:
            return delegate.checkUsername(username: text)
        case .password:
            return delegate.checkPassword(password: text)
        default:
            return ValidationErrorInfo(isValid: false, errorInfo: NSLocalizedString("Unexpected error", comment: ""))
        }
    }

    public func saveUserData(text: String) {
        switch cellData.contentType {
        case .username:
            UserDefaults.standard.set(text, forKey: AuthenticationCellViewModel.Constant.usernameKey)
        case .password:
            UserDefaults.standard.set(text, forKey: AuthenticationCellViewModel.Constant.userPasswordKey)
        default:
            return
        }
    }
}

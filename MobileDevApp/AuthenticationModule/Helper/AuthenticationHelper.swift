//
//  Helper.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.10.2021.
//

import Foundation

class AuthenticationHelper {

    struct Constant {
        static let usernameKey = "Username"
        static let userPasswordKey = "UserPassword"
        static let nextButtonImageName = "arrow.right"
        static let backgroundImageName = "background"
    }

    static var shared = AuthenticationHelper()

    var password: String?

    func validateRegistrationData(text: String, contentType: AuthenticationCellContentType) -> ValidationErrorInfo {
        if text == "" {
            return ValidationErrorInfo(isValid: false, errorInfo: "Input data into all fields".localized)
        }
        switch contentType {
        case .emailAddress:
            return validateEmail(email: text)
        case .username:
            return ValidationErrorInfo(isValid: true, errorInfo: nil)
        case .password:
            return validatePassword(password: text)
        case .confirmPassword:
            return comparePasswords(password: text)
        }
    }

    func saveUsername(text: String) {
        UserDefaults.standard.set(text, forKey: AuthenticationHelper.Constant.usernameKey)
    }

    func saveUserPassword(text: String) {
        UserDefaults.standard.set(text, forKey: AuthenticationHelper.Constant.userPasswordKey)
    }

    private func validateEmail(email: String) -> ValidationErrorInfo {
        var isValid = true
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        isValid = NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
        if isValid {
            return ValidationErrorInfo(isValid: isValid, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isValid, errorInfo: "Email isn't valid".localized)
    }

    private func validatePassword(password: String) -> ValidationErrorInfo {
        var isValid = true
        isValid = isValid && (password.count >= 6)

        let numberRegEx  = ".*[0-9]+.*"
        let numberCase = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        isValid = isValid && numberCase.evaluate(with: password)

        if isValid {
            self.password = password
            return ValidationErrorInfo(isValid: isValid, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isValid, errorInfo: "Password must contains 6 or more symbols and at least 1 number".localized)
    }

    private func comparePasswords(password: String) -> ValidationErrorInfo {
        guard self.password != nil else {
            return ValidationErrorInfo(isValid: false, errorInfo: nil)
        }
        let isValid = password == self.password
        self.password = nil
        if isValid {
            return ValidationErrorInfo(isValid: isValid, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isValid, errorInfo: "Passwords aren't equal".localized)
    }

    private func checkUsername(username: String) -> ValidationErrorInfo {
        let isChecked = UserDefaults.standard.string(forKey: AuthenticationHelper.Constant.usernameKey) == username
        if isChecked {
            return ValidationErrorInfo(isValid: isChecked, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isChecked, errorInfo: "Incorrect username".localized)
    }

    private func checkPassword(password: String) -> ValidationErrorInfo {
        let isChecked = UserDefaults.standard.string(forKey: AuthenticationHelper.Constant.userPasswordKey) == password
        self.password = password
        if isChecked {
            return ValidationErrorInfo(isValid: isChecked, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isChecked, errorInfo: "Incorrect password".localized)
    }
}

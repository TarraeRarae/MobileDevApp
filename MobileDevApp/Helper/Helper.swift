//
//  Helper.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.10.2021.
//

import Foundation

class Helper: AuthenticationCellViewModelDelegate {

    var password: String?

    func validateEmail(email: String) -> ValidationErrorInfo {
        var isValid = true
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        isValid = NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
        if isValid {
            return ValidationErrorInfo(isValid: isValid, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isValid, errorInfo: "Email isn't valid")
    }

    func validatePassword(password: String) -> ValidationErrorInfo {
        var isValid = true
        isValid = isValid && (password.count >= 6)

        let numberRegEx  = ".*[0-9]+.*"
        let numberCase = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        isValid = isValid && numberCase.evaluate(with: password)

        if isValid {
            self.password = password
            return ValidationErrorInfo(isValid: isValid, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isValid, errorInfo: "Password must have 6 or more symbols and at least 1 number")
    }

    func checkUsername(username: String) -> ValidationErrorInfo {
        let isValid = UserDefaults.standard.string(forKey: "Username") == username
        if isValid {
            return ValidationErrorInfo(isValid: isValid, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isValid, errorInfo: "Incorrect username")
    }

    func checkPassword(password: String) -> ValidationErrorInfo {
        let isValid = UserDefaults.standard.string(forKey: "UserPassword") == password
        self.password = password
        if isValid {
            return ValidationErrorInfo(isValid: isValid, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isValid, errorInfo: "Incorrect password")
    }

    func comparePasswords(password: String) -> ValidationErrorInfo {
        let isValid = password == self.password
        self.password = nil
        if isValid {
            return ValidationErrorInfo(isValid: isValid, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isValid, errorInfo: "Passwords aren't equal")
    }
}

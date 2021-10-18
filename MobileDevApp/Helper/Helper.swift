//
//  Helper.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.10.2021.
//

import Foundation

class Helper {

    var password: String?

    func validateEmail(text: String) -> ValidationErrorInfo {
        var isValid = true
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        isValid = NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: text)
        if isValid {
            return ValidationErrorInfo(isValid: isValid, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isValid, errorInfo: "Email isn't valid")
    }

    func validatePassword(text: String) -> ValidationErrorInfo {
        var isValid = true
        isValid = isValid && (text.count >= 6)

        let numberRegEx  = ".*[0-9]+.*"
        let numberCase = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        isValid = isValid && numberCase.evaluate(with: text)

        if isValid {
            return ValidationErrorInfo(isValid: isValid, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isValid, errorInfo: "Password must have 6 or more symbols, lowercase, uppercase characters and at leaset 1 number")
    }

    func checkUsername(text: String) -> ValidationErrorInfo {
        let isValid = UserDefaults.standard.string(forKey: "Username") == text
        if isValid {
            return ValidationErrorInfo(isValid: isValid, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isValid, errorInfo: "Incorrect username")
    }

    func checkPassword(text: String) -> ValidationErrorInfo {
        let isValid = UserDefaults.standard.string(forKey: "UserPassword") == text
        if isValid {
            return ValidationErrorInfo(isValid: isValid, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isValid, errorInfo: "Incorrect password")
    }

    func comparePasswords(password: String) -> ValidationErrorInfo {
        let isValid = password == self.password
        if isValid {
            return ValidationErrorInfo(isValid: isValid, errorInfo: nil)
        }
        return ValidationErrorInfo(isValid: isValid, errorInfo: "Passwords aren't equal")
    }
}

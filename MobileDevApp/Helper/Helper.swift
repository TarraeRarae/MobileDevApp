//
//  Helper.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.10.2021.
//

import Foundation

class Helper {

    static func validateEmail(text: String) -> ValidationData {
        var isValid = true
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        isValid = NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: text)
        if isValid {
            return ValidationData(isValid: isValid, error: nil)
        }
        return ValidationData(isValid: isValid, error: .badEmail(text: "Email isn't valid"))
    }

    static func validatePassword(text: String) -> ValidationData {
        var isValid = true
        isValid = isValid && (text.count >= 6)

        let lowerCase = ".*[A-Z]+.*"
        let testLowerCase = NSPredicate(format: "SELF MATCHES %@", lowerCase)
        isValid = isValid && testLowerCase.evaluate(with: text)

        let upperCase = ".*[a-z]+.*"
        let testUpperCase = NSPredicate(format: "SELF MATCHES %@", upperCase)
        isValid = isValid && testUpperCase.evaluate(with: text)

        let numberRegEx  = ".*[0-9]+.*"
        let testCase = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        isValid = isValid && testCase.evaluate(with: text)

        if isValid {
            return ValidationData(isValid: isValid, error: nil)
        }
        return ValidationData(isValid: isValid, error: .badPasswordFormat(text: "Password must have 6 or more symbols, lowercase, uppercase characters and at leaset 1 number"))
    }

    static func checkUsername(text: String) -> ValidationData {
        let isValid = UserDefaults.standard.string(forKey: "Username") == text
        if isValid {
            return ValidationData(isValid: isValid, error: nil)
        }
        return ValidationData(isValid: isValid, error: nil)
    }

    static func checkPassword(text: String) -> ValidationData {
        let isValid = UserDefaults.standard.string(forKey: "UserPassword") == text
        if isValid {
            return ValidationData(isValid: isValid, error: nil)
        }
        return ValidationData(isValid: isValid, error: .badPasswordFormat(text: "Incorrect password"))
    }

    static func comparePasswords(firstPassword: String, secondPassword: String) -> ValidationData {
        let isValid = firstPassword == secondPassword
        if isValid {
            return ValidationData(isValid: isValid, error: nil)
        }
        return ValidationData(isValid: isValid, error: .notEqualPasswords(text: "Passwords aren't equal"))
    }
}

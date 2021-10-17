//
//  ValidatorManager.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 08.10.2021.
//

import UIKit

class RegistrationValidationManager: AuthenticationCellViewModelDelegate {

    var password: String?

    func validateTextField(text: String?, textContentType: UITextContentType) -> Bool {
        guard let text = text else { return false }
        var isValid = true
        switch textContentType {
        case UITextContentType.emailAddress:
            isValid = validateEmail(text: text)
        case UITextContentType.password:
            isValid = validatePassword(text: text)
        default:
            break
        }
        if isValid {
            switch textContentType {
            case .username:
                UserDefaults.standard.set(text, forKey: "Username")
            case .password:
                UserDefaults.standard.set(text, forKey: "UserPassword")
            default:
                break
            }
        }
        return isValid
    }

    private func validateEmail(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: text)
    }

    private func validatePassword(text: String) -> Bool {
        if password != nil {
            if password != text {
                return false
            }
        }

        if text.count < 6 {
            return false
        }

        let lowerCase = ".*[A-Z]+.*"
        let testLowerCase = NSPredicate(format: "SELF MATCHES %@", lowerCase)
        if !testLowerCase.evaluate(with: text) {
            return false
        }

        let upperCase = ".*[a-z]+.*"
        let testUpperCase = NSPredicate(format: "SELF MATCHES %@", upperCase)
        if !testUpperCase.evaluate(with: text) {
            return false
        }

        let numberRegEx  = ".*[0-9]+.*"
        let testCase = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        if !testCase.evaluate(with: text) {
            return false
        }

        if self.password == nil {
            password = text
        }

        return true
    }
}

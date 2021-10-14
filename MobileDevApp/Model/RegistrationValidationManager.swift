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

        switch textContentType {
        case UITextContentType.emailAddress:
            return validateEmail(text: text)
        case UITextContentType.password:
            return validatePassword(text: text)
        default:
            return true
        }
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

//    func isLoginTextFieldValid(_ textField: UITextField) -> Bool {
//        switch textField.textContentType {
//        case UITextContentType.emailAddress:
//            if UserDefaults.standard.string(forKey: "Username") == textField.text {
//                return true
//            }
//            return false
//        case UITextContentType.password:
//            if UserDefaults.standard.string(forKey: "UserPassword") == textField.text {
//                return true
//            }
//            return false
//        default:
//            return false
//        }
//    }
}

//
//  LoginValidationManager.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.10.2021.
//

import UIKit

class LoginValidationManager: AuthenticationCellViewModelDelegate {

    func validateTextField(text: String?, textContentType: UITextContentType) -> Bool {
        switch textContentType {
        case UITextContentType.password:
            if UserDefaults.standard.string(forKey: "UserPassword") == text {
                return true
            }
            return false
        default:
            return true
        }
    }
}

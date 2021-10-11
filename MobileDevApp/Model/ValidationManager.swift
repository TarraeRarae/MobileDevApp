//
//  ValidatorManager.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 08.10.2021.
//

import UIKit

class ValidationManager {

	static var password: String?

	static func isRegistrationTextFieldValid(_ textField: UITextField) -> Bool {
		if !textField.hasText {
			return false
		}
		switch textField.textContentType {
		case UITextContentType.emailAddress:
			let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
			return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: textField.text)
		case UITextContentType.password:
			if password != nil {
				if password != textField.text {
					print("password != textField.text")
					return false
				}
			}
			let sizeOfPass = textField.text!.count >= 6 ? true : false

			let lowerCase = ".*[A-Z]+.*"
			let testLowerCase = NSPredicate(format: "SELF MATCHES %@", lowerCase)
			let isContainLowerCase = testLowerCase.evaluate(with: textField.text)

			let upperCase = ".*[a-z]+.*"
			let testUpperCase = NSPredicate(format: "SELF MATCHES %@", upperCase)
			let isContainUpperCase = testUpperCase.evaluate(with: textField.text)

			let numberRegEx  = ".*[0-9]+.*"
			let testCase = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
			let containsNumber = testCase.evaluate(with: textField.text)

			if isContainUpperCase && containsNumber && sizeOfPass && isContainLowerCase && password == nil {
				password = textField.text
				return true
			}
			return isContainUpperCase && containsNumber && sizeOfPass && isContainLowerCase
		default:
			return true
		}
	}

	static func isLoginTextFieldValid(_ textField: UITextField) -> Bool {
		switch textField.textContentType {
		case UITextContentType.emailAddress:
			if UserDefaults.standard.string(forKey: "Username") == textField.text {
				return true
			}
			return false
		case UITextContentType.password:
			if UserDefaults.standard.string(forKey: "UserPassword") == textField.text {
				return true
			}
			return false
		default:
			return false
		}
	}
}

//
//  AuthenticationCellViewModelDelegate.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import Foundation

protocol AuthenticationCellViewModelDelegate: AnyObject {

    var password: String? { get }
    func validateEmail(email: String) -> ValidationErrorInfo
    func validatePassword(password: String) -> ValidationErrorInfo
    func checkUsername(username: String) -> ValidationErrorInfo
    func checkPassword(password: String) -> ValidationErrorInfo
    func comparePasswords(password: String) -> ValidationErrorInfo
}

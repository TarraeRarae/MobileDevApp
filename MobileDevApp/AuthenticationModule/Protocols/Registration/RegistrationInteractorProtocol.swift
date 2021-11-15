//
//  AuthenticationInteractorProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.11.2021.
//

import UIKit

protocol RegistrationInteractorProtocol: AnyObject {

    func fetchRegistrationData()
    func fetchLoginData()
    func validateData(cells: [AuthenticationCell]) -> [ValidationErrorInfo]
    func checkRegistered(cells: [AuthenticationCell]) -> [ValidationErrorInfo]
}

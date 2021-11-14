//
//  AuthenticationInteractorProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.11.2021.
//

import UIKit

protocol RegistrationInteractorProtocol: AnyObject {

    func fetchData()
    func validateData(cells: [AuthenticationCell]) -> [ValidationErrorInfo]
}

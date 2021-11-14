//
//  AuthenticationViewControllerProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.11.2021.
//

import Foundation

protocol RegistrationViewControllerProtocol: AnyObject {

    func reloadData()
    func setupAlertController(data: Set<String>)
}

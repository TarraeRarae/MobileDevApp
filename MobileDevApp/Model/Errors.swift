//
//  ErrorsEnum.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.10.2021.
//

import Foundation

enum Errors {

    case badEmail(text: String)
    case badPasswordFormat(text: String)
    case notEqualPasswords(text: String)
    case badUsername(text: String)
}

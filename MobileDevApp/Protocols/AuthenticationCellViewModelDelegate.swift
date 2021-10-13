//
//  AuthenticationCellViewModelDelegate.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import Foundation
import UIKit

protocol AuthenticationCellViewModelDelegate: AnyObject {
    func validateTextField(text: String, textContentType: UITextContentType) -> Bool
}

//
//  TableViewCellViewModelProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import Foundation
import UIKit

protocol TableViewCellViewModelProtocol: AnyObject {
    var placeholder: String { get }
    var contentType: UITextContentType { get }
    var isSequreTextField: Bool { get }
    func validate(text: String?) -> Bool
}

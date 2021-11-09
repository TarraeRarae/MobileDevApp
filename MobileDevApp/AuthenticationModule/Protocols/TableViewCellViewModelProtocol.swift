//
//  TableViewCellViewModelProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import UIKit

protocol TableViewCellViewModelProtocol: AnyObject {

    var cellData: AuthenticationCellData { get }
    var placeholder: String { get }
    var contentType: UITextContentType { get }
    var isSequreTextField: Bool { get }
    var tag: Int { get }
    func moveToNextTextField()
}

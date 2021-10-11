//
//  AuthenticationCell.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 27.09.2021.
//

import UIKit

class AuthenticationCell: UITableViewCell {
	
	struct Constant {
	
		static let cellID = "CellID"
		static let nibName = "AuthenticationCell"

	}
	
	@IBOutlet private var textField: UITextField!

	override func awakeFromNib() {
		super.awakeFromNib()
		backgroundColor = .white
		textField.textAlignment = .left
		textField.autocorrectionType = .no
		textField.clearButtonMode = .unlessEditing
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		textField.textContentType = .none
		textField.placeholder = nil
		textField.isSecureTextEntry = false
		textField.accessibilityIdentifier = nil
	}

	public func setTextField(contentType: UITextContentType, placeholder: String, isSecureTextEntry: Bool, identifier: String) {
		textField.textContentType = contentType
		textField.placeholder = placeholder
		textField.isSecureTextEntry = isSecureTextEntry
		textField.accessibilityIdentifier = identifier
	}
}

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
		static let rowHeight: CGFloat = 50
	}

    @IBOutlet private var textField: UITextField! {
        didSet {
            
        }
    }
    weak var viewModel: TableViewCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            textField.placeholder = viewModel.placeholder
            textField.textContentType = viewModel.contentType
            textField.isSecureTextEntry = viewModel.isSequreTextField
        }
    }

	override func awakeFromNib() {
		super.awakeFromNib()
		backgroundColor = .white
		customizeTextField()
	}

	private func customizeTextField() {
		textField.backgroundColor = .clear
		textField.textAlignment = .left
		textField.autocorrectionType = .no
		textField.clearButtonMode = .unlessEditing
		textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
		textField.leftViewMode = .always

		let bottomLine = CALayer()
		bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.bounds.width, height: 1.0)
		bottomLine.backgroundColor = UIColor.black.cgColor
		textField.borderStyle = .none
		textField.layer.addSublayer(bottomLine)
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		makeTextFieldValid()
		textField.text = nil
		textField.textContentType = .none
		textField.placeholder = nil
		textField.isSecureTextEntry = false
	}

	public func getTextField() -> UITextField {
		return textField
	}

	public func makeTextFieldInvalid() {
		if textField.hasText {
			textField.textColor = .red
			return
		}
		textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
	}

	private func makeTextFieldValid() {
		textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderText])
	}

	@objc private func textFieldDidChange(textField: UITextField) {
			makeTextFieldValid()
	}
}

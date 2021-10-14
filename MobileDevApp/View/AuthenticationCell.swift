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

    @IBOutlet private var textField: UITextField!

    weak var viewModel: TableViewCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            textField.placeholder = viewModel.placeholder
            textField.textContentType = viewModel.contentType
            textField.isSecureTextEntry = viewModel.isSequreTextField
        }
    }
    var isTextFieldValid: Bool {
        return validateAuthenticationCellTextField()
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
        textField.keyboardType = .default
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

    private func makeTextFieldInvalid() {
        textField.textColor = .red
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }

    private func makeTextFieldValid() {
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderText])
    }

    private func validateAuthenticationCellTextField() -> Bool {
        guard let viewModel = viewModel, let text = textField.text else {
            return false
        }
        if viewModel.validate(text: text) {
            makeTextFieldValid()
            return true
        }
        makeTextFieldInvalid()
        return false
    }
}

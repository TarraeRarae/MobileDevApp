//
//  AuthenticationCell.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 27.09.2021.
//

import UIKit

class AuthenticationCell: UITableViewCell, UITextFieldDelegate {

    struct Constant {

        static let cellID = "CellID"
        static let nibName = "AuthenticationCell"
        static let rowHeight: CGFloat = 50
    }

    @IBOutlet private var textField: UITextField!
    @IBOutlet private var showPasswordButton: UIButton!

    var viewModel: TableViewCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            textField.placeholder = viewModel.placeholder
            textField.textContentType = viewModel.contentType
            textField.isSecureTextEntry = viewModel.isSequreTextField
            setupShowPasswordButton(isSecure: textField.isSecureTextEntry)
            makeTextFieldValid()
        }
    }

    var isTextFieldValid: ValidationErrorInfo {
        return validateAuthenticationCellTextField()
    }

    var isTextFieldRegistered: ValidationErrorInfo {
        return checkTextFieldRegistered()
    }

    override func draw(_ rect: CGRect) {
        customizeTextField()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    private func customizeTextField() {
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.autocorrectionType = .no
        textField.clearButtonMode = .unlessEditing
        textField.keyboardType = .default
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: AuthenticationCell.Constant.rowHeight))
        textField.leftViewMode = .always
        textField.borderStyle = .none
        textField.delegate = self
        addBottomBorderToTextField()
    }

    private func addBottomBorderToTextField() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: AuthenticationCell.Constant.rowHeight - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.label.cgColor
        textField.layer.addSublayer(bottomLine)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = nil
        textField.textContentType = .none
        textField.placeholder = nil
        textField.isSecureTextEntry = false
        setupShowPasswordButton(isSecure: textField.isSecureTextEntry)
    }

    public func saveUserData() {
        if let viewModel = viewModel, let text = textField.text {
            viewModel.saveUserData(text: text)
        }
    }

    private func makeTextFieldInvalid() {
        textField.textColor = .red
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.3)])
    }

    private func makeTextFieldValid() {
        textField.textColor = .label
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.label.withAlphaComponent(0.3)])
    }

    private func validateAuthenticationCellTextField() -> ValidationErrorInfo {
        guard let viewModel = viewModel, let text = textField.text else {
            makeTextFieldInvalid()
            return ValidationErrorInfo(isValid: false, errorInfo: nil)
        }
        let errorInfo = viewModel.validate(text: text)
        if !errorInfo.isValid {
            makeTextFieldInvalid()
        }
        return errorInfo
    }

    private func checkTextFieldRegistered() -> ValidationErrorInfo {
        guard let viewModel = viewModel, let text = textField.text else {
            makeTextFieldInvalid()
            return ValidationErrorInfo(isValid: false, errorInfo: nil)
        }
        let errorInfo = viewModel.checkRegistered(text: text)
        if !errorInfo.isValid {
            makeTextFieldInvalid()
        }
        return errorInfo
    }

    private func setupShowPasswordButton(isSecure: Bool) {
        if isSecure {
            showPasswordButton.isEnabled = true
            showPasswordButton.isHidden = false
            return
        }
        showPasswordButton.isEnabled = false
        showPasswordButton.isHidden = true
    }

    @IBAction func changePasswordVisibility(_ sender: Any) {
        if textField.isSecureTextEntry {
            textField.isSecureTextEntry = false
        } else {
            textField.isSecureTextEntry = true
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        makeTextFieldValid()
        return true
    }
}

//
//  AuthenticationCell.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 27.09.2021.
//

import UIKit

class AuthenticationCell: UITableViewCell, UITextFieldDelegate {

    struct Constant {

        static let cellID = "AuthenticationCellID"
        static let nibName = "AuthenticationCell"
        static let rowHeight: CGFloat = 50
    }

    @IBOutlet var textField: UITextField!
    @IBOutlet private var showPasswordButton: UIButton!

    var viewModel: TableViewCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            textField.tag = viewModel.tag
            textField.placeholder = viewModel.placeholder
            textField.textContentType = viewModel.contentType
            textField.isSecureTextEntry = viewModel.isSequreTextField
            setupShowPasswordButton(isSecure: textField.isSecureTextEntry)
            makeTextFieldValid()
        }
    }

    override func draw(_ rect: CGRect) {
        customizeTextField()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    private func customizeTextField() {
        textField.keyboardAppearance = .default
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

    func makeTextFieldInvalid() {
        textField.textColor = .red
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.3)])
    }

    func makeTextFieldValid() {
        textField.textColor = .label
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.label.withAlphaComponent(0.3)])
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
        textField.isSecureTextEntry.toggle()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        makeTextFieldValid()
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let viewModel = viewModel else { return false }
        textField.resignFirstResponder()
        viewModel.moveToNextTextField()
        return true
    }

}

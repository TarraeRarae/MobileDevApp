//
//  AuthenticationTableFooterView.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 17.10.2021.
//

import UIKit

class RegistraionTableFooterView: UIView {

    weak var delegate: TableFooterViewDelegate?

    private let nextButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 1.0, height: 3)
        button.addTarget(nil, action: #selector(register), for: .touchUpInside)
        button.setImage(UIImage(systemName: AuthenticationHelper.Constant.nextButtonImageName), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.tintColor = .black
        button.isEnabled = false
        return button
    }()

    private let confirmLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm our privacy policy".localized
        label.textColor = .label
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private let confirmSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.addTarget(self, action: #selector(changeSwitcherValue), for: .valueChanged)
        switcher.isOn = false
        return switcher
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(nextButton)
        self.addSubview(confirmLabel)
        self.addSubview(confirmSwitch)
        setupNextButton()
        setupSwitcher()
        setupConfirmLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateSwitcher() {
        confirmSwitch.isOn = false
        nextButton.isEnabled = false
    }

    public func enableSwitcher() {
        self.confirmSwitch.isEnabled = true
    }

    public func disableSwitcher() {
        self.confirmSwitch.isEnabled = false
    }

    private func setupNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: confirmLabel.topAnchor, constant: self.frame.height * 0.25),
            nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width * 0.4)
        ])
    }

    private func setupConfirmLabel() {
        confirmLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.1),
            confirmLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.frame.width * 0.05),
            confirmLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            confirmLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3)
        ])
    }

    private func setupSwitcher() {
        confirmSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmSwitch.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.11),
            confirmSwitch.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width * 0.2),
            confirmSwitch.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            confirmSwitch.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25)
        ])
    }

    @objc func register() {
        delegate?.authorize()
    }

    @objc func changeSwitcherValue() {
        if nextButton.isEnabled {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
}

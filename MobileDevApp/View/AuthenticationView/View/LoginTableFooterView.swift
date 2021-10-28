//
//  LoginTableFooterView.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 17.10.2021.
//

import UIKit

class LoginTableFooterView: UIView {

    weak var delegate: TableFooterViewDelegate?

    private let nextButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 1.0, height: 3)
        button.addTarget(nil, action: #selector(register), for: .touchUpInside)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.tintColor = .black
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupNextButton()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupNextButton() {
        self.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: self.topAnchor, constant: self.bounds.height * 0.4),
            nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nextButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            nextButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])
    }

    @objc func register() {
        delegate?.authorize()
    }
}

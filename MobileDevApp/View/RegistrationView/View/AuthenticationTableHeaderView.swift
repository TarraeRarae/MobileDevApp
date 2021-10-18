//
//  RegistrationView.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 16.10.2021.
//

import UIKit

class AuthenticationTableHeaderView: UIView {

    weak var delegate: TableHeaderViewDelegate?
    var pageControll: UISegmentedControl = {
        let segmentedControll = UISegmentedControl()
        segmentedControll.backgroundColor = .white
        segmentedControll.selectedSegmentTintColor = .white
        segmentedControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        segmentedControll.insertSegment(withTitle: NSLocalizedString("Login", comment: ""), at: 0, animated: true)
        segmentedControll.insertSegment(withTitle: NSLocalizedString("Registration", comment: ""), at: 1, animated: true)
        segmentedControll.selectedSegmentIndex = 1
        segmentedControll.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        segmentedControll.endEditing(true)
        segmentedControll.layer.shadowColor = UIColor.black.cgColor
        segmentedControll.layer.shadowRadius = 10
        segmentedControll.layer.shadowOpacity = 0.5
        return segmentedControll
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(pageControll)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConstraints() {
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControll.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageControll.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pageControll.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            pageControll.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15)
        ])
    }

    @objc func indexChanged(_ sender: UISegmentedControl) {
        delegate?.updateTableView()
    }
}

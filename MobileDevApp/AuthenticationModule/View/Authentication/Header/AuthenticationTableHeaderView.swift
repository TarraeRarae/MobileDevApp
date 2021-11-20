//
//  RegistrationView.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 16.10.2021.
//

import UIKit
import IQKeyboardManagerSwift

class AuthenticationTableHeaderView: UIView {

    weak var delegate: TableHeaderViewDelegate?

    var pageControll: UISegmentedControl = {
        let segmentedControll = UISegmentedControl()
        segmentedControll.isEnabled = true
        segmentedControll.backgroundColor = .white
        segmentedControll.selectedSegmentTintColor = .white
        segmentedControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        segmentedControll.insertSegment(withTitle: "Login".localized, at: 0, animated: true)
        segmentedControll.insertSegment(withTitle: "Registration".localized, at: 1, animated: true)
        segmentedControll.selectedSegmentIndex = 1
        segmentedControll.addTarget(self, action: #selector(segmentedControllIndexChanged(_:)), for: .valueChanged)
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

    public func enableSegmentedControll() {
        pageControll.isEnabled = true
    }

    public func disableSegmentedControll() {
        pageControll.isEnabled = false
    }

    public func getCurrentSegmentIndex() -> Int {
        return pageControll.selectedSegmentIndex
    }

    @objc func segmentedControllIndexChanged(_ sender: UISegmentedControl) {
        delegate?.updateTableView(indexOfSection: sender.selectedSegmentIndex)
    }
}

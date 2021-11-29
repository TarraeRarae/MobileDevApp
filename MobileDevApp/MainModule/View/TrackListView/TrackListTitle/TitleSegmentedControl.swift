//
//  TitleSegmentedControl.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 20.11.2021.
//

import UIKit

class TitleSegmentedControl: UISegmentedControl {

    weak var delegate: TitleSegmentedControlDelegate?

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: frame.width / 2, height: frame.height * 0.02))
        customizeSegmentedControl()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customizeSegmentedControl() {
        self.layer.zPosition = 2
        self.isEnabled = true
        self.backgroundColor = .clear
        self.selectedSegmentTintColor = .systemRed
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.label], for: .normal)
        self.insertSegment(withTitle: "Online".localized, at: 0, animated: true)
        self.insertSegment(withTitle: "Downloaded".localized, at: 1, animated: true)
        self.selectedSegmentIndex = 0
        self.addTarget(self, action: #selector(segmentedControllIndexChanged), for: .valueChanged)
        self.endEditing(true)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
    }

    @objc private func segmentedControllIndexChanged() {
        delegate?.updateTableView(indexOfSection: self.selectedSegmentIndex)
    }
}

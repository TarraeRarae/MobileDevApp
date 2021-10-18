//
//  TrackListView.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.10.2021.
//

import UIKit

class TrackListView: UIView {

    private var authorizedLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("You're athorized", comment: "")
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = .white
        setupLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLabel() {
        self.addSubview(authorizedLabel)
        authorizedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorizedLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            authorizedLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            authorizedLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            authorizedLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3)
        ])
    }
}

//
//  TitleViewLeftBarButtonItem.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.12.2021.
//

import UIKit

class TitleViewLeftBarButton: UIBarButtonItem {

    weak var delegate: TitleViewLeftBarButtonDelegate?

    override init() {
        super.init()
        customizeLeftBarButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customizeLeftBarButton() {
        self.image = UIImage(systemName: MainHelper.StringConstant.chevronBackwardCircleImageName.rawValue)
        self.style = .plain
        self.action = #selector(tapped)
        self.tintColor = .systemRed
    }

    @objc private func tapped() {
        delegate?.presentExitAlert()
    }
}

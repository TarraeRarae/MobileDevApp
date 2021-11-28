//
//  TitleViewRightBarButton.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 20.11.2021.
//

import UIKit

class TitleViewRightBarButton: UIBarButtonItem {

    weak var delegate: TitleViewRightBarButtonDelegate?

    override init() {
        super.init()
        customizeRightBarButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customizeRightBarButton() {
        self.image = UIImage(systemName: MainHelper.StringConstant.moreMenuImageName.rawValue)
        self.style = .plain
        self.action = #selector(tapped)
        self.tintColor = .label
    }

    @objc private func tapped() {
        delegate?.presentMoreMenu()
    }
}

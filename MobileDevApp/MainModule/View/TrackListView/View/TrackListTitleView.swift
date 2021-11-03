//
//  TrackListView.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.10.2021.
//

import UIKit
import SnapKit

class TrackListTitleView: UIView {

    weak var delegate: TrackListTitleViewDelegate?

    private var moreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.tintColor = .black
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(nil, action: #selector(moreButtonAction), for: .touchUpInside)
        return button
    }()

    private var moreMenu: UIAlertController {
        let alertController = UIAlertController(title: "More", message: nil, preferredStyle: .actionSheet)
        let popover = alertController.popoverPresentationController
        popover?.sourceView = self
        popover?.sourceRect = CGRect(x: 32, y: 32, width: 64, height: 64)
        return alertController
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = .clear
        self.addSubview(moreButton)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton() {
        moreButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self).offset(350)
            make.width.equalTo(30)
            make.height.equalTo(27)
        }

        moreButton.imageEdgeInsets = UIEdgeInsets(
              top: moreButton.frame.size.height / 2,
              left: moreButton.frame.size.width  / 2,
              bottom: moreButton.frame.size.height / 2,
              right: moreButton.frame.size.width / 2)
    }

    @objc private func moreButtonAction() {
        if let delegate = delegate {
            delegate.presentMoreMenu(alertController: self.moreMenu)
        }
    }
}

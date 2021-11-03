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

    private var moreButton  = UIButton()

    private var moreMenu: UIAlertController {
        let alertController = UIAlertController(title: "More", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        let popover = alertController.popoverPresentationController
        popover?.sourceView = self
        popover?.sourceRect = CGRect(x: 32, y: 32, width: 64, height: 64)
        return alertController
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton() {
        moreButton.addTarget(nil, action: #selector(moreButtonAction), for: .touchUpInside)
        moreButton.tintColor = .black
        moreButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        moreButton.contentHorizontalAlignment = .fill
        moreButton.contentVerticalAlignment = .fill

        self.addSubview(moreButton)

        moreButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self).offset(UIScreen.main.bounds.width * 0.83)
            make.height.equalTo(27)
            make.width.equalTo(30)
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

//
//  SingleTrackView.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 03.11.2021.
//

import UIKit
import SnapKit

class SingleTrackView: UIView {

    private var trackImageView: UIImageView = UIImageView(image: UIImage(named: "trackPlaceholder"))

    private var trackNameLabel: UILabel = {
        let label = UILabel()
        label.text = "TrackName"
        return label
    }()

    private var singerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "SingerName"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = .white
        setupTrackImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTrackImageView() {
        self.addSubview(trackImageView)
        trackImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(50)
            make.top.equalTo(self).offset(50)
            make.right.equalTo(self).offset(-50)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.5)
        }
    }

    private func setupTrackNameLabel() {
    }

    private func setupSingerNameLabel() {
    }
}

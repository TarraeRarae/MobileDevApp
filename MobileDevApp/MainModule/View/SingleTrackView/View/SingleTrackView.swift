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
        label.textColor = .label
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()

    private var singerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "SingerName"
        label.textColor = .label
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pause"), for: .normal)
        button.addTarget(nil, action: #selector(playTrack), for: .touchUpInside)
        button.backgroundColor = .clear
        button.tintColor = .label
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = .white
        setupTrackImageView()
        setupTrackNameLabel()
        setupSingerNameLabel()
        setupPlayButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTrackImageView() {
        trackImageView.backgroundColor = .clear
        self.addSubview(trackImageView)
        trackImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.5)
        }
    }

    private func setupTrackNameLabel() {
        self.addSubview(trackNameLabel)
        trackNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(self.frame.height * 0.5)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.4)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
        }
    }

    private func setupSingerNameLabel() {
        self.addSubview(singerNameLabel)
        singerNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(self.frame.height * 0.55)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.35)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
        }
    }

    private func setupPlayButton() {
        self.addSubview(playButton)
        playButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(self.frame.height * 0.7)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.13)
            make.left.equalTo(self).offset(self.frame.width * 0.4)
            make.right.equalTo(self).offset(-self.frame.width * 0.4)
        }

        playButton.imageEdgeInsets = UIEdgeInsets(
              top: playButton.frame.size.height / 2,
              left: playButton.frame.size.width  / 2,
              bottom: playButton.frame.size.height / 2,
              right: playButton.frame.size.width / 2)
    }

    @objc private func playTrack() {
        print("Tapped")
    }
}

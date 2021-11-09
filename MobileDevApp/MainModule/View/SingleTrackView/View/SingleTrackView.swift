//
//  SingleTrackView.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 03.11.2021.
//

import UIKit
import SnapKit

class SingleTrackView: UIView {

    weak var delegate: SingleTrackViewDelegate?
    private var trackImageView: UIImageView = UIImageView(image: UIImage(named: MainHelper.Constant.placeholderImageName))

    private var trackNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()

    private var singerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: MainHelper.Constant.pauseFillImageName), for: .normal)
        button.setImage(UIImage(systemName: MainHelper.Constant.playImageName), for: .selected)
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
        self.backgroundColor = .systemBackground
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
        trackImageView.contentMode = .scaleAspectFit
        self.addSubview(trackImageView)
        trackImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(self.frame.width * 0.05)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.4)
            make.left.equalTo(self).offset(self.frame.width * 0.05)
            make.right.equalTo(self).offset(-self.frame.width * 0.05)
        }
    }

    private func setupTrackNameLabel() {
        self.addSubview(trackNameLabel)
        trackNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(self.frame.height * 0.55)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.3)
            make.left.equalTo(self).offset(self.frame.width * 0.05)
            make.right.equalTo(self).offset(-self.frame.width * 0.05)
        }
    }

    private func setupSingerNameLabel() {
        self.addSubview(singerNameLabel)
        singerNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(self.frame.height * 0.6)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.25)
            make.left.equalTo(self).offset(self.frame.width * 0.05)
            make.right.equalTo(self).offset(-self.frame.width * 0.05)
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

    public func setTrackCondition(isPaused: Bool) {
        self.playButton.isSelected = isPaused
    }

    public func setTrackName(text: String) {
        self.trackNameLabel.text = text
    }

    public func setSingerName(text: String) {
        self.singerNameLabel.text = text
    }

    @objc private func playTrack() {
        playButton.isSelected.toggle()
        delegate?.updateTrackCondition(isPaused: playButton.isSelected)
    }
}

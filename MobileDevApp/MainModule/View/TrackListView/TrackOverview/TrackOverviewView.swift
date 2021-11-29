//
//  TrackOverviewView.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 04.11.2021.
//

import UIKit
import SnapKit

class TrackOverviewView: UIControl {

    weak var delegate: TrackOverviewDelegate?
    var data: TrackData?
    var isTrackPaused: Bool {
        return playButton.isSelected
    }

    private var trackImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: MainHelper.StringConstant.placeholderImageName.rawValue))
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()

    private var playButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: MainHelper.StringConstant.pauseImageName.rawValue), for: .normal)
        button.setImage(UIImage(systemName: MainHelper.StringConstant.playImageName.rawValue), for: .selected)
        button.addTarget(nil, action: #selector(playTrack), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.backgroundColor = .clear
        return button
    }()

    private var trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        label.backgroundColor = .clear
        return label
    }()

    private var singerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemRed
        label.backgroundColor = .clear
        return label
    }()

    private var closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: MainHelper.StringConstant.multiplyImageName.rawValue), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(nil, action: #selector(closeTrack), for: .touchUpInside)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.backgroundColor = .clear
        return button
    }()

    init(frame: CGRect, data: TrackData) {
        super.init(frame: frame)
        self.data = data
        let size = CGRect(x: 0, y: frame.height * 0.9, width: frame.width, height: frame.height * 0.1)
        self.frame = size
        self.addTarget(nil, action: #selector(showSingleTrackView), for: .touchUpInside)
        customizeView()
        setupPlayButton()
        setupTrackNameLabel()
        setupSingerNameLabel()
        setupCloseButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customizeView() {
        if let data = data {
            self.singerNameLabel.text = data.artists[0].name
            self.trackNameLabel.text = data.name
            setupTrackImageView()
        }
        self.backgroundColor = .white
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 0.5, width: self.frame.width, height: 0.3)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(bottomLine)
    }

    private func setupTrackImageView() {
        self.addSubview(trackImageView)
        trackImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(3)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.2)
            make.left.equalTo(self)
            make.width.equalTo(self.frame.width * 0.25)
        }
        guard let data = data else { return }
        guard data.imagesURLs.count != 0, let imageURL = URL(string: data.imagesURLs[0]) else { return }
        self.trackImageView.kf.setImage(with: imageURL)
        self.backgroundColor = trackImageView.image?.increaseContrast().areaAverage().mix(with: UIColor.white, amount: 0.8)
    }

    private func setupPlayButton() {
        self.addSubview(playButton)
        playButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.2)
            make.left.equalTo(self).offset(self.frame.width * 0.7)
            make.width.equalTo(self.frame.width * 0.15)
        }
        playButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }

    private func setupTrackNameLabel() {
        self.addSubview(trackNameLabel)
        trackNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.4)
            make.left.equalTo(self).offset(self.frame.width * 0.26)
            make.width.equalTo(self.frame.width * 0.44)
        }
    }

    private func setupSingerNameLabel() {
        self.addSubview(singerNameLabel)
        singerNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(self.frame.height * 0.4)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.2)
            make.left.equalTo(self).offset(self.frame.width * 0.26)
            make.width.equalTo(self.frame.width * 0.44)
        }
    }

    private func setupCloseButton() {
        self.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.2)
            make.right.equalTo(self).offset(0)
            make.width.equalTo(self.frame.width * 0.15)
        }
        closeButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    public func updateTrackCondition(isPaused: Bool) {
        self.playButton.isSelected = isPaused
    }

    @objc private func playTrack() {
        playButton.isSelected.toggle()
        print(playButton.isSelected)
        delegate?.trackOverviewPlayButtonDidTap(isPaused: playButton.isSelected)
    }

    @objc private func showSingleTrackView() {
        if let data = data, let delegate = delegate {
            delegate.presentSingleTrackView(data: data, isPaused: self.playButton.isSelected)
        }
    }

    @objc private func closeTrack() {
        delegate?.closeTrack()
    }
}

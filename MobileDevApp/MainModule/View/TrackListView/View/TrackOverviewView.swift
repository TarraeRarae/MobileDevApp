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
    var viewModel: TrackOverviewViewModelProtocol?
    var indexPath: IndexPath
    var isTrackPaused: Bool {
        return playButton.isSelected
    }

    private var trackImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: MainHelper.Constant.placeholderImageName))
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()

    private var playButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: MainHelper.Constant.pauseImageName), for: .normal)
        button.setImage(UIImage(systemName: MainHelper.Constant.playImageName), for: .selected)
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
        label.text = "TrackName"
        label.textColor = .label
        label.backgroundColor = .clear
        return label
    }()

    private var singerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "SingerName"
        label.textColor = .label
        label.backgroundColor = .clear
        return label
    }()

    private var closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: MainHelper.Constant.multiplyImageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(nil, action: #selector(closeTrack), for: .touchUpInside)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.backgroundColor = .clear
        return button
    }()

    init(frame: CGRect, viewModel: TrackOverviewViewModelProtocol?, for indexPath: IndexPath) {
        self.indexPath = indexPath
        super.init(frame: frame)
        self.viewModel = viewModel
        let size = CGRect(x: 0, y: frame.height * 0.91, width: frame.width, height: frame.height * 0.08)
        self.frame = size
        self.addTarget(nil, action: #selector(showSingleTrackView), for: .touchUpInside)
        self.backgroundColor = .systemBackground
        customizeView()
        setupTrackImageView()
        setupPlayButton()
        setupTrackNameLabel()
        setupSingerNameLabel()
        setupCloseButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customizeView() {
        if let viewModel = viewModel {
            self.singerNameLabel.text = viewModel.artistsNames[0]
            self.trackNameLabel.text = viewModel.trackName
        }
        self.backgroundColor = .clear
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 0.5, width: self.frame.width, height: 0.3)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(bottomLine)
    }

    private func setupTrackImageView() {
        self.addSubview(trackImageView)
        trackImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(3)
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.width.equalTo(self.frame.width * 0.25)
        }
    }

    private func setupPlayButton() {
        self.addSubview(playButton)
        playButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.left.equalTo(self).offset(self.frame.width * 0.7)
            make.width.equalTo(self.frame.width * 0.15)
        }
        playButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }

    private func setupTrackNameLabel() {
        self.addSubview(trackNameLabel)
        trackNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.5)
            make.left.equalTo(self).offset(self.frame.width * 0.26)
            make.width.equalTo(self.frame.width * 0.44)
        }
    }

    private func setupSingerNameLabel() {
        self.addSubview(singerNameLabel)
        singerNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(self.frame.height * 0.5)
            make.bottom.equalTo(self)
            make.left.equalTo(self).offset(self.frame.width * 0.26)
            make.width.equalTo(self.frame.width * 0.44)
        }
    }

    private func setupCloseButton() {
        self.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
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
    }

    @objc private func showSingleTrackView() {
        if let viewModel = viewModel, let delegate = delegate {
            delegate.presentSingleTrackView(viewModel: viewModel, isPaused: self.playButton.isSelected)
        }
    }

    @objc private func closeTrack() {
        delegate?.closeTrack()
    }
}

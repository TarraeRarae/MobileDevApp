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
    let data: TrackData

    var isTrackPaused: Bool {
        return playButton.isSelected
    }

    private var playButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: MainHelper.StringConstant.pauseImageName.rawValue), for: .normal)
        button.setImage(UIImage(systemName: MainHelper.StringConstant.playImageName.rawValue), for: .selected)
        button.addTarget(nil, action: #selector(playTrack), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()

    private var trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private var singerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemRed
        label.textAlignment = .center
        return label
    }()

    private var closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: MainHelper.StringConstant.multiplyImageName.rawValue), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(nil, action: #selector(closeTrack), for: .touchUpInside)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()

    init(frame: CGRect, data: TrackData) {
        self.data = data
        super.init(frame: .zero)
        let size = CGRect(x: 0, y: frame.height * 0.92, width: frame.width, height: frame.height * 0.08)
        self.frame = size
        setUpUI()
        setUpLayout()
        customize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {
        self.addSubview(playButton)
        self.addSubview(trackNameLabel)
        self.addSubview(singerNameLabel)
        self.addSubview(closeButton)
    }

    private func setUpLayout() {
        playButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(50)
        }

        trackNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(playButton.snp.right).offset(20)
            $0.right.equalTo(closeButton.snp.left).inset(-20)
            $0.height.equalTo(15)
        }

        singerNameLabel.snp.makeConstraints {
            $0.top.equalTo(trackNameLabel.snp.bottom).offset(5)
            $0.left.equalTo(playButton.snp.right).offset(20)
            $0.right.equalTo(closeButton.snp.left).inset(-20)
            $0.height.equalTo(15)
        }

        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.width.equalTo(60)
        }
    }

    private func customize() {
        self.addTarget(self, action: #selector(showSingleTrackView), for: .touchUpInside)
        // topLine - hz
//        let topLine = CALayer()
//        topLine.frame = CGRect(x: 0.0, y: 0.1, width: self.frame.width, height: 1)
//        topLine.backgroundColor = UIColor.red.withAlphaComponent(0.3).cgColor
//        self.layer.addSublayer(topLine)
        singerNameLabel.text = data.artists[0].name
        trackNameLabel.text = data.name
        playButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        closeButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    public func updateTrackCondition(isPaused: Bool) {
        self.playButton.isSelected = isPaused
    }

    @objc private func playTrack() {
        playButton.isSelected.toggle()
        delegate?.trackOverviewPlayButtonDidTap(isPaused: playButton.isSelected)
    }

    @objc private func showSingleTrackView() {
        if let delegate = delegate {
            delegate.presentSingleTrackView(data: data, isPaused: self.playButton.isSelected)
        }
    }

    @objc private func closeTrack() {
        delegate?.closeTrack()
    }
}

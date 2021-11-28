//
//  SingleTrackView.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 03.11.2021.
//

import UIKit
import SnapKit
import CoreMedia

class SingleTrackView: UIView {

    weak var delegate: SingleTrackViewDelegate?
    private var trackImageView: UIImageView = UIImageView(image: UIImage(named: MainHelper.StringConstant.placeholderImageName.rawValue))

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
        button.setImage(UIImage(systemName: MainHelper.StringConstant.pauseFillImageName.rawValue), for: .normal)
        button.setImage(UIImage(systemName: MainHelper.StringConstant.playImageName.rawValue), for: .selected)
        button.addTarget(nil, action: #selector(playTrack), for: .touchUpInside)
        button.backgroundColor = .clear
        button.tintColor = .label
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()

    private var trackSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .label
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()

    private var durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "0:\(MainHelper.FloatConstant.previewDurationInSeconds)"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = .systemBackground
        setupTrackImageView()
        setupTrackNameLabel()
        setupSingerNameLabel()
        setupTrackSlider()
        setupDurationLabel()
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
            make.bottom.equalTo(self).offset(-self.frame.height * 0.35)
            make.left.equalTo(self).offset(self.frame.width * 0.05)
            make.right.equalTo(self).offset(-self.frame.width * 0.05)
        }
    }

    private func setupSingerNameLabel() {
        self.addSubview(singerNameLabel)
        singerNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(self.frame.height * 0.6)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.3)
            make.left.equalTo(self).offset(self.frame.width * 0.05)
            make.right.equalTo(self).offset(-self.frame.width * 0.05)
        }
    }

    private func setupPlayButton() {
        self.addSubview(playButton)
        playButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(self.frame.height * 0.73)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.1)
            make.left.equalTo(self).offset(self.frame.width * 0.4)
            make.right.equalTo(self).offset(-self.frame.width * 0.4)
        }
        playButton.imageEdgeInsets = UIEdgeInsets(
              top: playButton.frame.size.height / 2,
              left: playButton.frame.size.width  / 2,
              bottom: playButton.frame.size.height / 2,
              right: playButton.frame.size.width / 2)
    }

    private func setupTrackSlider() {
        self.addSubview(trackSlider)
        trackSlider.snp.makeConstraints { make in
            make.top.equalTo(self).offset(self.frame.height * 0.65)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.25)
            make.left.equalTo(self).offset(self.frame.width * 0.2)
            make.right.equalTo(self).offset(-self.frame.width * 0.2)
        }
    }

    private func setupDurationLabel() {
        self.addSubview(durationLabel)
        durationLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(self.frame.height * 0.65)
            make.bottom.equalTo(self).offset(-self.frame.height * 0.25)
            make.left.equalTo(self).offset(self.frame.width * 0.82)
            make.right.equalTo(self).offset(-self.frame.width * 0.02)
        }
    }

    public func setTrackImage(imageURL: URL) {
        self.trackImageView.kf.setImage(with: imageURL)
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

    public func setSliderMaxValue(maxValue: Float) {
        trackSlider.minimumValue = 0
        trackSlider.maximumValue = maxValue / 1000
    }

    public func setSliderCurrentValue(newValue: Float) {
        trackSlider.value = newValue
        print("newValue = \(newValue)")
        if MainHelper.FloatConstant.previewDurationInSeconds.rawValue - newValue >= 10 {
            durationLabel.text = "0:\(Int(MainHelper.FloatConstant.previewDurationInSeconds.rawValue - newValue))"
        } else {
            durationLabel.text = "0:0\(Int(MainHelper.FloatConstant.previewDurationInSeconds.rawValue - newValue))"
        }
    }

    @objc private func playTrack() {
        playButton.isSelected.toggle()
        delegate?.playButtonTapped(isPaused: playButton.isSelected)
    }

    @objc private func sliderValueChanged() {
        delegate?.sliderValueChanged(newValue: trackSlider.value)
    }

}

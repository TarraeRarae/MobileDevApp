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

    private let trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: MainHelper.StringConstant.placeholderImageName.rawValue)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let infoLabelsContainer: UIView = {
        let view = UIView()
        return view
    }()

    private let bottomContainer: UIView = {
        let view = UIView()
        return view
    }()

    private var trackNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()

    private var singerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: MainHelper.StringConstant.pauseFillImageName.rawValue), for: .normal)
        button.setImage(UIImage(systemName: MainHelper.StringConstant.playImageName.rawValue), for: .selected)
        button.addTarget(nil, action: #selector(playTrack), for: .touchUpInside)
        button.tintColor = .label
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()

    private var trackSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .systemRed
        slider.thumbTintColor = .label
        slider.addTarget(self, action: #selector(sliderValueChangingDidStart), for: .touchDown)
        slider.addTarget(self, action: #selector(sliderValueChangingDidEnd), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderValueChangingDidEnd), for: .touchUpOutside)
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
        setUpUI()
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {
        self.addSubview(trackImageView)
        self.addSubview(infoLabelsContainer)
        self.addSubview(bottomContainer)
        infoLabelsContainer.addSubview(trackNameLabel)
        infoLabelsContainer.addSubview(singerNameLabel)
        bottomContainer.addSubview(trackSlider)
        bottomContainer.addSubview(durationLabel)
        bottomContainer.addSubview(playButton)
    }

    private func setUpLayout() {
        trackImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
            $0.height.lessThanOrEqualTo(self.frame.height / 2)
        }

        infoLabelsContainer.snp.makeConstraints {
            $0.top.equalTo(trackImageView.snp.bottom)
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview().inset(170)
            $0.right.equalToSuperview()
        }

        bottomContainer.snp.makeConstraints {
            $0.top.equalTo(infoLabelsContainer.snp.bottom)
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
        }

        trackNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(50)
            $0.right.equalToSuperview().inset(20)
        }

        singerNameLabel.snp.makeConstraints {
            $0.top.equalTo(trackNameLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview().inset(20)
        }

        trackSlider.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }

        durationLabel.snp.makeConstraints {
            $0.top.equalTo(trackSlider.snp.bottom).offset(10)
            $0.left.equalTo(playButton.snp.right).offset(95)
            $0.right.equalToSuperview().inset(20)
        }

        playButton.snp.makeConstraints {
            $0.top.equalTo(trackSlider.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(60)
        }
    }

    private func setDurationLabelValue(newValue value: Float) {
        if trackSlider.maximumValue - value >= 10 {
            durationLabel.text = "0:\(Int(trackSlider.maximumValue - value))"
        } else {
            durationLabel.text = "0:0\(Int(trackSlider.maximumValue - value))"
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
        setDurationLabelValue(newValue: newValue)
    }

    @objc private func playTrack() {
        playButton.isSelected.toggle()
        delegate?.playButtonTapped(isPaused: playButton.isSelected)
    }

    @objc private func sliderValueChangingDidStart() {
        delegate?.sliderDidTap()
    }

    @objc private func sliderValueChangingDidEnd() {
        delegate?.sliderValueChanged(newValue: trackSlider.value)
    }

    @objc private func sliderValueChanged() {
        setDurationLabelValue(newValue: trackSlider.value)
    }
}


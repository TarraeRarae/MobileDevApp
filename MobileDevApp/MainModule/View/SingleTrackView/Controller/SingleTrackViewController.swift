//
//  SingleTrackViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 03.11.2021.
//

import UIKit

class SingleTrackViewController: UIViewController {

    weak var delegate: SingleTrackViewControllerDelegate?
    private var singleTrackView: SingleTrackView?

    var isPaused: Bool? {
        willSet(isPaused) {
            guard let isPaused = isPaused else { return }
            singleTrackView?.setTrackCondition(isPaused: isPaused)
        }
    }

    var data: TrackData? {
        willSet(data) {
            guard let data = data else { return }
            AudioObserver.shared.viewWithSlider = self
            singleTrackView = SingleTrackView(frame: self.view.frame)
            singleTrackView?.delegate = self
            singleTrackView?.setTrackName(text: data.name)
            singleTrackView?.setSingerName(text: data.artists[0].name)
            singleTrackView?.setSliderMaxValue(maxValue: MainHelper.FloatConstant.previewDurationInMilliseconds.rawValue)
            self.view = singleTrackView
            guard data.imagesURLs.count != 0, let imageURL = URL(string: data.imagesURLs[0]) else { return }
            self.singleTrackView?.setTrackImage(imageURL: imageURL)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
    }

    override func viewDidDisappear(_ animated: Bool) {
        guard let isPaused = isPaused else {
            return
        }
//        if isPaused {
//            AudioObserver.shared.pauseTrack()
//        } else {
//            AudioObserver.shared.playTrack()
//        }
        self.playButtonTapped(isPaused: isPaused)
    }
}

extension SingleTrackViewController: SingleTrackViewDelegate {

    func sliderDidTap() {
        AudioObserver.shared.pauseTrack()
    }

    func playButtonTapped(isPaused: Bool) {
        self.isPaused = isPaused
        delegate?.playButtonTapped(isPaused: isPaused)
    }

    func sliderValueChanged(newValue value: Float) {
        isPaused = false
        AudioObserver.shared.changeTrackCurrentTime(newValue: value)
        AudioObserver.shared.playTrack()
    }
}

extension SingleTrackViewController: ObservingAudioObjectProtocol {

    func observableValueDidChange(newValue: Float) {
        singleTrackView?.setSliderCurrentValue(newValue: newValue)
    }
}

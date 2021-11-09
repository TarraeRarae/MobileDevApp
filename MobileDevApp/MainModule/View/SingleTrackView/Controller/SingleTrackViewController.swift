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
            singleTrackView?.delegate = self
            singleTrackView?.setTrackCondition(isPaused: isPaused)
        }
    }
    var viewModel: TrackOverviewViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            singleTrackView = SingleTrackView(frame: self.view.frame)
            singleTrackView?.setTrackName(text: viewModel.trackName)
            singleTrackView?.setSingerName(text: viewModel.artistsNames[0])
            self.view = singleTrackView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
    }
}

extension SingleTrackViewController: SingleTrackViewDelegate {

    func updateTrackCondition(isPaused: Bool) {
        delegate?.updateTrackCondition(isPaused: isPaused)
    }
}

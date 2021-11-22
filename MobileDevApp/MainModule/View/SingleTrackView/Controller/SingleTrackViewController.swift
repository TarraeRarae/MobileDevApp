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

    var data: TrackData? {
        willSet(data) {
            guard let data = data else { return }
            singleTrackView = SingleTrackView(frame: self.view.frame)
            singleTrackView?.setTrackName(text: data.name)
            singleTrackView?.setSingerName(text: data.artists[0].name)
            self.view = singleTrackView
            if let storedImagesData = data.storedImagesData {
                self.singleTrackView?.setTrackImage(image: UIImage(data: storedImagesData[1]))
                return
            }
            DispatchQueue.global().async {
                guard let data = self.data, let imageData = data.getImageData(from: data.imagesURLs[2]) else { return }
                DispatchQueue.main.async {
                    self.singleTrackView?.setTrackImage(image: UIImage(data: imageData))
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
    }
}

extension SingleTrackViewController: SingleTrackViewDelegate {

    func playButtonTapped(isPaused: Bool) {
        delegate?.playButtonTapped(isPaused: isPaused)
    }
}

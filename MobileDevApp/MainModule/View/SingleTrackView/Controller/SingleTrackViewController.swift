//
//  SingleTrackViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 03.11.2021.
//

import UIKit

class SingleTrackViewController: UIViewController {

    private var singleTrackView: SingleTrackView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        singleTrackView = SingleTrackView(frame: self.view.frame)
        self.view = singleTrackView
    }
}
